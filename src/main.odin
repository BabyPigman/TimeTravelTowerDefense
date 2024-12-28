package main

import rl "vendor:raylib"

main :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(1280, 720, "Time Travel Tower Defense")
    rl.SetTargetFPS(60)

    fontTtf := rl.LoadFontEx("res/JetBrainsMono-VariableFont_wght.ttf", 32, nil, 0)
    LoadGameTextures()

    for !rl.WindowShouldClose()
    {
        rl.BeginDrawing()
        rl.ClearBackground({40, 40, 40, 255})
        
        rl.DrawTexture(loadedTexture.backgroundPast[0], 0, 0, {255, 255, 255, 255})
        rl.DrawTextEx(fontTtf, "Let's see if fonts work", {190, 200}, f32(fontTtf.baseSize), 2, {240, 240, 240, 255})

        rl.EndDrawing()
    }

    rl.UnloadFont(fontTtf)

    rl.CloseWindow()
}