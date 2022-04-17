extends KinematicBody2D

var screen_size : Vector2
var vel : Vector2 = Vector2.ZERO

onready var ball = get_parent().find_node("Ball")

export var spd : int = 500
export var p_name : String = "none"

func _ready() -> void:
	print(p_name)
	if p_name == "player1" : 
		print("soy un jugador: " + p_name)
	elif p_name == "player2" :
		print("soy un jugador: " + p_name)
	else : 
		print("no soy un jugador: " + p_name)

func movement(delta) -> void:
	vel.y = Input.get_action_strength(p_name + "_down") - Input.get_action_strength(p_name + "_up")
	#vel = vel.normalized() 
	move_and_collide(vel * spd * delta)	

func bot_movement(delta) -> void:
	if abs(ball.position.y - position.y) > 25:
		if ball.position.y > position.y: vel.y = 1
		else: vel.y = -1
	else: vel.y = 0
	move_and_slide(vel * spd)

func _physics_process(delta):
	match p_name:
			"player1":
				movement(delta)
			"player2":
				movement(delta)
			"bot":
				bot_movement(delta)
	