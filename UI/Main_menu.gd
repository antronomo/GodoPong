extends Control

func _ready() -> void:
	$CenterContainer/VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Arena/Arena.tscn")
		
func _on_SettingsButton_pressed() -> void:
	get_tree().change_scene("res://UI/SettingsMenu.tscn")

func _on_ScoreButton_pressed() -> void:
	pass # Replace with function body.
		
func _on_QuitButton_pressed() -> void:
	get_tree().quit()

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if $CenterContainer/VBoxContainer/QuitButton.disabled == false:
			get_tree().quit()
