extends KinematicBody2D

var screen_size : Vector2
var vel : Vector2 = Vector2.ZERO

onready var ball = get_parent().find_node("Ball")
onready var s_size = get_parent().find_node("ColorRect")

export var spd : int = 500
export var c_name : String = "none"

func _ready() -> void:
	if c_name == null: queue_free()

func movement(delta) -> void:
	vel.y = Input.get_action_strength(c_name + "_down") - Input.get_action_strength(c_name + "_up")
	move_and_collide(vel * spd * delta)	

func bot_movement() -> void:
	vel.y = 0
	if abs(ball.position.x - position.x) < s_size.rect_size.x / 2:
		if abs(ball.position.y - position.y) > 25:
			if ball.position.y > position.y:
				vel.y = 1
			else:
				vel.y = -1
	move_and_slide(vel * spd)

func _physics_process(delta):
	match c_name:
		"player1":
			movement(delta)
		"player2":
			movement(delta)
		"bot":
			bot_movement()
