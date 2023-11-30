extends Node

var falling = false
var counter: float = 0.0

onready var parent: Node = get_parent()

# Assuming you have a "Stats" node with a "health" property
onready var stats: Node = parent.get_node("Stats")

# New variable to store fall damage
var fall_damage: float = 0.0

func _ready():
	# Find the child node named "Stats"
	stats = parent.get_node("Stats")
	if stats:
		# Do something with the "Stats" node, for example, print its name
		print("Found 'Stats' node:", stats.name)
	else:
		print("No 'Stats' node found under the parent.")

func fallDamage(delta):
	if parent.is_on_floor() or parent.is_on_wall():
		falling = false
	else:
		falling = true
	if falling:
		counter += delta
	else:
		# Calculate fall damage based on the accumulated time and the fall damage multiplier
		fall_damage = counter * stats.weight / 3 / stats.acrobatics
		counter = 0
		if fall_damage >= 30:
			stats.health -= fall_damage 
			print("Fall damage applied:", fall_damage)
func _physics_process(delta):
	fallDamage(delta)
