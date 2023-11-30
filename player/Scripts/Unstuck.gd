extends Node

onready var parent: Node = get_parent()


func _on_UnstuckButton_pressed(): #teleport to coordinates 0, 10 , 0
	parent.translation = Vector3(0, 10, 0)
