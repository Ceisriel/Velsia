extends Node

var damage = 12
var recoil_angle = 5  # Adjust the initial recoil angle in degrees as needed
var max_recoil_angle = 30  # Maximum recoil angle in degrees
var recoil_speed = 5  # Adjust the speed of the camera's rotation back to normal
var bullets_per_shotgun = 5  # Number of bullets in shotgun mode

var original_rotation = Vector3.ZERO
var current_recoil_angle = 0

onready var parent = get_parent()
onready var stats = get_parent().get_node("Stats")
onready var aim = $"../Camroot/h/v/Camera/Aim"
onready var camera = $"../Camroot/h/v/Camera"

onready var firerate_controller = $Timer
var firerate = 0.25
var shotgun_mode : bool
var interval = 1 
var duration = 5 


func shoot():
	if stats.energy > 0.25:
		
		if Input.is_action_pressed("attack") or Input.is_action_just_pressed("attack"):
			stats.energy -= 0.25
			parent.is_attacking = true
			# Clear any previous exceptions
			aim.clear_exceptions()
			# Add your own body to the exceptions
			aim.add_exception($"..")
			if aim.is_colliding():
				var body = aim.get_collider()
				if body.is_in_group("Enemy"):
					var body_stats = body.get_node("Stats")
					var info_sprite = body.get_node("InfoSprite")
					body_stats.health -= damage
					info_sprite.showDamageTaken(damage)
		else:
			parent.is_aiming = false
			parent.is_attacking = false

func _on_Timer_timeout():
	shoot()
