extends CanvasLayer

onready var music_scene = preload("res://Music/BackgroundMusic.tscn")
onready var debug_memory = $MEM
onready var parent = get_parent()
var music_instance = null

func _on_FPS_timeout():
	debug_memory.text = "Memory: %.3f MB" % (OS.get_static_memory_usage() / (1024.0 * 1024.0))

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
