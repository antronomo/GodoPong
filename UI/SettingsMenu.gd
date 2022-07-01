extends Control

#Character mode
onready var char1_mode_btn = $GridContainer/Character1/Char1Mode
onready var char2_mode_btn = $GridContainer/Character2/Char2Mode

func _ready() -> void:
	char1_mode_btn.select(Save.game_data.char1_mode)
	char2_mode_btn.select(Save.game_data.char2_mode)
	char1_mode_btn.grab_focus()

func _on_Char1Mode_item_selected(index : int) -> void:
	GlobalSettings.toggle_char1_mode(index)

func _on_Char2Mode_item_selected(index : int) -> void:
	GlobalSettings.toggle_char2_mode(index)

func _on_ReturnButton_pressed() -> void:
	exiting()

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		exiting()

func exiting() -> void:
	Save.game_data.char1_mode = char1_mode_btn.selected
	Save.game_data.char2_mode = char2_mode_btn.selected
	Save.save_data()
	get_tree().change_scene("res://UI/Principal_menu.tscn")