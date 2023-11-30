extends Node

onready var camera = $"../h/v/Camera"
var zoom_speed = 0.1  # Adjust the zoom speed as needed
var min_fov = 30.0  # Adjust the minimum FOV as needed
var max_fov = 90.0  # Adjust the maximum FOV as needed
var min_size = 5.0  # Adjust the minimum size as needed
var max_size = 20.0  # Adjust the maximum size as needed

func _input(event):
	if event is InputEventKey:
		# Check for arrow key inputs
		if event.pressed:
			match event.scancode:
				KEY_UP:
					adjust_zoom(-zoom_speed)
				KEY_DOWN:
					adjust_zoom(zoom_speed)
	elif event is InputEventMouseMotion:
		# Check if the event is related to the mouse wheel
		if event.device == 1:
			# Zoom the camera based on the vertical movement of the scroll wheel
			var zoom_amount = event.y * zoom_speed

			# Check if the camera uses perspective or orthogonal projection
			if camera.projection == Camera.PROJECTION_PERSPECTIVE:
				# Adjust the field of view for perspective projection
				camera.fov = clamp(camera.fov - zoom_amount, min_fov, max_fov)
			elif camera.projection == Camera.PROJECTION_ORTHOGONAL:
				# Adjust the size for orthogonal projection
				camera.size = clamp(camera.size - zoom_amount, min_size, max_size)

func adjust_zoom(amount):
	# Check if the camera uses perspective or orthogonal projection
	if camera.projection == Camera.PROJECTION_PERSPECTIVE:
		# Adjust the field of view for perspective projection
		camera.fov = clamp(camera.fov + amount, min_fov, max_fov)
	elif camera.projection == Camera.PROJECTION_ORTHOGONAL:
		# Adjust the size for orthogonal projection
		camera.size = clamp(camera.size + amount, min_size, max_size)
