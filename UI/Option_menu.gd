extends Control

var nameChar1 : String = "" setget set_nameChar1, get_nameChar1
var CH1_color

var nameChar2 : String = "" setget set_nameChar2, get_nameChar2
var CH2_color

var Ball_color : Vector3 = Vector3(255,0,0)

func _on_CharCN2_toggled(button_pressed : bool) -> void:
    if button_pressed: 
        set_nameChar1("player1")
    else:
        set_nameChar1("bot")

func _on_CharCN1_toggled(button_pressed : bool) -> void:
    if button_pressed: 
        set_nameChar2("player2")
    else:
        set_nameChar2("bot")

func set_nameChar1(newName : String) -> void:
    nameChar1 = newName
    print("Character1 set as " + nameChar1)

func get_nameChar1() -> String:
    return nameChar1

func set_nameChar2(newName : String) -> void:
    nameChar2 = newName
    print("Character2 set as " + nameChar2)

func get_nameChar2() -> String:
    return nameChar2

func _on_PrincipalMenuButton_pressed():
    get_tree().change_scene("res://UI/Principal_menu.tscn")
