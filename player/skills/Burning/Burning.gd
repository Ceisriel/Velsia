extends Spatial

var duration : float = 3
var burn_interval : float = 1
var damage : int = 15

onready var area = $Area
onready var duration_timer = $Area/Duration
onready var interval_timer = $Area/DamageInterval

func _ready():
	# Set the duration and start the timer
	duration_timer.wait_time = duration
	duration_timer.start()

	# Set the interval and start the timer
	interval_timer.wait_time = burn_interval
	interval_timer.start()

func _on_DamageInterval_timeout():
	# This function is called at regular intervals
	for body in area.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			# Assuming there's a function in your Enemy script to handle taking damage
			body.takeDamage(damage)

func _on_Duration_timeout():
	queue_free()
