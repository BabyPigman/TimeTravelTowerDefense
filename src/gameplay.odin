package main

import rl "vendor:raylib"

GetMouseX :: proc() -> i32 {
    return i32(f32(rl.GetMouseX()) / camera.zoom)
}

GetMouseY :: proc() -> i32 {
    return i32(f32(rl.GetMouseY()) / camera.zoom)
}