extends KinematicBody2D

onready var ball = get_parent().find_node("Ball")
onready var s_size = get_parent().find_node("ColorRect")
onready var can_move : bool = false setget set_can_move, get_can_move

export var spd : int = 500
export var c_name : String = "none"

var screen_size : Vector2
var vel : Vector2 = Vector2.ZERO

func _ready() -> void:
	if c_name == "": queue_free()

func player_movement(delta) -> void:
	vel.y = Input.get_action_strength(c_name + "_down") - Input.get_action_strength(c_name + "_up")
	move_and_collide(vel * spd * delta)	

func bot_movement(delta) -> void:
	vel.y = 0
	if abs(ball.position.x - position.x) < s_size.rect_size.x / 2:
		if abs(ball.position.y - position.y) > 25:
			if ball.position.y > position.y:
				vel.y = 1
			else:
				vel.y = -1
	move_and_collide(vel * spd * delta)

func set_can_move(may_i : bool) -> void:
	can_move = may_i

func get_can_move() -> bool:
	return can_move

func _physics_process(delta) -> void:
	if can_move:
		match c_name:
			"player1":
				player_movement(delta)
			"player2":
				player_movement(delta)
			"bot":
				bot_movement(delta)
				