extends KinematicBody2D

onready var can_move : bool = false setget set_can_move, get_can_move

var spd : int = 300
var vel : Vector2 = Vector2.ZERO
var collision : KinematicCollision2D

export var difenecial : float = 0.05
export var multiplicador : float = 8

func _ready() -> void:
	randomize()
	vel = initial_direction(randi() % 2)

func movement(delta) -> void:
	if collision:
		spd += 10
		vel = vel.bounce(collision.normal)

		if abs(vel.x) <= abs(vel.y * difenecial): 
			vel.x *= multiplicador * sign(vel.x) if vel.x != 0.0 else 1.0

		if abs(vel.y) <= abs(vel.x * difenecial): 
			vel.y *= multiplicador * sign(vel.y) if vel.y != 0.0 else 1.0

	vel = vel.normalized() * spd * delta

	collision = move_and_collide(vel)

func initial_direction(come_from : int) -> Vector2:
	vel.x = [-1, 1] [come_from]
	vel.y = 0.8 * [-1, 1] [randi() % 2]
	return vel

func set_can_move(may_i : bool) -> void:
	can_move = may_i

func get_can_move() -> bool:
	return can_move

func _physics_process(delta) -> void:
	if can_move:
		movement(delta)
