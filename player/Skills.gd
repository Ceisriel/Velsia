extends Node

onready var rotatingBallsScene = preload("res://player/skills/rotatingballs/FollowPlayer/Rotatingball.tscn")
onready var rotatingBallsDrop = preload("res://player/skills/rotatingballs/fireballR.tscn")
onready var camera = $"../Camroot/h/v/Camera"
onready var parent = get_parent()
var rotatingBallsInstance = null
var has_skill = false

func _process(delta):
	if Input.is_action_just_pressed("Q"):
		toggleRotatingBalls()

# Function to toggle the rotating balls on and off
func toggleRotatingBalls():
	if has_skill:
		# If rotating balls are already instanced, remove them
		rotatingBallsInstance.queue_free()
		dropRotatingBalls()
		has_skill = false
	else:
		# Instance rotating balls as a child of the parent node
		rotatingBallsInstance = rotatingBallsScene.instance()
		get_parent().add_child(rotatingBallsInstance)
		has_skill = true

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



