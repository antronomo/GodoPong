extends Node 

var final_score : int = 0
var winner : String setget set_winner, get_winner

onready var initial_spd : int = $Ball.spd
onready var initial_pos_char1 : Vector2 = $Char1.position
onready var initial_pos_char2 : Vector2 = $Char2.position
onready var game_size : Vector2 = $ColorRect.rect_size

var score1 : int = 0
var score2 : int = 0

func _ready() -> void:
	if final_score == 0: final_score = 3 
	$Ball.position = game_size / 2

func _on_Wall_left_body_exited(body:Node) -> void:
	body_exited(body)

func _on_Wall_right_body_exited(body:Node) -> void:
	body_exited(body)

func body_exited(body:Node) -> void:
	if body == $Ball:
		if body.position.x < game_size.x /2:
			score2 += 1
			$Container/Char2_score.text = str(score2)
			body.initial_direction(1)
		elif body.position.x > game_size.x /2:
			score1 += 1
			$Container/Char1_score.text = str(score1)
			body.initial_direction(0)
		$Char1.position = initial_pos_char1
		$Char2.position = initial_pos_char2
		body.position = game_size / 2
		body.spd = initial_spd
		check_score()
	else:
		body.queue_free()

func check_score() -> void: #Terminar, se supone que lanza un ganador cuando uno de ellos alcanza el objetivo 
	if(score1 == final_score):
		set_winner($Char1.c_name)
	if(score2 == final_score):
		set_winner($Char2.c_name)

func set_winner(new_winner : String) -> void:
	winner = new_winner

func get_winner() -> String:
	return winner
		
"""
aplicar puntiaciones por 'gol'
aplicar efecto de destrucción de la pelota al marcar 'gol'
aplicar sistema de particulas a la pelota, jugadores, los bordes del campo y en la mitad del mismo
tabla de puntiaciones con la siguiente mecánica:
		cada vez que rebote la pelota esa puntuación sube 10pts.
		cuando alguien mete 'gol' recibe todos esos puntos
		la partida SIEMPRE acaba cuando uno de los jugadores llega a X(variable) 'goles' y el ganador se queda con el total de los puntos
		al final de la partida, puedes grabar en el hall con tus puntos y 3 caracteres (A-Z)
añadir menú:
		4 botones, uno para jugar, otro para ajustar los jugadores (si van a ser jugadores o bots, color de cada uno y el color de la pelota), otro para desplegar el tutorial (que explica muy básicamente qué es este juego y cómo se juega) y el útimo para ver el Hall 
"""


func _on_Ball_stop():
	pass # Replace with function body.
