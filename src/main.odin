package main

import rl "vendor:raylib"
import "core:fmt"

camera : rl.Camera2D = {
    zoom = 2.0
}

gameState : GameState = {
    currentLevel = 1,
    isPast = true,
    selectedTower = nil,
    isPlacing = false
}

TILE_SIZE :: 16

main :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(1820, 1024, "TimeWars: TD")
    rl.SetTargetFPS(60)

    fontTtf := rl.LoadFontEx("res/JetBrainsMono-VariableFont_wght.ttf", 32, nil, 0)
    LoadGameTextures()

    towers : [dynamic]Tower
    enemies : [dynamic]Enemy

    spawn_timer_past : f32 = 1
    spawn_timer_future : f32 = 2

    path := CreatePath( // im so sorry //hehe hardcoding my beloved <3
        {0, 13},
        {5, 13},
        {5, 4},
        {10, 4},
        {10, 27},
        {26, 27},
        {26, 22},
        {15, 22},
        {15, 17},
        {20, 17},
        {20, 12},
        {30, 12}
    )

    for !rl.WindowShouldClose()
    {
        // Handle input
        if rl.IsKeyPressed(.SPACE)
        {
            gameState.isPast = !gameState.isPast
        }
        else if rl.IsKeyPressed(.ONE)
        {
            gameState.isPlacing = true
            gameState.selectedTower = .Basic
        }
        else if rl.IsKeyPressed(.TWO)
        {
            gameState.isPlacing = true
            gameState.selectedTower = .Power
        }
        else if rl.IsKeyPressed(.THREE)
        {
            gameState.isPlacing = true
            gameState.selectedTower = .AOE
        }
        else if rl.IsKeyPressed(.FOUR)
        {
            gameState.isPlacing = true
            gameState.selectedTower = .Chronomancy
        }
        else if rl.IsMouseButtonPressed(.LEFT)
        {
            mousePos : [2]f32 = { f32(GetMouseX()), f32(GetMouseY()) }
            // check you're not overlapping a tower
            for tower in towers {
                if rl.Vector2DistanceSqrt(mousePos, tower.position) < 320 // why is it 320? God only knows
                {
                    gameState.isPlacing = false
                }
            }

            // TODO: check you're not overlapping the path

            if gameState.isPlacing
            {
                gameState.isPlacing = false
                newTower : Tower = {
                    type = gameState.selectedTower,
                    position = {f32(GetMouseX()), f32(GetMouseY())},
                    range = 48,
                    needPower = false,
                    hasPower = false,
                    damage = 40
                }
                append(&towers, newTower)
            }
        }

        // Handle enemies
        // Spawn
        spawn_timer_past -= rl.GetFrameTime()
        spawn_timer_future -= rl.GetFrameTime()

        if spawn_timer_past <= 0 {
            setTimer(&spawn_timer_past, 1)
            newEnemy : Enemy = {
                type = .Warrior,
                position = coordToPosition(path.points[0]),
                health = 100,
                speed = 1,
                path = path,
                targetIndex = 0,
                target = coordToPosition(path.points[0])
            }
            // ordered_remove(newEnemy.path.points, 0)  // does god know why this doesn't work?
            append(&enemies, newEnemy)
        }
        if spawn_timer_future <= 0 {
            setTimer(&spawn_timer_future, 1)
            newEnemy : Enemy = {
                type = .Drone,
                position = coordToPosition(path.points[0]),
                health = 100,
                speed = 1,
                path = path,
                targetIndex = 0,
                target = coordToPosition(path.points[0])
            }
            append(&enemies, newEnemy)
        }

        for &enemy in enemies {
            if rl.Vector2Distance(enemy.position, enemy.target) < 2 // switch to distance squared for performance?
            {
                enemy.position = enemy.target
                enemy.targetIndex += 1
                enemy.target = coordToPosition(enemy.path.points[enemy.targetIndex])
            }
            MoveEnemy(&enemy)
        }

        // Render
        rl.BeginDrawing()
        rl.ClearBackground({36, 79, 85, 255} if gameState.isPast else {33, 23, 41, 255})
        
        rl.BeginMode2D(camera)

        RenderBackground(gameState.currentLevel, gameState.isPast)
        RenderPlacedTowers(towers)
        RenderPlacingTower(towers)
        RenderEnemies(enemies)

        // rl.DrawTextEx(fontTtf, "Let's see if fonts work", {190, 200}, f32(fontTtf.baseSize), 2, {240, 240, 240, 255})  

        rl.EndMode2D()

        rl.EndDrawing()
    }

    rl.UnloadFont(fontTtf)

    rl.CloseWindow()
}