extends Camera

export (NodePath) var target
onready var player = get_node(target)
export (float) var mouse_sense = 0.1

func _process(_delta: float) -> void:
	# Update the position of the minimap camera
	translation = Vector3(player.translation.x, 30, player.translation.z)
	
