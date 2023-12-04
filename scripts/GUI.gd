extends CanvasLayer

onready var music_scene = preload("res://Music/BackgroundMusic.tscn")
onready var debug_memory = $MEM
onready var parent = get_parent()
onready var inventory = $Inventory
onready var stats = $"../Stats"
onready var intlabel = $Inventory/AspectRatioContainer/TextureRect/Int/IntLabel
onready var charlabel = $Inventory/AspectRatioContainer/TextureRect/Char/CharLabel
var music_instance = null

func _on_FPS_timeout():
	if Input.is_action_just_pressed("inventory"):
		inventory.visible = !inventory.visible
	debug_memory.text = "Memory: %.3f MB" % (OS.get_static_memory_usage() / (1024.0 * 1024.0))
	updatelabels()
	
func _on_Unstuck_pressed():
	# teleport to coordinates 0, 10, 0
	parent.translation = Vector3(0, 10, 0)
func _on_Music_pressed():
	if music_instance:
		# If music is already playing, free the instance
		music_instance.queue_free()
		music_instance = null
	else:
		# If music is not playing, instance and add as a child
		music_instance = music_scene.instance()
		parent.add_child(music_instance)

func updatelabels():
	intlabel.text = "%.4f" % stats.intelligence
	charlabel.text = "%.4f" % stats.charisma
func _on_IntMin_pressed():
	if stats.intelligence > 0.056:
		stats.attribute += 1
		stats.intelligence -= 0.025
		

func _on_IntPlus_pressed():
	if stats.attribute > 0:
		stats.attribute -= 1
		stats.intelligence += 0.025





func _on_CharMin_pressed():
	if stats.charisma > 0.056:
		stats.attribute += 1
		stats.charisma -= 0.025



func _on_CharPlus_pressed():
	if stats.attribute > 0:
		stats.attribute -= 1
		stats.charisma += 0.025
		
