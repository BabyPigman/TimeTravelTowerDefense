package main

import rl "vendor:raylib"
import "core:strings"
import "core:strconv"

GameTextures :: struct{
    backgroundPast : [3]rl.Texture2D,
    backgroundFuture : [3]rl.Texture2D,
    enemies : [5]rl.Texture2D,
    towersPast : [4]rl.Texture2D,
    towersFuture : [4]rl.Texture2D, 
    projectiles : [3]rl.Texture2D
}

loadedTexture : GameTextures

LoadGameTextures :: proc(){
    // path : cstring
    // for i in 0..<3{
    //     path = strings.clone_to_cstring(strings.concatenate({"res//levels//level", strconv.itoa(i)})) //Convert int to string how???!??!??!??!??!??!??!??!?!?!?!??!?!?!?!!??!?!?!?!?!?!?!?!?!?
    //     loadedTexture.background[i] = rl.LoadTexture(path)
    // }

    // Levels
    loadedTexture.backgroundPast[0] = rl.LoadTexture("res/levels/level1_prototype_past.png")
    loadedTexture.backgroundPast[1] = rl.LoadTexture("res/levels/level2_prototype_past.png")
    loadedTexture.backgroundPast[2] = rl.LoadTexture("res/levels/level3_prototype_past.png")

    loadedTexture.backgroundFuture[0] = rl.LoadTexture("res/levels/level1_prototype_future.png")
    loadedTexture.backgroundFuture[1] = rl.LoadTexture("res/levels/level2_prototype_future.png")
    loadedTexture.backgroundFuture[2] = rl.LoadTexture("res/levels/level3_prototype_future.png")

    // Enemies
    loadedTexture.enemies[0] = rl.LoadTexture("res/enemies/enemy_warrior.png")
    loadedTexture.enemies[1] = rl.LoadTexture("res/enemies/enemy_drone.png")
    loadedTexture.enemies[2] = rl.LoadTexture("res/enemies/enemy_berserker.png")
    loadedTexture.enemies[3] = rl.LoadTexture("res/enemies/enemy_robot.png")

    // Towers
    loadedTexture.towersPast[0] = rl.LoadTexture("res/towers/tower_arrow.png")
    loadedTexture.towersPast[1] = rl.LoadTexture("res/towers/tower_construction.png")
    loadedTexture.towersPast[2] = rl.LoadTexture("res/towers/tower_wizard.png")
    loadedTexture.towersPast[3] = rl.LoadTexture("res/towers/tower_time_dilation.png")

    loadedTexture.towersFuture[0] = rl.LoadTexture("res/towers/tower_laser.png")
    loadedTexture.towersFuture[1] = rl.LoadTexture("res/towers/tower_generator.png")
    loadedTexture.towersFuture[2] = rl.LoadTexture("res/towers/tower_wizard_old.png")
    loadedTexture.towersFuture[3] = rl.LoadTexture("res/towers/tower_paradox.png")

    // Projectiles
    loadedTexture.projectiles[0] = rl.LoadTexture("res/projectiles/projectile_arrow.png")
    loadedTexture.projectiles[1] = rl.LoadTexture("res/projectiles/projectile_laser.png")
    loadedTexture.projectiles[2] = rl.LoadTexture("res/projectiles/projectile_lightning.png")
}

RenderBackground :: proc(level : i8, isPast : bool){
    if isPast do rl.DrawTexture(loadedTexture.backgroundPast[level - 1], 0, 0, {255, 255, 255, 255})
    else do      rl.DrawTexture(loadedTexture.backgroundFuture[level - 1], 0, 0, {255, 255, 255, 255})
}

RenderPlacingTower :: proc() {
    if gameState.isPlacing
    {
        rl.DrawCircle(GetMouseX(), GetMouseY(), 9, {0, 0, 0, 100})
        if gameState.isPast
        {
            rl.DrawTexture(loadedTexture.towersPast[gameState.selectedTower], GetMouseX() - (TILE_SIZE / 2), GetMouseY() - (TILE_SIZE / 2), {255, 255, 255, 255})
        }
        else
        {
            rl.DrawTexture(loadedTexture.towersFuture[gameState.selectedTower], GetMouseX() - (TILE_SIZE / 2), GetMouseY() - (TILE_SIZE / 2), {255, 255, 255, 255})
        }
        rl.DrawCircleLines(GetMouseX(), GetMouseY(), 48, {255, 255, 255, 255})
    }
}