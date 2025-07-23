extends CharacterBody2D

var activePerson = false
var eyeInZone
var eyeInDash

#partaining to movement
const SPEED = 200
var movementDirection

func _physics_process(delta: float) -> void:
	eyeInDash = get_parent().eyeCurrentlyInDash
	if eyeInZone and eyeInDash and get_parent().gameMode == "eye":
		activePerson = true
	if activePerson:
		movementDirection = Input.get_vector("left","right","up","down")
		velocity = movementDirection * SPEED
		move_and_slide()


func _on_eye_detection_range_body_entered(body: Node2D) -> void:
	#checks when eye enteres takeover range
		eyeInZone = true


func _on_eye_detection_range_body_exited(body: Node2D) -> void:
	#checks when eye leaves takeover range
		eyeInZone = false
