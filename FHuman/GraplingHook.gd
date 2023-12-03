extends Node


# Convenience Nodes
onready var cam_helper := $CamHelper
onready var hook := $CamHelper/Hook
onready var line_helper := $LineHelper
onready var line := $LineHelper/Line
export var grapple_point : NodePath 

# Player Controller
export var MOUSE_SENSITIVITY := .001
export var speed := 4.0
export var air_speed := .25
export var friction := .25  # Higher -> more friction
export var jump_strength := 32.0
var velocity := Vector3()

# Grappling
export var max_grapple_speed := 2.75 # Self explanatory
export var grapple_speed := .5
""" Also known as the spring constant, this is how stiff your rope is. 
	For this demo, doesn't actually do too much, but you can play with
	the numbers
"""
export var rest_length := 1.0
"""How far the player should rest from the grapple point"""
var hooked := false
var grapple_position := Vector3()
