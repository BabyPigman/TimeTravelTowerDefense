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
            if gameState.isPlacing
            {
                gameState.isPlacing = false
                if gameState.isPast
                {
                    
                }
                else
                {

                }
            }
        }

        rl.BeginDrawing()
        rl.ClearBackground({40, 40, 40, 255})
        
        rl.BeginMode2D(camera)

        RenderBackground(gameState.currentLevel, gameState.isPast)
        RenderPlacingTower()

        // rl.DrawTextEx(fontTtf, "Let's see if fonts work", {190, 200}, f32(fontTtf.baseSize), 2, {240, 240, 240, 255})  

        rl.EndMode2D()

        rl.EndDrawing()
    }

    rl.UnloadFont(fontTtf)

    rl.CloseWindow()
}