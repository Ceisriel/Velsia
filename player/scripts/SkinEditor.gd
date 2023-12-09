extends Node

onready var torso = $"../Mesh/Armature/Skeleton/Female Body003"
onready var legs = $"../Mesh/Armature/Skeleton/Female Body008"
onready var body_material = preload("res://player/FHuman/test1/body.material")
onready var test_replace_material = preload("res://player/FHuman/test1/Material_002.material")

var skin0 = false
var skin1 = false
var skin2 = false
var skin3 = false 

func switch():
	if skin0:
	# Change the material color of the torso to a darker albedo color
		var darker_color = Color(0.5, 0.5, 0.5)  # Adjust the values as needed
		torso.material_override = body_material.duplicate()  # Duplicate the material to avoid affecting other nodes
		torso.material_override.albedo_color = darker_color

		# Change the material color of the legs to a darker albedo color
		legs.material_override = body_material.duplicate()  # Duplicate the material to avoid affecting other nodes
		legs.material_override.albedo_color = darker_color
	elif skin1: 
			# Change the material color of the torso to a different color
		var color_skin1 = Color(0.75,0.75, 0.75)  # Adjust the values as needed
		torso.material_override = body_material.duplicate()  # Duplicate the material to avoid affecting other nodes
		torso.material_override.albedo_color = color_skin1
		# Change the material color of the legs to a different color
		legs.material_override = body_material.duplicate()  # Duplicate the material to avoid affecting other nodes
		legs.material_override.albedo_color = color_skin1
	elif skin2:
			# Change the material color of the torso to another color
		var color_skin2 = Color(1, 1, 1)  # Adjust the values as needed
		torso.material_override = body_material.duplicate()  # Duplicate the material to avoid affecting other nodes
		torso.material_override.albedo_color = color_skin2

		# Change the material color of the legs to another color
		legs.material_override = body_material.duplicate()  # Duplicate the material to avoid affecting other nodes
		legs.material_override.albedo_color = color_skin2
	elif skin3:
		# Replace material with test_replace_material
		torso.material_override = test_replace_material.duplicate()
		legs.material_override = test_replace_material.duplicate()

func _on_skin0_pressed():
	skin0 = true 
	skin1 = false 
	skin2 = false
	skin3 = false 
func _on_skin1_pressed():
	skin0 = false
	skin1 = true
	skin2 = false
	skin3 = false 
func _on_skin2_pressed():
	skin0 = false
	skin1 = false 
	skin2 = true
	skin3 = false 
func _on_skin3_pressed():
	skin0 = false
	skin1 = false 
	skin2 = false
	skin3 = true

func _on_FPS_timeout():
	switch()
