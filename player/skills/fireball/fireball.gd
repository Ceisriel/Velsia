extends RigidBody

onready var explosion_scene = preload("res://player/skills/fireball/FireballExplosion.tscn")
var damage = 12
const speed = 5

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	var camera = get_viewport().get_camera()
	if camera:
		var direction = -camera.global_transform.basis.z.normalized()
		apply_impulse(-direction, direction * speed)

func _on_Timer_timeout():
	queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		# Save the position of the collision
		var collisionPosition = body.translation

		body.takeDamage(damage)

		queue_free()

		# Instantiate the explosion and add it as a child of the root node
		var explosion_instance = explosion_scene.instance()
		get_tree().root.add_child(explosion_instance)
		explosion_instance.global_transform.origin = collisionPosition
		print("Explosion added at collision position!")
