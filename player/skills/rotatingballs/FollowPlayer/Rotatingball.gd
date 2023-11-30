extends KinematicBody


onready var burn_scene = preload("res://player/skills/Burning/Burning.tscn")
onready var parent = get_parent()
onready var stats: Node = parent.get_node("Stats")
var damage = 1
var burn_damage = 1
var burn_duration = 3
var burn_interval = 3
var rotation_speed = 1 
var burning_instance = null

func _ready():
	# Find the child node named "Stats"
	stats = parent.get_node("Stats")
	if stats:
		# Do something with the "Stats" node, for example, print its name
		print("Found 'Stats' node:", stats.name)
	else:
		print("No 'Stats' node found under the parent.")

func _process(delta):
	if stats:
		burn_damage = stats.intelligence * 3.333
		burn_interval = 3 / stats.intelligence
		damage = stats.intelligence * 1.15

		# Calculate the desired rotation speed
		var desired_rotation_speed = stats.intelligence * 1.5
	
		# Limit the rotation speed to 10
		rotation_speed = min(desired_rotation_speed, 2.5)
	else:
		burn_damage = parent.burn_damage
		burn_interval = parent.burn_interval
		damage = parent.damage	
		# Calculate the desired rotation speed
		var desired_rotation_speed = parent.rotation_speed 
	
		# Limit the rotation speed to 10
		rotation_speed = min(desired_rotation_speed, 5)		
	# Rotate the KinematicBody around the Y-axis
	rotate_y(rotation_speed * delta)

func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		# Asynchronously load the Burning scene
		load("res://player/skills/Burning/Burning.tscn")

		# Create an instance of the Burning scene when the loading is complete
		burning_instance = load("res://player/skills/Burning/Burning.tscn").instance()

		# Set the variables in the Burning instance
		burning_instance.damage = damage
		burning_instance.duration =  burn_duration
		burning_instance.burn_interval =  burn_interval
		# Add the Burning instance to the enemy
		body.add_child(burning_instance)

