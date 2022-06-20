extends Control

var is_paused : bool = false setget set_is_paused, get_is_paused

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		set_is_paused(!get_is_paused())

func set_is_paused(value : bool) -> void:
	if value == true:
		$CenterContainer/VBoxContainer/Continue.grab_focus()
	get_tree().paused = value
	visible = value
	is_paused = value

func get_is_paused() -> bool:
	return is_paused

func _on_Continue_pressed() -> void:
	set_is_paused(false)

func _on_Exit_pressed() -> void:
	set_is_paused(false)
	get_tree().change_scene("res://UI/Principal_menu.tscn")