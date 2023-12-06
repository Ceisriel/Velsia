extends KinematicBody

var FPS = 0.04
var mouse_captured = true
onready var stats =get_node("Stats")
onready var info_sprite = get_node("InfoSprite")
onready var walk_sound = $Walk
onready var camera = get_node("Camroot/h/v/Camera")
onready var camera_h_control =  get_node("Camroot/h")
onready var collision_torso =  get_node("CollisonTorso")
onready var stun = get_node("GetStunned")
onready var player_mesh = get_node("Mesh")
var has_sword = false 

var velocity := Vector3()
# movement variables
export var gravity = 9.8
export var jump_force = 5
export var crouch_speed = 1
export var walk_speed = 7
export var run_speed = 9
export var sprint_speed = 14
var teleport_distance = 35
var dash_power = 12
export (float) var mouse_sense = 0.1
#climbing
const base_climb_speed = 4
var climb_speed = 4
# Dodge
export var double_press_time: float = 0.4
var dash_countback: int = 0
var dash_timerback: float = 0.0
# Dodge Left
var dash_countleft: int = 0
var dash_timerleft: float = 0.0
# Dodge right
var dash_countright: int = 0
var dash_timerright: float = 0.0
# Dodge forward
var dash_countforward: int = 0
var dash_timerforward: float = 0.0
# Dodge multidirection (not in strafe mode)
var dash_count1 : int = 0
var dash_timer1 : float = 0.0
var dash_count2 : int = 0
var dash_timer2 : float = 0.0
# Condition States
var enabled_climbing = true
var has_ride = bool()
var is_riding = bool()
var is_falling = bool()
var is_swimming =bool()
var is_rolling = bool()
var is_walking = false
var was_walking = false
var is_running = bool()
var is_sprinting = bool()
var is_aiming = bool()
var is_cursor = false
var is_crouching = bool()
var is_attacking = bool()
var is_guarding = false
var is_climbing = false
var mousemode = bool()
var staggered = false
var blocking = false
var backstep = bool()
var frontstep = bool()
var leftstep = bool()
var rightstep =bool()


# Physics values
var direction = Vector3()
var horizontal_velocity = Vector3()
var aim_turn = float()
var movement = Vector3()
var vertical_velocity = Vector3()
var movement_speed = int()
var angular_acceleration = int()
var acceleration = int()


func _ready():
	direction = Vector3.BACK.rotated(Vector3.UP, $Camroot/h.global_transform.basis.get_euler().y)
	$Timer.connect("timeout", self, "_on_drinking_timer_timeout")
func movement():
	var h_rot = $Camroot/h.global_transform.basis.get_euler().y
	movement_speed = 0
	angular_acceleration = 10
	acceleration = 15
# Movement and strafe
	if Input.is_action_pressed("forward") or Input.is_action_pressed("backward") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		direction = Vector3(Input.get_action_strength("left") - Input.get_action_strength("right"),
					0,
					Input.get_action_strength("forward") - Input.get_action_strength("backward"))
		direction = direction.rotated(Vector3.UP, h_rot).normalized()
		is_walking = true
		# Movement States
		if Input.is_action_pressed("run") and is_walking and not is_climbing and not blocking and not is_swimming:
			movement_speed = run_speed
			is_running = true
			enabled_climbing = false
			is_crouching = false

			is_aiming = false
		elif Input.is_action_pressed("crouch") and is_walking and !is_climbing and !is_swimming:
			movement_speed = crouch_speed
			is_running = false
			enabled_climbing = false
			is_crouching = true
			is_aiming = false
		#Computer
		elif Input.is_action_pressed("sprint") and is_walking and not is_climbing and not blocking and not is_swimming:
				movement_speed = sprint_speed
				is_sprinting = true
				enabled_climbing = false
				is_crouching = false
				is_aiming = false


		else:  # Walk State and speed
			movement_speed = walk_speed
			is_sprinting = false
			is_crouching = false
			enabled_climbing = true
			is_crouching = false
	else:
		is_walking = false
		is_running = false
		is_sprinting = false
		is_crouching = false
		is_crouching = false

	if Input.is_action_pressed("crouch") and is_swimming:
		vertical_velocity += Vector3.DOWN * 2
		collision_torso.disabled = true
	else:
		collision_torso.disabled = false
	if 	Input.is_action_pressed("crouch") and not is_swimming:
		collision_torso.disabled = true
	else:
		collision_torso.disabled = false

	movement.z = horizontal_velocity.z + vertical_velocity.z
	movement.x = horizontal_velocity.x + vertical_velocity.x
	movement.y = vertical_velocity.y
	move_and_slide(movement, Vector3.UP)
func dodgeBack():#Doddge when in strafe mode
		if dash_countback > 0:
			dash_timerback += FPS
		if dash_timerback >= double_press_time:
			dash_countback = 0
			dash_timerback = 0.0
		if Input.is_action_just_pressed("backward"):
			dash_countback += 1
		if dash_countback == 2 and dash_timerback < double_press_time:
			stats.resolve -= 0.5 
			horizontal_velocity = direction * dash_power
			backstep = true
			collision_torso.disabled = true
			enabled_climbing = false
		else:
			collision_torso.disabled = false
			enabled_climbing = true
			backstep = false
func dodgeFront():#Dodge when in strafe mode
		if dash_countforward > 0:
			dash_timerforward +=  FPS
		if dash_timerforward >= double_press_time:
			dash_countforward = 0
			dash_timerforward = 0.0
		if Input.is_action_just_pressed("forward"):
			dash_countforward += 1
		if dash_countforward == 2 and dash_timerforward < double_press_time:
			stats.resolve -= 0.5 
			horizontal_velocity = direction * dash_power *1.5
			frontstep = true
			collision_torso.disabled = true
			enabled_climbing = false
		else:
			collision_torso.disabled = false
			enabled_climbing = true
			frontstep = false
func dodgeLeft():#Dodge when in strafe mode
		if dash_countleft > 0:
			dash_timerleft +=  FPS
		if dash_timerleft >= double_press_time:
			dash_countleft = 0
			dash_timerleft = 0.0
		if Input.is_action_just_pressed("left"):
			dash_countleft += 1
		if dash_countleft == 2 and dash_timerleft < double_press_time:
			stats.resolve -= 0.5 
			horizontal_velocity = direction * dash_power
			collision_torso.disabled = true
			enabled_climbing = false
			leftstep = true
		else:
			collision_torso.disabled = false
			enabled_climbing = true
			leftstep = false
func dodgeRight():#Dodge when in strafe mode
		if dash_countright > 0:
			dash_timerright +=  FPS
		if dash_timerright >= double_press_time:
			dash_countright = 0
			dash_timerright = 0.0
		if Input.is_action_just_pressed("right"):
			dash_countright += 1
		if dash_countright == 2 and dash_timerright < double_press_time :
			stats.resolve -= 0.5 
			horizontal_velocity = direction * dash_power
			collision_torso.disabled = true
			enabled_climbing = false
			rightstep = true
		else:
			collision_torso.disabled = false
			enabled_climbing = true
			rightstep = false
func teleport():
	if Input.is_action_just_pressed("teleport"):
		var teleport_vector = direction.normalized() * teleport_distance
		var teleport_position = translation + teleport_vector
		var collision = move_and_collide(teleport_vector)
		if collision:
			teleport_position = collision.position
			translation = teleport_position
func climbing():
	if is_on_wall():
		if  Input.is_action_pressed("jump"):
			if stats.strength >= 0.99:
				vertical_velocity = Vector3.UP * climb_speed 
				horizontal_velocity = direction * climb_speed
				is_climbing = true
				is_swimming = false
			else:
				is_climbing = false
	else:
			is_climbing = false
func mouseMode():
	if not is_cursor:
		if Input.is_action_pressed("attack"):
					is_aiming = true
		else:
					is_aiming = false	
	if Input.is_action_just_pressed("aim"):
		is_aiming = !is_aiming
	# Toggle mouse mode
	if Input.is_action_just_pressed("ESC"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			is_cursor = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			is_cursor = false
func ToggleUI():
	if Input.is_action_just_pressed("alt"):
		mouse_captured = !mouse_captured
		if mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func stiffCamera():
		if is_aiming:
			player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, camera_h_control.rotation.y, FPS * angular_acceleration)
		else:
			player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, atan2(direction.x, direction.z) - rotation.y, FPS * angular_acceleration)	
func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		vertical_velocity = Vector3.UP * jump_force * 3
	if Input.is_action_pressed("jump") and is_swimming:
		vertical_velocity = Vector3.UP * 5
func _on_WaterDetector_area_entered(area):
	if area.is_in_group("Water"):
		is_swimming = true
func _on_WaterDetector_area_exited(area):
	if area.is_in_group("Water"):
		is_swimming = false
func ridingCollision():
	if has_ride:
		# If has_horse is true, change collision layers
		set_collision_layer(6)  # Set to the desired collision layer
		set_collision_mask(6)   # Set to the desired collision mask
	elif not has_ride:
		# If has_horse is false, reset collision layers
		set_collision_layer(1)  # Set to the original collision layer
		set_collision_mask(1)   # Set to the original collision mask
func gravity():
	# Gravity and stop sliding on floors
	if not is_on_floor() and not is_swimming:
		vertical_velocity += Vector3.DOWN * 2.5
		is_falling = true
		is_swimming = false
	else:
		vertical_velocity = -get_floor_normal() * gravity / 2.5
		is_falling = false	
func interpol():
	horizontal_velocity = horizontal_velocity.linear_interpolate(direction.normalized() * movement_speed, acceleration * FPS)
func takeDamage(damage):
	stats.health -= damage 
	info_sprite.showDamageTaken(damage)
func walksound():
	if not stun.is_stunned:
		if is_walking != was_walking:
			if is_walking:
				walk_sound.play()
			else:
				walk_sound.stop()
			was_walking = is_walking
	if stun.is_stunned:
		is_walking = false
		walk_sound.stop()
func _on_FPS_timeout(): #artificial _process() using a timer 
	if not stun.is_stunned:
			jump()
			if stats.resolve > 0.5: 
				dodgeBack()
				dodgeFront()
				dodgeLeft()
				dodgeRight()	
			movement()
			climbing()
			teleport()
	mouseMode()		
	stiffCamera()	
	ridingCollision()
	gravity()
	interpol()	
	walksound()


