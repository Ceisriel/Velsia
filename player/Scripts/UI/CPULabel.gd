extends Label


func _process(_delta):
	# Display memory usage in the label
	text = "Memory: %d MB" % (OS.get_static_memory_usage() / (1024 * 1024))
