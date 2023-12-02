extends Spatial

var mouse_captured = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	if Input.is_action_just_pressed("alt"):
		toggle_mouse_capture()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func toggle_mouse_capture():
	mouse_captured = !mouse_captured
	if mouse_captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
