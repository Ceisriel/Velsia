extends Control

onready var hp = $Label
onready var en = $"../Energy/Label"
onready var re = $"../Resolve/Label"
onready var stats = $"../../Stats"
onready var health_bar = $Healthbar
onready var energy_bar = $"../Energy/Energybar"
onready var res_bar = $"../Resolve/ResolveBar"

func _ready():


	healthUpdate()


func healthUpdate():
	health_bar.value = stats.health
	energy_bar.value = stats.energy
	health_bar.max_value = stats.max_health
	energy_bar.max_value = stats.max_energy
	res_bar.value = stats.resolve
	res_bar.max_value = stats.max_resolve

func _on_FPS_timeout():
	var health_text = "HP: %.2f / %.2f" % [stats.health, stats.max_health]
	var energy_text = "EN: %.2f / %.2f" % [stats.energy, stats.max_energy]
	var resolve_text = "RE: %.2f / %.2f" % [stats.resolve, stats.max_resolve]
	hp.text = health_text
	en.text = energy_text
	re.text = resolve_text

	healthUpdate()


