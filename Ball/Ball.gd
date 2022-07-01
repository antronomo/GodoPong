extends KinematicBody2D

onready var can_move : bool = false setget set_can_move, get_can_move

var spd : int = 300
var vel : Vector2 = Vector2.ZERO

func _ready() -> void:
	randomize()
	vel = initial_direction(randi() % 2)

func movement(delta) -> void:
	vel = vel.normalized() * spd * delta
	var collision : KinematicCollision2D = move_and_collide(vel)	

	if collision:
		spd += 10
		vel = vel.bounce(collision.normal)

func initial_direction(come_from : int) -> Vector2:
	vel.x = [-1, 1] [come_from]
	vel.y = [-0.8, 0.8] [randi() % 2]
	return vel

func set_can_move(may_i : bool) -> void:
	can_move = may_i

func get_can_move() -> bool:
	return can_move

func _physics_process(delta) -> void:
	if can_move:
		movement(delta)
