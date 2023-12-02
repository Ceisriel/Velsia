extends Control


func _on_FPS_timeout():
	if Input.is_action_just_pressed("hide_ui"):
		visible = !visible
	# Display FPS in the label, adding 15
	$FPSLabel.text = "FPS: %d" % (Engine.get_frames_per_second()) 	
	var parent_node = $"../.."
	# Display parent node position rounded to 2 decimals
	var parent_position = parent_node.global_transform.origin
	var rounded_position = Vector3(
			round(str2var(str(parent_position.x)) * 100) / 100,
			round(str2var(str(parent_position.y)) * 100) / 100,
			round(str2var(str(parent_position.z)) * 100) / 100
		)
	$POSLabel.text = "Position: %s" % str(rounded_position)
	$SCELabel.text += "Scene Tree Nodes: %d\n" % get_tree().get_node_count()	# Get the current date and time
	var datetime = OS.get_datetime()

	# Display hour and minute in the label
	$TIMLabel.text = "Time: %02d:%02d" % [datetime.hour, datetime.minute]
	# Display memory usage in the label
	$MEMLabel.text = "Memory: %d MB" % (OS.get_static_memory_usage() / (1024 * 1024))



