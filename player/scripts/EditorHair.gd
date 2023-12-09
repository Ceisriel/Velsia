extends Node

onready var hair_attachment = $"../Mesh/Armature/Skeleton/Hair"
var hair0: PackedScene = preload("res://player/FHuman/hair/hairDefault/hairDefault.tscn")
var hair1: PackedScene =  preload("res://player/FHuman/hair/hair1/hair1.tscn")
var hair2: PackedScene =  preload("res://player/FHuman/hair/hair2/hair2.tscn")
var hair3: PackedScene = preload("res://player/FHuman/hair/hair3/hair3.tscn")
var hair4: PackedScene =	preload("res://player/FHuman/hair/hair4/hair4.tscn")
var hair5: PackedScene =	preload("res://player/FHuman/hair/hair5/hair5.tscn")
var hair_color: Color = Color(1, 1, 1)  # Default color
var current_hair_instance: Node = null

var has_hair0 = false
var has_hair1 = false
var has_hair2 = false
var has_hair3 = false
var has_hair4 = false
var has_hair5 = false

func _ready():
	switchHair()


func switchHair():
	if current_hair_instance:
		current_hair_instance.queue_free() # Remove the current hair instance
	
	if has_hair0:
		instanceHair0()
	elif has_hair1:
		instanceHair1()
	elif has_hair2:
		instanceHair2()	
	elif has_hair3:
		instanceHair3()
	elif has_hair4:
		instanceHair4()	
	elif has_hair5:
		instanceHair5()
	else:
		instanceHair0()	

func instanceHair0():
	if hair_attachment and hair0:
		var hair_instance = hair0.instance()
		hair_attachment.add_child(hair_instance)
		current_hair_instance = hair_instance
		colorhair()
func instanceHair1():
	if hair_attachment and hair1:
		var hair_instance = hair1.instance()
		hair_attachment.add_child(hair_instance)
		current_hair_instance = hair_instance
		colorhair()

func instanceHair2():
	if hair_attachment and hair2:
		var hair_instance = hair2.instance()
		hair_attachment.add_child(hair_instance)
		current_hair_instance = hair_instance
		colorhair()
func instanceHair3():
	if hair_attachment and hair3:
		var hair_instance = hair3.instance()
		hair_attachment.add_child(hair_instance)
		current_hair_instance = hair_instance
		colorhair()
func instanceHair4():
	if hair_attachment and hair4:
		var hair_instance = hair4.instance()
		hair_attachment.add_child(hair_instance)
		current_hair_instance = hair_instance
		colorhair()

func instanceHair5():
	if hair_attachment and hair5:
		var hair_instance = hair5.instance()
		hair_attachment.add_child(hair_instance)
		current_hair_instance = hair_instance		
		colorhair()
func colorhair():
	var hair_material = current_hair_instance.material_override
	if hair_material:
		# Set the color property of the material
		hair_material.albedo_color = hair_color 	


func _on_hair0_pressed():
	has_hair0 = true
	has_hair1 = false
	has_hair2 = false	
	has_hair3 = false
	has_hair4 = false
	has_hair5 = false
func _on_hair1_pressed():
	has_hair0 = false
	has_hair1 = true
	has_hair2 = false	
	has_hair3 = false
	has_hair4 = false
	has_hair5 = false
func _on_hair2_pressed():
	has_hair0 = false
	has_hair1 = false
	has_hair2 = true	
	has_hair3 = false
	has_hair4 = false
	has_hair5 = false	
func _on_hair3_pressed():
	has_hair0 = false
	has_hair1 = false
	has_hair2 = false	
	has_hair3 = true
	has_hair4 = false
	has_hair5 = false	
func _on_hair4_pressed():
	has_hair0 = false
	has_hair1 = false
	has_hair2 = false	
	has_hair3 = false
	has_hair4 = true
	has_hair5 = false	
func _on_hair5_pressed():
	has_hair0 = false
	has_hair1 = false
	has_hair2 = false	
	has_hair3 = false
	has_hair4 = false
	has_hair5 = true	
func _on_hair6_pressed():
	pass # Replace with function body.

func _on_ColorPicker_color_changed(color):
	if current_hair_instance:
		# Assuming your hair models have a material with a color property
		var hair_material = current_hair_instance.material_override
		if hair_material:
			# Set the color property of the material
			hair_material.albedo_color = color
			hair_color = color
func _on_FPS_timeout():
	switchHair()



