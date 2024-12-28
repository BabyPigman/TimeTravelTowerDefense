package main

import rl "vendor:raylib"
import "core:strings"

GameTextures :: struct{
    background : [3]rl.Texture2D,
    enemies : [5]rl.Texture2D,
    pastTowers : [4]rl.Texture2D,
    futureTowers : [4]rl.Texture2D, 
}

loadedTexture : GameTextures

LoadGameTextures :: proc(){
    path : cstring
    for i in 0..<3{
        path = strings.clone_to_cstring("res//levels//level" + i) //Convert int to string how???!??!??!??!??!??!??!??!?!?!?!??!?!?!?!!??!?!?!?!?!?!?!?!?!?
        loadedTexture.background[i] = rl.LoadTexture(path)
    }
}

RenderBackground :: proc(){

}