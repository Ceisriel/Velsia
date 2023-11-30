extends KinematicBody

var damage = 12
const speed = 500  # Adjust the speed as needed
var player = get_parent()
func _ready():
	set_as_toplevel(true)

func shoot_fireball(target_direction: Vector3):
	var velocity = player.direction.normalized() * speed
	move_and_slide(velocity)

func _physics_process(delta):
	# The player's code to determine the target direction

	if player:
		var camera = player.get_node("Camera")  # Assuming the camera is a child node named "Camera"
		if camera:
			var direction = -camera.global_transform.basis.z.normalized()
			shoot_fireball(direction)

	# Optionally, you can handle collisions or other logic here


func _on_Timer_timeout():
	queue_free()
