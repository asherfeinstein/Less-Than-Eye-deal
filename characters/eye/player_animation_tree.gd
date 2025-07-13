extends Node2D

@onready var animationPlayer = $EyeAnimationPlayer
@onready var eye = get_owner()

var nextAnimation = "RESET"

func _ready() -> void:
	#makes sure the animations start playing 
	#(afterwards the next animation is played whenever the current animation ends)
	animationPlayer.play(nextAnimation)
	
func _physics_process(delta: float) -> void:
	#if the player is moving the eye bounces, otherwise its idle
	if Input.get_vector("left","right","up","down") != Vector2.ZERO:
		nextAnimation = "bounce"
	else:
		nextAnimation = "RESET"



func _on_eye_animation_player_animation_finished(anim_name: StringName) -> void:
	animationPlayer.play(nextAnimation)
	


func _on_eye_pause_animation(pause) -> void:
	if pause:
		$EyeAnimationPlayer.set_speed_scale(1)
	else:
		$EyeAnimationPlayer.set_speed_scale(0)
