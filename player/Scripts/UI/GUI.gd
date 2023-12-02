extends Node

onready var health_label = $"../FPS/Labels/HPLabel"
onready var parent: Node = get_parent()
onready var stats = $"../Stats"


func _physics_process(_delta):
	var healthText = "Health: %.2f / %.2f" % [stats.health, stats.max_health]
	health_label.text = healthText
