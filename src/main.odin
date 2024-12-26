package main

import rl "vendor:raylib"

main :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(1280, 720, "Time Travel Tower Defense")
    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose()
    {
        rl.BeginDrawing()
        rl.ClearBackground({40, 40, 40, 255})
        
        rl.DrawText("Hi love hope everything is working :3", 190, 200, 20, {240, 240, 240, 255})

        rl.EndDrawing()
    }

    rl.CloseWindow()
}