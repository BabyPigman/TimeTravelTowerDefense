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

RenderPlacingTower :: proc(towers : [dynamic]Tower) {
    if gameState.isPlacing
    {
        // tower radius
        rl.DrawCircle(GetMouseX(), GetMouseY(), 9, {0, 0, 0, 100})
        // all other radii
        for tower in towers {
            rl.DrawCircleV(tower.position, 9, {0, 0, 0, 100})
        }
        
        // tower texture
        if gameState.isPast
        {
            rl.DrawTexture(loadedTexture.towersPast[gameState.selectedTower], GetMouseX() - (TILE_SIZE / 2), GetMouseY() - (TILE_SIZE / 2), {255, 255, 255, 255})
        }
        else
        {
            rl.DrawTexture(loadedTexture.towersFuture[gameState.selectedTower], GetMouseX() - (TILE_SIZE / 2), GetMouseY() - (TILE_SIZE / 2), {255, 255, 255, 255})
        }

        // tower range
        rl.DrawCircleLines(GetMouseX(), GetMouseY(), 48, {255, 255, 255, 255})
    }
}

RenderPlacedTowers :: proc(towers : [dynamic]Tower) {
    for tower in towers {
        if gameState.isPast
        {
            rl.DrawTextureV(loadedTexture.towersPast[tower.type], {tower.position.x - (TILE_SIZE / 2), tower.position.y - (TILE_SIZE / 2)}, {255, 255, 255, 255})
        }
        else
        {
            rl.DrawTextureV(loadedTexture.towersFuture[tower.type], {tower.position.x - (TILE_SIZE / 2), tower.position.y - (TILE_SIZE / 2)}, {255, 255, 255, 255})
        }
    }
}

RenderEnemies :: proc (enemies : [dynamic]Enemy) {
    for enemy in enemies {
        if gameState.isPast
        {
            if enemy.type == .Warrior || enemy.type == .Berserker
            {
                rl.DrawTextureV(loadedTexture.enemies[enemy.type], {enemy.position.x - (TILE_SIZE / 2), enemy.position.y - (TILE_SIZE / 2)}, rl.WHITE)
            }
        }
        else
        {
            if enemy.type == .Drone || enemy.type == .Robot
            {
                rl.DrawTextureV(loadedTexture.enemies[enemy.type], {enemy.position.x - (TILE_SIZE / 2), enemy.position.y - (TILE_SIZE / 2)}, rl.WHITE)
            }
        }
    }
}