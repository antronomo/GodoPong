extends KinematicBody2D

var screen_size : Vector2
var vel : Vector2 = Vector2.ZERO

export var spd : int = 500
export var P_NAME : String = "none"

func _ready() -> void:

	#screen_size = get_viewport_rect().size
	#print(P_NAME)
	pass

func movement(delta) -> void:

	vel.y = Input.get_action_strength(P_NAME + "_down") - Input.get_action_strength(P_NAME + "_up")
	vel = vel.normalized() * spd * delta
	move_and_collide(vel)

func _physics_process(delta) -> void:

	movement(delta)
	
