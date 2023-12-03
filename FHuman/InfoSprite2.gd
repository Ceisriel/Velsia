extends Control

onready var hp = $Label
onready var stats = $"../../Stats"
onready var health_bar = $Healthbar
onready var update_tween = $HealthTween


func healthUpdate():
	health_bar.value = stats.health
	health_bar.max_value = stats.max_health

func _on_FPS_timeout():
	var healthText = "HP: %.2f / %.2f" % [stats.health, stats.max_health]
	hp.text = healthText
	healthUpdate()

