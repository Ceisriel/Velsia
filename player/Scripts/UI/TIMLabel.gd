extends Label

func _process(_delta):
	# Get the current date and time
	var datetime = OS.get_datetime()

	# Display hour and minute in the label
	text = "Time: %02d:%02d" % [datetime.hour, datetime.minute]
