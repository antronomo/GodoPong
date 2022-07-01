extends Node 

var winner : String setget set_winner, get_winner
var score1 : int = 0
var score2 : int = 0

export var final_score : int = 3

onready var initial_spd : int = $Ball.spd
onready var initial_pos_char1 : Vector2 = $Char1.position
onready var initial_pos_char2 : Vector2 = $Char2.position
onready var game_size : Vector2 = $ColorRect.rect_size	#Creo que hay una variable, algo así como screen_size,

func _ready() -> void:
	#Asignar a los personajes si van a ser controlados por jugadores o por el bot
	# GlobalSettings.connect("char1_toggled", self, "_on_char1_toggled")
	var indice1 : int  = Save.game_data.char1_mode
	_on_char1_toggled(indice1)
	$Char1.set_can_move(true)
	$C1Controllers.visible = true if indice1 == 0 else false

	# GlobalSettings.connect("char2_toggled", self, "_on_char2_toggled")
	var indice2 = Save.game_data.char2_mode
	_on_char2_toggled(indice2)
	$Char2.set_can_move(true)
	$C2Controllers.visible = true if indice2 == 0 else false

	$SpaceBar.visible = false if indice1 == 1 && indice2 == 1 else true

	#Esconder el menú de pausa
	$PauseMenu.visible = false

	#Score, cambiar más adelante para que se puede configurar desde ajustes
	if final_score <= 0: 
		final_score = 3
	
	#Cosas de la pelota
	$Ball.position = game_size / 2

func _on_char1_toggled(value : int) -> void:
	$Char1.c_name = "player1" if value == 0 else "bot"
	
func _on_char2_toggled(value : int) -> void:
	$Char2.c_name = "player2" if value == 0 else "bot"

#Señal 'body_exited' de wall_left y wall_right
func body_exited(body : Node) -> void:
	if body == $Ball:
		if body.position.x < game_size.x / 2:
			score2 += 1
			$Container/Char2_score.text = str(score2)
			body.initial_direction(1)
		elif body.position.x > game_size.x / 2:
			score1 += 1
			$Container/Char1_score.text = str(score1)
			body.initial_direction(0)

		body.set_can_move(false)
		body.position = game_size / 2
		body.spd = initial_spd

		check_score()

	$Char1.position = initial_pos_char1
	$Char2.position = initial_pos_char2

func check_score() -> void:
	if(score1 == final_score):
		set_winner($Char1.c_name)
	if(score2 == final_score):
		set_winner($Char2.c_name)

func set_winner(new_winner : String) -> void:
	winner = new_winner
	game_over()

func get_winner() -> String:
	return winner

#No se hacer funcionar la señal "about_to_show()"
func game_over() -> void:
	$PauseMenu.queue_free()
	$GameOverScreen/CenterContainer/VBoxContainer/WhoIsTheWinner.text = get_winner().to_upper()
	$GameOverScreen/CenterContainer/VBoxContainer/MainMenuButton.grab_focus()
	$GameOverScreen.show()

func _on_PrincipalMenu_pressed():
	get_tree().change_scene("res://UI/Principal_menu.tscn")

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://UI/Principal_menu.tscn")

#Esto es para esconder el "tutorial rápido sobre los controles"
func _input(event) -> void:
	if event.is_action_pressed("player1_up") || event.is_action_pressed("player1_down"):
		$C1Controllers.visible = false

	if event.is_action_pressed("player2_up") || event.is_action_pressed("player2_down"):
		$C2Controllers.visible = false

	if event.is_action_pressed("ui_accept"):
		$SpaceBar.visible = false

func _process(_delta) -> void:
	if winner == "":
		if Input.is_action_just_pressed("ui_accept"):
			$Ball.set_can_move(true)

		if $Char1.c_name == "bot" && $Char1.c_name == $Char2.c_name:
			$Ball.set_can_move(true)

	else:
		$Char1.set_can_move(false)
		$Char2.set_can_move(false)
		$Ball.set_can_move(false)
