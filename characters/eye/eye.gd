extends CharacterBody2D

#signals
signal pauseAnimation
#Variables assosiated with movement
const SPEED = 100

#setup variables
var gameMode: String = "eye"

#relating to dash
var mouseDirection = Vector2(0,0)
var dashMomentum = 0
var currentDash: bool = false

func _physics_process(delta: float) -> void:
	#handles various "eye" gamemodes
	if gameMode == "eye":
		#basic Eye movement W,A,S,D space to capture
		if not currentDash:
			#Below is vector for basic W,A,S,D movmenent
			var input_direction = Input.get_vector("left", "right", "up", "down")
			var movementX = Input.get_axis("left", "right")
			var movementY = Input.get_axis("up", "down")
			if input_direction == Vector2.ZERO:
				#slowing eye down if no buttons are pressed
				velocity = velocity.move_toward(Vector2.ZERO, SPEED * 1.5 * delta)
			else:
				#X movement code
				if movementX == 1 and velocity.x < SPEED:
					velocity.x += movementX * (SPEED/10)
				elif movementX == -1 and velocity.x > 0-SPEED:
					velocity.x += movementX * (SPEED/10)
				else:
					#This code brings X back to 0 if no x keys are pressed, it gets what the velocity would be if it were move towards 0 but only actually uses the x value (same for y below)
					var velX = velocity.x
					velX = velocity.move_toward(Vector2.ZERO, SPEED/2 * delta)
					velocity.x = velX.x
				#Y movement code
				if movementY == 1 and velocity.y < SPEED:
					velocity.y += movementY * (SPEED/10)
				elif movementY == -1 and velocity.y > 0-SPEED:
					velocity.y += movementY * (SPEED/10)
				else:
					var velY = velocity.y
					velY = velocity.move_toward(Vector2.ZERO, SPEED/2 * delta)
					velocity.y = velY.y
		else:
			#what happens during dash
			velocity = mouseDirection * dashMomentum
			dashMomentum -= 5
			if dashMomentum <= 300 and $PlayerAnimation/EyeAnimationPlayer.get_speed_scale() == 0:
				pauseAnimation.emit(true)
			if dashMomentum <= 100:
				currentDash = false
				dashMomentum = 0
		if Input.is_action_just_pressed("capture") and not currentDash:
			#triggers Dash
			mouseDirection = global_position.direction_to(get_global_mouse_position())
			currentDash = true
			pauseAnimation.emit(false)
			dashMomentum = SPEED * 4
		
		move_and_slide()
