extends Node

onready var rotatingBallsScene = preload("res://player/skills/rotatingballs/FollowPlayer/Rotatingball.tscn")
onready var rotatingBallsDrop = preload("res://player/skills/rotatingballs/fireballR.tscn")
onready var camera = $"../Camroot/h/v/Camera"
onready var stats = $"../Stats"
onready var parent = get_parent()
onready var cooldown_timer = $Cooldown
var rotatingBallsInstance = null
var has_skill = false
var skill_cooldown = 25.0  # Set the default cooldown time in seconds

func _ready():
	cooldown_timer.connect("timeout", self, "_on_cooldown_timeout")

func cooldownMultiplier():
	skill_cooldown = 25.0 / stats.intelligence 

func _process(delta):
	if Input.is_action_just_pressed("Q"):
		toggleRotatingBalls()

# Function to toggle the rotating balls on and off
func toggleRotatingBalls():
	if not cooldown_timer.is_stopped():
		# The skill is still on cooldown
		return

	if has_skill:
		# If rotating balls are already instanced, remove them
		rotatingBallsInstance.queue_free()
		dropRotatingBalls()
		startCooldown()
		has_skill = false
	else:
		# Instance rotating balls as a child of the parent node
		rotatingBallsInstance = rotatingBallsScene.instance()
		get_parent().add_child(rotatingBallsInstance)
		has_skill = true

# Function to start the skill cooldown
func startCooldown():
	cooldownMultiplier()  # Update the cooldown based on stats
	cooldown_timer.start(skill_cooldown)

# Function to drop the rotating balls as a child of the root node
func dropRotatingBalls():
	if rotatingBallsInstance:
		# Create a new instance of rotatingBallsDrop
		var new_fireballR = rotatingBallsDrop.instance()

		# Calculate the position in front of the camera
		var camera_position = camera.global_transform.origin
		var camera_forward = -camera.global_transform.basis.z.normalized()
		var spawn_distance = 15  # Adjust the distance as needed

		# Set the new position in front of the camera
		new_fireballR.translation = camera_position + camera_forward * spawn_distance

		# Add the new fireball as a child of the root node
		get_tree().root.add_child(new_fireballR)

# Function called when the cooldown timer times out
func _on_cooldown_timeout():
	# The cooldown timer has finished, allowing the skill to be used again
	cooldown_timer.stop()


