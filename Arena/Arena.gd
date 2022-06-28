extends Node 

var winner : String setget set_winner, get_winner
var score1 : int = 0
var score2 : int = 0

export var final_score : int = 3

onready var initial_spd : int = $Ball.spd
onready var initial_pos_char1 : Vector2 = $Char1.position
onready var initial_pos_char2 : Vector2 = $Char2.position
onready var game_size : Vector2 = $ColorRect.rect_size

func _ready() -> void:

	GlobalSettings.connect("char1_toggled", self, "_on_char1_toggled")
	GlobalSettings.connect("char2_toggled", self, "_on_char2_toggled")
	var indice1 = Save.game_data.char1_mode
	var indice2 = Save.game_data.char2_mode
	print(indice1)
	print(indice2)

	_on_char1_toggled(indice1)
	_on_char2_toggled(indice2)

	if final_score <= 0: 
		final_score = 3

	$Ball.position = game_size / 2

	$Char1.set_can_move(true)

	$Char2.set_can_move(true)

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

		$Char1.position = initial_pos_char1
		$Char2.position = initial_pos_char2
		
		body.position = game_size / 2
		body.spd = initial_spd
		check_score()

func check_score() -> void:
	if(score1 == final_score):
		set_winner($Char1.c_name)
	if(score2 == final_score):
		set_winner($Char2.c_name)
	$Ball.set_can_move(false)

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

func _process(_delta) -> void:
	if winner == "":

		if Input.is_action_just_pressed("ui_accept"):
			$Ball.set_can_move(true)

		if $Char1.c_name == "bot" && $Char1.c_name == $Char2.c_name:
			$Ball.set_can_move(true)

	else:

		$Char1.set_can_move(false)
		$Char2.set_can_move(false)

"""
aplicar efecto de destrucción de la pelota al marcar 'gol'
aplicar sistema de particulas a la pelota, jugadores, los bordes del campo y en la mitad del mismo
tabla de puntiaciones con la siguiente mecánica:
		cada vez que rebote la pelota esa puntuación sube 10pts.
		cuando alguien mete 'gol' recibe todos esos puntos
		la partida SIEMPRE acaba cuando uno de los jugadores llega a X(variable) goles y el ganador se queda con el total de los puntos
		al final de la partida, puedes grabar en el hall o Score Board con tus puntos y 3 caracteres (A-Z y 0-9)
añadir menú:
		4 botones, uno para jugar, otro para ajustar los jugadores (si van a ser jugadores o bots, color de cada uno y el color de la
		pelota), otro para desplegar el tutorial (que explica muy básicamente qué es este juego y cómo se juega) y el útimo para ver el 
		Hall 
"""
