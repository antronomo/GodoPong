extends Node 

onready var initial_spd : int = $Ball.spd
onready var initial_pos_char1 : Vector2 = $Char1.position
onready var initial_pos_char2 : Vector2 = $Char2.position
onready var game_size : Vector2 = $ColorRect.rect_size

func _ready() -> void:
	$Ball.position = game_size / 2

func _on_Wall_left_body_exited(body:Node) -> void:
	#Hacer que el jugador de la derecha adquiera un punto
	body_exited(body)

func _on_Wall_right_body_exited(body:Node) -> void:
	#Hacer que el jugador de la izquierda adquiera un punto
	body_exited(body)

func body_exited(body:Node) -> void:
	if body == $Ball:
		if body.position.x < game_size.x /2:
			body.initial_direction(0)
		else:
			body.initial_direction(1)
		$Char1.position = initial_pos_char1
		$Char2.position = initial_pos_char2
		body.position = game_size / 2
		body.spd = initial_spd
	else:
		body.queue_free()
		
