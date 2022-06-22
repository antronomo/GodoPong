extends Control

#Character mode
onready var char1_mode_btn = $GridContainer/Character1/Char1Mode
onready var char2_mode_btn = $GridContainer/Character2/Char2Mode

#Esto existe para que la consola no de avertencias
var ce : int

func _ready() -> void:
	char1_mode_btn.grab_focus()

func _on_Char1Mode_item_selected(index : int):
	GlobalSettings.char1_mode(index)

func _on_Char2Mode_item_selected(index : int):
	GlobalSettings.char2_mode(index)

func _on_ReturnButton_pressed():
	ce = get_tree().change_scene("res://UI/Principal_menu.tscn")
