extends Node

onready var parent = get_parent()
onready var stats = parent.get_node("Stats")
onready var info_sprite = parent.get_node("InfoSprite")
onready var stun_timer = $StunTimer
onready var is_stunned = false
var duration = 5
var message = "stunned"

func startStun():
		is_stunned = true
		duration = max(duration - stats.recovery, 0)  # Subtract stats.recovery from duration, but ensure it doesn't go below zero
		stun_timer.wait_time = duration  # Set stun_timer.wait_time based on the updated duration
		stun_timer.start()


func stopStun():
	stun_timer.stop()
	is_stunned = false

func _on_StunTimer_timeout():
	stopStun()


	
