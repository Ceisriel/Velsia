extends Node


onready var parent = get_parent()
onready var stats = get_parent().get_node("Stats")


func _on_Regeneration_timer_timeout():
	if stats.resolve > stats.max_resolve:
		stats.resolve = stats.max_resolve
	if stats.resolve < stats.max_resolve:
		if not parent.is_attacking:
			if not parent.is_running and not parent.is_sprinting and not parent.is_swimming:
				stats.resolve += stats.recovery * 0.35
