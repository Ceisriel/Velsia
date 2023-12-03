extends KinematicBody


onready var parent = get_parent()
onready var area = $Area
var damage = 1
var rotation_speed = 1
var dot = 5
var interval = 1
var duration = 5
var FPS = 0.035

func _on_Area_body_entered(body): 
	if body.is_in_group("Enemy"):
		# Save the position of the collision
		body.takeDamage(damage)


func _on_FPS_timeout():	
	var damage_multiplier = rand_range(0.33, 3.33)
	damage = parent.damage * damage_multiplier
	# Rotate the KinematicBody around the Y-axis
	rotate_y(rotation_speed * FPS)
