extends Label

func _process(_delta):
	# Get the parent node
	var parent_node = get_parent()
	# Display parent node position rounded to 2 decimals
	var parent_position = parent_node.global_transform.origin
	var rounded_position = Vector3(
			round(str2var(str(parent_position.x)) * 100) / 100,
			round(str2var(str(parent_position.y)) * 100) / 100,
			round(str2var(str(parent_position.z)) * 100) / 100
		)
	text = "Position: %s" % str(rounded_position)
