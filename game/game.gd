extends Node2D
#scenes
var person = preload("res://characters/person/person.tscn")

#starting gamemode
var gameMode: String = "eye"
var eyeCurrentlyInDash


func _ready() -> void:
	createPerson(1000,1000)
	#remember to spawn people here

	
func createPerson(x,y):
	var newPerson = person.instantiate()
	newPerson.global_position = Vector2(x,y)
	add_child(newPerson)
	pass


func _on_eye_currently_in_dash(dash) -> void:
	eyeCurrentlyInDash = dash
