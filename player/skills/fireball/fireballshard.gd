extends KinematicBody

var rotation_speed = 3

func _process(delta):
	# Rotate the KinematicBody around its own axis
	rotate_y(rotation_speed * delta)



