extends Spatial

var camrot_h = 0
var camrot_v = 0
onready var parent = $".."
export var cam_v_max = 75 # -75 recommended
export var cam_v_min = -55 # -55 recommended
onready var camera_v_control =$h/v
onready var camera_h_control =$h
onready var camera = $h/v/Camera
var h_sensitivity = .1
var v_sensitivity = .1
var rot_speed_multiplier = .15 #reduce this to make the rotation radius larger
var h_acceleration = 10
var v_acceleration = 10
var FPS = 0.04



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion:

		camrot_h += -event.relative.x * h_sensitivity
		camrot_v += event.relative.y * v_sensitivity
		
func _physics_process(delta):	
	if  not parent.is_cursor:
		camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
		#MOUSE CAMERA
		camera_h_control.rotation_degrees.y = lerp(camera_h_control.rotation_degrees.y, camrot_h, delta * h_acceleration)
		camera_v_control.rotation_degrees.x = lerp(camera_v_control.rotation_degrees.x, camrot_v, delta * v_acceleration)

func _on_FPS_timeout():
	# Move camera based on UI keys
	var move_vector = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		move_vector += -camera_v_control.transform.basis.y
	if Input.is_action_pressed("ui_down"):
		move_vector += +camera_v_control.transform.basis.y
	if Input.is_action_pressed("ui_right"):
		move_vector += camera_v_control.transform.basis.z
	if Input.is_action_pressed("ui_left"):
		move_vector += -camera_v_control.transform.basis.z
	move_vector = move_vector.normalized() * 1 *  FPS
	camera_v_control.translation += move_vector
		
