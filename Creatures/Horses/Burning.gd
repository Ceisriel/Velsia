extends Spatial

onready var parent = $".."
var duration
var interval
var damage
var burning = false
var health = parent.health
func burn(damage, duration, interval):


	# Set self to visible
	visible = true
	
	# Start the timer
	$BurnTimer.start()

	# Every interval, decrease health by damage and print the remaining health
	$BurnTimer.wait_time = interval
	$BurnTimer.repeat = true

func _on_BurnTimer_timeout():
	# Decrease health by damage
	health -= damage

	# Print the remaining health
	print("Remaining Health: ", health)

	# Check if the duration has passed
	if $BurnTimer.time_left < 0.1:
		# Stop the timer
		$BurnTimer.stop()
		
		# Set burning to invisible
		visible = false

		# Reset health, duration, interval, and damage
		health = get_parent().health
		duration = 0
		interval = 0
		damage = 0
