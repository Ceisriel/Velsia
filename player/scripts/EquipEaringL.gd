extends Node

onready var player = get_parent()
onready var attachment = get_parent().get_node("Mesh/Armature/Skeleton/EaringL")
onready var camera = $"../Camroot/h/v/Camera"
onready var detector = $"../Detector"
var model0: PackedScene = preload("res://player/FHuman/Earing/earing0/earing0.tscn")
var model1: PackedScene =preload("res://player/FHuman/Earing/earing0/earing0.tscn")
var model2: PackedScene =preload("res://player/FHuman/Earing/earing0/earing0.tscn")
var currentInstance: Node = null  
var effect0_applied: bool = false
var has_model0 = false
var has_model1 = false
var has_model2 = false

func ready():
	switch()

func switch():
	if has_model0:
		if currentInstance == null:
			currentInstance = model0.instance()
			currentInstance.get_node("CollisionShape").disabled = true
			attachment.add_child(currentInstance)
			Effect0(true)
	elif has_model1:	
		if currentInstance == null:
			currentInstance = model1.instance()
			currentInstance.get_node("CollisionShape").disabled = true
			attachment.add_child(currentInstance)
			Effect0(true)		
	elif has_model2:	
		if currentInstance == null:
			currentInstance = model2.instance()
			currentInstance.get_node("CollisionShape").disabled = true
			attachment.add_child(currentInstance)
			Effect0(true)			
func drop():
	if currentInstance != null and Input.is_action_just_pressed("drop"):
		attachment.remove_child(currentInstance)
		# Set the drop position
		var drop_position = player.global_transform.origin + player.direction.normalized() * 1.0
		currentInstance.global_transform.origin = Vector3(drop_position.x - 0.3, player.global_transform.origin.y + 0.2, drop_position.z)
		# Set the scale of the dropped instance
		currentInstance.scale = Vector3(4, 4, 4)
		var collision_shape = currentInstance.get_node("CollisionShape")
		if collision_shape != null:
			collision_shape.disabled = false
		get_tree().root.add_child(currentInstance)
		# Reset variables
		has_model0 = false
		has_model1 = false
		has_model2 = false
		currentInstance = null
		Effect0(false)


func _on_Detector_body_entered(body):
	if currentInstance == null:
		if body.is_in_group("earing0"):
			if Input.is_action_pressed("E"):
				has_model0 = true
				check_and_delete(body)
		elif body.is_in_group("earing1"):
			if Input.is_action_pressed("E"):
				has_model1 = true
				check_and_delete(body)		
		elif body.is_in_group("earing2"):
			if Input.is_action_pressed("E"):
				has_model2 = true
				check_and_delete(body)		
func check_and_delete(body):
	if body.get_parent() != attachment:
		body.queue_free()
func Effect0(active: bool):
	if active and not effect0_applied:
		effect0_applied = true
	elif not active and effect0_applied:
		effect0_applied = false
func hitbox():
	var body = detector.get_overlapping_bodies()
func _on_FPS_timeout():
	switch()
	if Input.is_action_just_pressed("drop"):
		drop()
		has_model0 = false
		has_model1 = false
		has_model2 = false
		Effect0(false)
