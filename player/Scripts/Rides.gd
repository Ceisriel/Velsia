extends Node


onready var parent: Node = get_parent()
onready var parent_mesh = $"../Hunter"
onready var camera = $"../Camroot"
var model0: PackedScene = preload("res://creature/horses/horse.tscn")
var currentInstance: Node = null  
var has_model0 = false
var has_ride = false



func _on_Detector_body_entered(body):
		if body.is_in_group("Horse"):
			if Input.is_action_pressed("E"):
				has_model0 = true
				check_and_delete(body)
				has_ride = true
func ready():
	switch()
func switch():
	if has_model0:
		# Check if there is no current horse instance
		if currentInstance == null:
			# Instantiate the horse scene
			currentInstance = model0.instance()
			# Set the scale of the horse
			currentInstance.scale *= Vector3(1, 1, 1)
			# Add the horse as a child of the attachment node
			parent_mesh.add_child(currentInstance)
			print("Player has horse")
func drop():
	if currentInstance != null:
		# Remove the instanced model from the attachment
		parent_mesh.remove_child(currentInstance)
		# Set the scale to 1, 1, 1
		currentInstance.scale = Vector3(1, 1, 1)
		# Calculate the position in front of the camera
		# Get the global transform of the camera
		var camera_transform = camera.global_transform
		# Set the position of the horse in front of the camera
		currentInstance.global_transform.origin = camera_transform.origin + camera_transform.basis.z * (+1.5)  # Adjust the distance as needed
		# Instance the horse back as a child of the "World" node
		currentInstance.startIdleTimer()
		get_tree().root.add_child(currentInstance)
		print("Horse dropped")
		# Reset variables
		has_model0 = false
		currentInstance = null
		has_ride = false
		
func check_and_delete(body):
	# Check if the parent is the player
	if body.get_parent() != parent_mesh:
		# Delete the body or perform other actions
		body.queue_free()
func _physics_process(_delta):
	
	switch()
	if Input.is_action_just_pressed("drop"):
		drop()	
	if has_ride:
		# If has_horse is true, change collision layers
		parent.set_collision_layer(6)  # Set to the desired collision layer
		parent.set_collision_mask(6)   # Set to the desired collision mask
	elif not has_ride:
		# If has_horse is false, reset collision layers
		parent.set_collision_layer(1)  # Set to the original collision layer
		parent.set_collision_mask(1)   # Set to the original collision mask
		

