extends Node


onready var parent =get_parent()
onready var parent_mesh = get_parent().get_node("Mesh")
onready var camera = get_parent().get_node("Camroot")
var model0: PackedScene = preload("res://Creatures/Horses/Horse.tscn")
var model1: PackedScene = preload("res://Creatures/Horses/Horse.tscn")
var currentInstance: Node = null  
var has_model0 = false
var has_model1 = false
var has_ride = false



func _on_Detector_body_entered(body):
		if body.is_in_group("Horse"):
			if Input.is_action_pressed("E"):
				has_model0 = true
				check_and_delete(body)
				has_ride = true
				
		if body.is_in_group("Pachyrhinosaurus"):
			if Input.is_action_pressed("E"):
				has_model1 = true
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
			currentInstance.get_node("CollisionShape").disabled = true 
			# Add the horse as a child of the attachment node
			parent_mesh.add_child(currentInstance)
	elif has_model1:
		# Check if there is no current horse instance
		if currentInstance == null:
			# Instantiate the horse scene
			currentInstance = model1.instance()
			# Set the scale of the horse
			currentInstance.scale *= Vector3(1, 1, 1)
			# Add the horse as a child of the attachment node
			parent_mesh.add_child(currentInstance)
func drop():
	if currentInstance != null and  Input.is_action_just_pressed("drop"):
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
		currentInstance.get_node("CollisionShape").disabled = false
		get_tree().root.add_child(currentInstance)
		# Reset variables
		has_model0 = false
		has_model1 = false
		currentInstance = null
		has_ride = false
		
func check_and_delete(body):
	# Check if the parent is the player
	if body.get_parent() != parent_mesh:
		# Delete the body or perform other actions
		body.queue_free()

func _on_FPS_timeout():
	switch()
	drop()	

