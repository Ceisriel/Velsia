extends KinematicBody

onready var parent = get_parent()

var damage = 1
var rotation_speed = 1

func _process(delta):
	damage = parent.damage * 2
	rotation_speed = parent.rotation_speed
	# Rotate the KinematicBody around the Y-axis
	rotate_y(rotation_speed * delta)

func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		# Save the position of the collision
		body.takeDamage(damage)
