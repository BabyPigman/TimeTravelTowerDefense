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
    target : int,
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
    radius : int,
}