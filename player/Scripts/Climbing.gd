extends Node

onready var parent: Node = get_parent()
var enabled_climb: bool = true

# Assuming you have a "Stats" node with a "health" property
onready var stats: Node = parent.get_node("Stats")


func _ready():
	# Find the child node named "Stats"
	stats = parent.get_node("Stats")
	if stats:
		# Do something with the "Stats" node, for example, print its name
		print("Found 'Stats' node:", stats.name)
	else:
		print("No 'Stats' node found under the parent.")


func climb():
	if parent.is_on_wall() and enabled_climb:
		if Input.is_action_pressed("forward"):
			parent.vertical_velocity = Vector3.UP * 1
			parent.is_aiming = true

func _physics_process(_delta):
	climb()
