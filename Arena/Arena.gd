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
	if final_score <= 0: 
		final_score = 3 
	$Ball.position = game_size / 2
	$Char1.set_can_move(true)
	$Char2.set_can_move(true)

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

func _input(event):
	if event .is_action_pressed("ui_cancel"):
		$PauseMenu.show()

#No se hacer funcionar la señal "about_to_show()"
func game_over() -> void:
	$GameOverScreen/CenterContainer/VBoxContainer/WhoIsTheWinner.text = get_winner().to_upper()
	$GameOverScreen/CenterContainer/VBoxContainer/PrincipalMenu.grab_focus()
	$GameOverScreen.show()

func _on_PrincipalMenu_pressed():
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
		la partida SIEMPRE acaba cuando uno de los jugadores llega a X(variable) 'goles' y el ganador se queda con el total de los puntos
		al final de la partida, puedes grabar en el hall con tus puntos y 3 caracteres (A-Z)
añadir menú:
		4 botones, uno para jugar, otro para ajustar los jugadores (si van a ser jugadores o bots, color de cada uno y el color de la
		pelota), otro para desplegar el tutorial (que explica muy básicamente qué es este juego y cómo se juega) y el útimo para ver el 
		Hall 
"""
