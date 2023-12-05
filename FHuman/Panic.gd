extends Node
onready var parent = get_parent()
onready var stats = get_parent().get_node("Stats")
onready var eyes = get_parent().get_node("Eyes")
onready var panic_timer = $PanicTimer
var scared = false


func _physics_process(_delta):
	panicStart()

func panicStart():
	if Input.is_action_just_pressed("Test2"):
		panic_timer.start()
		scared = true
		get_parent().is_aiming = true

func panic():
	var movement = -parent.direction * 0.03
	parent.global_translate(movement)
	parent.stiffCamera()




func _on_PanicTimer_timeout():
	panic_timer.stop()
	scared = false
	get_parent().is_aiming = false
