extends KinematicBody


onready var burn_scene = preload("res://player/skills/Burning/Burning.tscn")
onready var parent = get_parent()
onready var stats = parent.get_node("Stats")
var damage = 1
var burn_damage = 1
var burn_duration = 3
var burn_interval = 3
var rotation_speed = 1 
var burning_instance = null
var FPS = 0.035


func checkStats():
	if stats:
		burn_damage = stats.intelligence * 3.333
		burn_interval = 3 / stats.intelligence
		damage = stats.intelligence * 1.15
		# Calculate the rotation speed
		var desired_rotation_speed = stats.intelligence * 1.5
		# Limit the rotation speed to 10
		rotation_speed = min(desired_rotation_speed, 3)		
	else:
		rotation_speed = 2	
	# Rotate the KinematicBody around the Y-axis
	rotate_y(rotation_speed * FPS)

func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		# Create an instance of the Burning scene when the loading is complete
		burning_instance = burn_scene.instance()
		# Set the variables in the Burning instance
		burning_instance.damage = stats.intelligence * 3.333
		burning_instance.duration =  5
		burning_instance.burn_interval =  burn_interval
		# Add the Burning instance to the enemy
		body.add_child(burning_instance)

func _on_FPS_timeout():
	checkStats()
	
	
