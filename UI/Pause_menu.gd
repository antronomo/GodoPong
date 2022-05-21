extends Control

var is_paused : bool = false setget set_is_paused

func _ready() -> void:
	self.is_paused = false

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		$CenterContainer/VBoxContainer/Continue.grab_focus()
		self.is_paused = !is_paused

func set_is_paused(value : bool) -> void:
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_Continue_pressed() -> void:
	self.is_paused = false

func _on_Exit_pressed() -> void:
	self.is_paused = false
	get_tree().change_scene("res://UI/Principal_menu.tscn")
