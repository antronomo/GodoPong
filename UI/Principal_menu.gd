extends Control

#Esto existe para que la consola no de avertencias
var ce : int

func _ready() -> void:
	$CenterContainer/VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed() -> void:
	ce = get_tree().change_scene("res://Arena/Arena.tscn")
		
func _on_SettingsButton_pressed():
	pass # Replace with function body.

func _on_ScoreButton_pressed() -> void:
	pass # Replace with function body.
		
func _on_QuitButton_pressed() -> void:
	get_tree().quit()

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()



