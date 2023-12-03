extends Node

onready var parent: Node = get_parent()
var toggle_visibility: bool = true

func visibleInvisible():
	if Input.is_action_just_pressed("invisible"):
		toggle_visibility = !toggle_visibility
		parent.visible = toggle_visibility

func _on_FPS_timeout():
	visibleInvisible()
