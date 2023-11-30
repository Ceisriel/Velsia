extends Label


func _physics_process(_delta):
	# Display FPS in the label, adding 15
	text = "FPS: %d" % (Engine.get_frames_per_second()) 

