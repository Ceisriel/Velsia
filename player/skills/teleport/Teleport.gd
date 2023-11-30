extends Node

onready var parent: Node = get_parent()

func teleport():
	if Input.is_action_just_pressed("teleport") :
		var teleport_vector = parent.direction.normalized() * 12
		var teleport_position = parent.translation + teleport_vector
		var collision = parent.move_and_collide(teleport_vector)
		if collision:
			teleport_position = collision.position
			parent.translation = teleport_position


func _physics_process(_delta):
	teleport()
