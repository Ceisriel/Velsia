extends KinematicBody

# Allows to pick your animation tree from the inspector
export (NodePath) var PlayerAnimationTree 
export onready var animation_tree = get_node(PlayerAnimationTree)
onready var playback = animation_tree.get("parameters/playback");
onready var stats = $Stats

# Allows to pick your chracter's mesh from the inspector
export (NodePath) var PlayerCharacterMesh
export onready var player_mesh = get_node(PlayerCharacterMesh)

# Gamplay mechanics and Inspector tweakables
export var gravity = 9.8
# Animation node names
var roll_node_name = "Roll"
var idle_node_name = "Idle"
var walk_node_name = "Walk"
var run_node_name = "Run"
var jump_node_name = "Jump"
var attack1_node_name = "Attack1"
var attack2_node_name = "Attack2"
var bigattack_node_name = "BigAttack"
var toggle_visibility: bool = true
# Condition States
var is_attacking = bool()
var is_rolling = bool()
var is_walking = bool()
var is_jumping = bool()
var is_running = bool()
var is_climbing = bool()
var throwing_fireball = bool()
var enabled_climb = true 

# Physics values
var direction = Vector3()
var horizontal_velocity = Vector3()
var aim_turn = float()
var movement = Vector3()
var vertical_velocity = Vector3()
var movement_speed = int()
var angular_acceleration = int()
var acceleration = int()
var is_aiming = false

var climbing_speed = 2.5

func _ready(): # Camera based Rotation
	direction = Vector3.BACK.rotated(Vector3.UP, $Camroot/h.global_transform.basis.get_euler().y)

func _input(event): # All major mouse and button input events
	if event is InputEventMouseMotion:
		aim_turn = -event.relative.x * 0.015 # animates player with mouse movement while aiming 
func aiming():
	if Input.is_action_pressed("aim"):
		is_aiming = true
	else:
		is_aiming = false	
	
func cameraNormal(delta):
	player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, atan2(direction.x, direction.z) - rotation.y, delta * angular_acceleration)
	



func _physics_process(delta):

	var on_floor = is_on_floor() # State control for is jumping/falling/landing

	
	movement_speed = 0
	angular_acceleration = 10
	acceleration = 15

	# Gravity mechanics and prevent slope-sliding
	if not is_on_floor(): 
		vertical_velocity += Vector3.DOWN * gravity * 2 * delta
	else: 
		vertical_velocity = -get_floor_normal() * gravity / 3
	
	# Defining attack state: Add more attacks animations here as you add more!
	if (attack1_node_name in playback.get_current_node()) or (attack2_node_name in playback.get_current_node()) or (bigattack_node_name in playback.get_current_node()): 
		is_attacking = true
	else: 
		is_attacking = false
# Giving BigAttack some Slide
	if bigattack_node_name in playback.get_current_node(): 
		acceleration = 3
	# Defining Roll state and limiting movment during rolls
	if roll_node_name in playback.get_current_node(): 
		is_rolling = true
		acceleration = 2
		angular_acceleration = 2
	else: 
		is_rolling = false
#	Jump input and Mechanics
	if Input.is_action_pressed("jump") and ((is_attacking != true) and (is_rolling != true)) and is_on_floor():
		vertical_velocity = Vector3.UP * stats.jumping_power

	if is_aiming:  # Aim/Strafe input and  mechanics
		player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, $Camroot/h.rotation.y, delta * angular_acceleration)

	else: # Normal turn movement mechanics
		cameraNormal(delta)


func ToggleUI():
	if Input.is_action_just_pressed("inventory"):
		$Stats/Control/inventory.visible = !$Stats/Control/inventory.visible

	
	
func movement():	
	var h_rot = $Camroot/h.global_transform.basis.get_euler().y
	if Input.is_action_pressed("forward") or Input.is_action_pressed("backward") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		direction = Vector3(Input.get_action_strength("left") - Input.get_action_strength("right"),
					0,
					Input.get_action_strength("forward") - Input.get_action_strength("backward"))
		direction = direction.rotated(Vector3.UP, h_rot).normalized()	
		is_walking = true
		
	# Sprint input, state and speed
		if (Input.is_action_pressed("sprint")) and (is_walking == true): 
			movement_speed = stats.run_speed
			is_running = true
		else: # Walk State and speed
			movement_speed = stats.walk_speed
			is_running = false
	else: 
		is_walking = false
		is_running = false


	horizontal_velocity = horizontal_velocity.linear_interpolate(direction.normalized() * movement_speed, acceleration * 0.033)
	# The Physics Sauce. Movement, gravity and velocity in a perfect dance.
	movement.z = horizontal_velocity.z + vertical_velocity.z
	movement.x = horizontal_velocity.x + vertical_velocity.x
	movement.y = vertical_velocity.y
	move_and_slide(movement, Vector3.UP)
	
func _on_FPS_timeout():
	aiming()
	ToggleUI()
	movement()
	teleport()
	invisible()
	climb()
	movementBoleans()
	fireballBoolean()

func _on_Unstuck_pressed():
#teleport to coordinates 0, 10 , 0
	translation = Vector3(0, 10, 0)

func teleport():
	if Input.is_action_just_pressed("teleport") :
		var teleport_vector = direction.normalized() * 12
		var teleport_position = translation + teleport_vector
		var collision = move_and_collide(teleport_vector)
		if collision:
			teleport_position = collision.position
			translation = teleport_position


func invisible():
	if Input.is_action_just_pressed("invisible"):
		toggle_visibility = !toggle_visibility
		self.visible = toggle_visibility
func movementBoleans():
	if Input.is_action_pressed("jump"):
		is_jumping = true 
	else:
		is_jumping = false	
func climb():
	if is_on_wall() and enabled_climb:
		if Input.is_action_pressed("forward"):
			vertical_velocity = Vector3.UP * climbing_speed
			is_climbing = true
			is_aiming = true
		else:
			is_climbing = false	
	else:
		is_climbing = false	
func fireballBoolean():
	if Input.is_action_pressed("attack"):
		if not is_climbing:
			throwing_fireball = true
			is_aiming = true
	else:
		throwing_fireball = false	
		is_aiming = false
