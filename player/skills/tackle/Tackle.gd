extends Node


onready var parent: Node = get_parent()


func tackle():#Jump and tackle, works as a dodge and as an attack
	if Input.is_action_pressed("Rclick"):
		if parent.is_on_floor():
			parent.horizontal_velocity = parent.direction * 15
		elif not parent.is_on_floor():
			parent.horizontal_velocity = parent.direction * 25
func _physics_process(_delta):
	tackle()
