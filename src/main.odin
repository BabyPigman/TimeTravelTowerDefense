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

    for !rl.WindowShouldClose()
    {
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

        rl.BeginDrawing()
        rl.ClearBackground({36, 79, 85, 255} if gameState.isPast else {33, 23, 41, 255})
        
        rl.BeginMode2D(camera)

        RenderBackground(gameState.currentLevel, gameState.isPast)
        RenderPlacedTowers(towers)
        RenderPlacingTower(towers)

        // rl.DrawTextEx(fontTtf, "Let's see if fonts work", {190, 200}, f32(fontTtf.baseSize), 2, {240, 240, 240, 255})  

        rl.EndMode2D()

        rl.EndDrawing()
    }

    rl.UnloadFont(fontTtf)

    rl.CloseWindow()
}