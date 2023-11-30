extends KinematicBody

onready var parent = get_parent()
onready var stats: Node = parent.get_node("Stats")
var damage = 1
var rotation_speed = 1 

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
		damage = stats.intelligence * 1.15
		# Calculate the desired rotation speed
		var desired_rotation_speed = stats.intelligence * 1.5
	
		# Limit the rotation speed to 10
		rotation_speed = min(desired_rotation_speed, 2.5)
	
	# Rotate the KinematicBody around the Y-axis
	rotate_y(rotation_speed * delta)

func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		# Save the position of the collision
		body.takeDamage(damage)
