extends Control


onready var agilabel = $inventory/Agi/AgiLabel
onready var intlabel = $inventory/Int/IntLabel
onready var stats =  $".."

func _physics_process(_delta):
	updateattributes()
	if Input.is_action_just_pressed("inventory"):
		self.visible = !self.visible
		



func updateattributes():
	stats.max_health = stats.st_max_health * stats.vitality
	stats.max_energy = stats.st_max_energy * stats.intelligence
	stats.walk_speed = stats.st_walk_speed * stats.agility
	agilabel.text = "%.3f" % stats.agility
	intlabel.text = "%.3f" % stats.intelligence

func _on_AgiPlus_pressed():
	if stats.attribute > 0:
		stats.attribute -= 0
		stats.agility += 0.025

func _on_AgiMin_pressed():
	if stats.agility > 0.11:
		stats.attribute += 1
		stats.agility -= 0.025
func _on_IntPlus_pressed():
	if stats.attribute > 0:
		stats.attribute -= 0
		stats.intelligence += 0.55

func _on_IntMin_pressed():
	if stats.attribute > 0.11:
		stats.attribute += 1
		stats.intelligence -= 0.025
		
		
func _on_Process_timeout():
	updateattributes()





