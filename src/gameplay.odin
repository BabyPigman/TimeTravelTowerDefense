package main

import rl "vendor:raylib"

GetMouseX :: proc() -> i32 {
    return i32(f32(rl.GetMouseX()) / camera.zoom)
}

GetMouseY :: proc() -> i32 {
    return i32(f32(rl.GetMouseY()) / camera.zoom)
}

setTimer :: proc(timer : ^f32, time : f32) {
    timer^ = time
}

coordToPosition :: proc(coord : rl.Vector2) -> rl.Vector2 {
    return {coord.x * TILE_SIZE, coord.y * TILE_SIZE}
}

positionToCoord :: proc(position: rl.Vector2) -> rl.Vector2 {
    return {position.x / TILE_SIZE, position.y / TILE_SIZE}
}

MoveEnemy :: proc(enemy: ^Enemy) {
    targetPos := enemy.target
    currPos := enemy.position
    direction := GetDirectionFromTarget(currPos, targetPos)
    enemy.position += direction * f32(enemy.speed)
}

GetDirectionFromTarget :: proc(currPos, targetPos : rl.Vector2) -> rl.Vector2 {
    return rl.Vector2Normalize(targetPos - currPos)
}