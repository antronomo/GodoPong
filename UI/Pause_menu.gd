extends Control

var is_paused : bool = false setget set_is_paused, get_is_paused

onready var anim = $PauseAnimationPlayer

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		set_is_paused(!get_is_paused())

func set_is_paused(value : bool) -> void:
	if value == true:
		anim.play("PauseIn")
		$CenterContainer/VBoxContainer/ContinueButton.grab_focus()
	elif value == false:
		anim.play("PauseOut")
		$CenterContainer/VBoxContainer/ContinueButton.release_focus()
		$CenterContainer/VBoxContainer/ExitButton.release_focus()

	is_paused = value

func get_is_paused() -> bool:
	return is_paused

func le_pausar():
	get_tree().paused = is_paused

func _on_ContinueButton_pressed() -> void:
	set_is_paused(false)

func _on_ExitButton_pressed() -> void:
	set_is_paused(false)
	le_pausar()
	get_tree().change_scene("res://UI/Main_menu.tscn")
