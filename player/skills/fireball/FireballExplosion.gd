extends Spatial

var damage = 0.25
# Declare variables for fireballs 1 to 26
onready var fireball1 = $fireball1
onready var fireball2 = $fireball2
onready var fireball3 = $fireball3
onready var fireball4 = $fireball4
onready var fireball5 = $fireball5
onready var fireball6 = $fireball6
onready var fireball7 = $fireball7
onready var fireball8 = $fireball8
onready var fireball9 = $fireball9
onready var fireball10 = $fireball10
onready var fireball11 = $fireball11
onready var fireball12 = $fireball12
onready var fireball13 = $fireball13
onready var fireball14 = $fireball14
onready var fireball15 = $fireball15
onready var fireball16 = $fireball16
onready var fireball17 = $fireball17
onready var fireball18 = $fireball18
onready var fireball19 = $fireball19
onready var fireball20 = $fireball20
onready var fireball21 = $fireball21
onready var fireball22 = $fireball22
onready var fireball23 = $fireball23
onready var fireball24 = $fireball24
onready var fireball25 = $fireball25
onready var fireball26 = $fireball26

var speed = 5  # Adjust the speed as needed

func _ready():
	pass  # Nothing to do in _ready for continuous movement

func _process(delta):
	moveFireballs(delta)

func moveFireballs(delta):
	# Move each fireball in a unique 3D direction
	moveFireball(fireball1, Vector3(0, 0, -1), delta)
	moveFireball(fireball2, Vector3(0, 0, 1), delta)
	moveFireball(fireball3, Vector3(-1, 0, 0), delta)
	moveFireball(fireball4, Vector3(1, 0, 0), delta)
	moveFireball(fireball5, Vector3(-1, 0, -1).normalized(), delta)
	moveFireball(fireball6, Vector3(1, 0, 1).normalized(), delta)
	moveFireball(fireball7, Vector3(-1, 0, 1).normalized(), delta)
	moveFireball(fireball8, Vector3(1, 0, -1).normalized(), delta)
	moveFireball(fireball9, Vector3(0, -1, -1).normalized(), delta)
	moveFireball(fireball10, Vector3(0, 1, 1).normalized(), delta)
	moveFireball(fireball11, Vector3(0, -1, 1).normalized(), delta)
	moveFireball(fireball12, Vector3(0, 1, -1).normalized(), delta)
	moveFireball(fireball13, Vector3(0, -1, 0), delta)
	moveFireball(fireball14, Vector3(0, 1, 0), delta)
	moveFireball(fireball15, Vector3(0, -1, 0).normalized(), delta)
	moveFireball(fireball16, Vector3(0, 1, 0).normalized(), delta)
	moveFireball(fireball17, Vector3(-1, 0, 0).normalized(), delta)
	moveFireball(fireball18, Vector3(1, 0, 0).normalized(), delta)
	moveFireball(fireball19, Vector3(-1, 1, 1).normalized(), delta)
	moveFireball(fireball20, Vector3(1, -1, -1).normalized(), delta)
	moveFireball(fireball21, Vector3(-1, -1, 1).normalized(), delta)
	moveFireball(fireball22, Vector3(1, 1, -1).normalized(), delta)
	moveFireball(fireball23, Vector3(-1, 1, 0).normalized(), delta)
	moveFireball(fireball24, Vector3(1, -1, 0).normalized(), delta)
	moveFireball(fireball25, Vector3(0, 0, -1).normalized(), delta)
	moveFireball(fireball26, Vector3(0, 0, 1).normalized(), delta)

# Move a fireball in the given direction
func moveFireball(fireball, movement_vector, delta):
	var speed_vector = movement_vector * speed
	fireball.translate(speed_vector * delta)


func _on_Timer_timeout():
	self.queue_free()


func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		body.takeDamage(damage)
