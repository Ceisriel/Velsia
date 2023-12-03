extends Node

var damage = 12
var recoil_angle = 5  # Adjust the initial recoil angle in degrees as needed
var max_recoil_angle = 30  # Maximum recoil angle in degrees
var recoil_speed = 5  # Adjust the speed of the camera's rotation back to normal
var bullets_per_shotgun = 5  # Number of bullets in shotgun mode

var original_rotation = Vector3.ZERO
var current_recoil_angle = 0

onready var parent = get_parent()
onready var aim = $"../Camroot/h/v/Camera/Aim"
onready var camera = $"../Camroot/h/v/Camera"

onready var firerate_controller = $Timer
var firerate = 0.25
var shotgun_mode : bool
var interval = 1 
var duration = 5 


func shoot():
	if Input.is_action_pressed("attack") or Input.is_action_just_pressed("attack"):
		# Clear any previous exceptions
		aim.clear_exceptions()

		# Add your own body to the exceptions
		aim.add_exception($"..")

		if aim.is_colliding():
			var body = aim.get_collider()
			if body.is_in_group("Enemy"):
				body.takeDamage(damage)



	else:
		parent.is_aiming = false

func recoil():
	camera.rotation_degrees.x += recoil_angle
	current_recoil_angle = recoil_angle	
func _physics_process(delta):

	if current_recoil_angle > 0:
		# Interpolate the camera's rotation back to the original position
		var interpolation_amount = recoil_speed * get_process_delta_time()
		camera.rotation_degrees = camera.rotation_degrees.linear_interpolate(original_rotation, interpolation_amount)
		
		current_recoil_angle -= interpolation_amount



func _on_Timer_timeout():
	shoot()
