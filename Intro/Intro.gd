extends Node

onready var goTop = $GodotPanel/GodotLogo/GodotLogoTop
onready var goBot = $GodotPanel/GodotLogo/GodotLogoBottom
onready var ball = $GodotPanel/Ball
onready var skipLabel = $SkipLabel

func _ready():
	ball.vel = Vector2(1,-1)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if skipLabel.visible:
			get_tree().change_scene("res://UI/Main_menu.tscn")

	if !skipLabel.visible:
		skipLabel.visible = true
		$LaberHider.start()

func _on_LaberHider_timeout():
	skipLabel.visible = false

func _on_AnimationPlayer_animation_finished(anim_name : String):
	if anim_name == "MovingGodotLogo":
		get_tree().change_scene("res://UI/Main_menu.tscn")

func _physics_process(_delta):
	if ball.collision:
		goTop.rotation_degrees -= 20
		goBot.rotation_degrees += 20
		goTop.frame += 1
		$AnimationPlayer.play("MovingGodotLogo")
