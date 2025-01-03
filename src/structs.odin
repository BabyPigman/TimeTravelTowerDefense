package main

import rl "vendor:raylib"

// Path //

Path :: struct {
    points : [dynamic]rl.Vector2,
} 

CreatePath :: proc(points: ..rl.Vector2) -> (Path){
    pointArray := [dynamic]rl.Vector2{}
    for p in points {
        append(&pointArray, p)
    }
    return Path{pointArray}
}

// Enemy //

EnemyType :: enum{Warrior, Drone, Berserker, Robot, Boss}

Enemy :: struct {
    type : EnemyType,
    position : rl.Vector2,
    health : int,
    speed : int,
    path : Path,
    target : rl.Vector2,
    targetIndex : int,
    speedMod : f32,
}

CreateEnemy :: proc(type : EnemyType) -> (Enemy){
    //Set the default values here
    switch type {
        case EnemyType.Warrior:
            return Enemy{}
        case EnemyType.Drone:
            return Enemy{}
        case EnemyType.Berserker:
            return Enemy{}
        case EnemyType.Robot:
            return Enemy{}
        case EnemyType.Boss:
            return Enemy{}
    }
    //Should never get to this point
    return Enemy{}
}

// Tower //

TowerType :: enum {Basic, Power, AOE, Chronomancy}

Tower :: struct {
    type : TowerType,
    position : rl.Vector2,
    range : int,
    needPower : bool,
    hasPower : bool,
    damage : int,
    cooldown: int,
    maxCooldown: int,
}

// Projectile //

ProjectileType :: enum {Arrow, Laser, Lightning}

Projectile :: struct {
    type : ProjectileType,
    position : rl.Vector2,
}

// Gameplay //

GameState :: struct {
    currentLevel : i8,
    isPast : bool,
    selectedTower : TowerType,
    isPlacing : bool
}