extends CanvasLayer

onready var music_scene = preload("res://Music/BackgroundMusic.tscn")
onready var debug_memory = $MEM
onready var parent = get_parent()
onready var inventory = $Inventory
onready var stats = $"../Stats"
onready var attlabel = $Inventory/AspectRatioContainer/TextureRect/AttLabel
onready var at_int_l = $Inventory/AspectRatioContainer/TextureRect/Int/AttLabelInt
onready var at_cha_l = $Inventory/AspectRatioContainer/TextureRect/Char/AttLabelCha
onready var at_wis_l = $Inventory/AspectRatioContainer/TextureRect/Wis/AttLabelWis
onready var at_vit_l = $Inventory/AspectRatioContainer/TextureRect/Vit/AttLabelVit

onready var deflabel = $Inventory/AspectRatioContainer/TextureRect/DefLabel
onready var reslabel = $Inventory/AspectRatioContainer/TextureRect/ResLabel
onready var vitlabel = $Inventory/AspectRatioContainer/TextureRect/Vit/VitLabel
onready var intlabel = $Inventory/AspectRatioContainer/TextureRect/Int/IntLabel
onready var charlabel = $Inventory/AspectRatioContainer/TextureRect/Char/CharLabel
onready var wislabel = $Inventory/AspectRatioContainer/TextureRect/Wis/WisLabel

var music_instance = null

func healthMult():
	stats.max_health = stats.base_max_health * stats.vitality
	stats.health = stats.health

func _on_FPS_timeout():
	if Input.is_action_just_pressed("inventory"):
		inventory.visible = !inventory.visible

	debug_memory.text = "Memory: %.3f MB" % (OS.get_static_memory_usage() / (1024.0 * 1024.0))
	updatelabels()
	healthMult()

	
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
	intlabel.text = "%.3f" % stats.intelligence
	charlabel.text = "%.3f" % stats.charisma
	wislabel.text = "%.3f" % stats.wisdom
	vitlabel.text = "%.3f" % stats.vitality
	attlabel.text = "%d" % stats.attribute
	at_int_l.text = "spent %d" % stats.spent_attribute_points_int
	at_cha_l.text = "spent %d" % stats.spent_attribute_points_cha
	at_wis_l.text = "spent %d" % stats.spent_attribute_points_wis
	at_vit_l.text = "spent %d" % stats.spent_attribute_points_vit
	deflabel.text = "defense %d" % stats.defense
	reslabel.text = "resistance %d" % stats.resistance

func _on_IntPlus_pressed():
	if stats.attribute > 0:
		stats.spent_attribute_points_int += 1
		stats.attribute -= 1
		stats.intelligence += 0.05
func _on_IntMin_pressed():
	if stats.intelligence > 0.056:
		stats.spent_attribute_points_int -= 1
		stats.attribute += 1
		stats.intelligence -= 0.05	
		
func _on_CharPlus_pressed():
	if stats.attribute > 0:
		stats.spent_attribute_points_cha += 1
		stats.attribute -= 1 
		stats.charisma += 0.05
func _on_CharMin_pressed():
	if stats.charisma > 0.056:
		stats.spent_attribute_points_cha -= 1
		stats.attribute += 1		
		stats.charisma -= 0.05
func _on_WisPlus_pressed():
	if stats.attribute > 0:
		stats.spent_attribute_points_wis += 1
		stats.attribute -= 1		
		stats.wisdom += 0.05
func _on_WisMin_pressed():
	if stats.wisdom > 0.056:
		stats.spent_attribute_points_wis -= 1
		stats.attribute += 1		
		stats.wisdom -= 0.05
func _on_VitPlus_pressed():
	if stats.attribute > 0:
		stats.spent_attribute_points_vit += 1
		stats.attribute -= 1		
		stats.vitality += 0.05
		stats.health = stats.max_health
func _on_VitMin_pressed():
	if stats.vitality > 0.056:
		stats.spent_attribute_points_vit -= 1
		stats.attribute += 1		
		stats.vitality -= 0.05
		stats.health = stats.max_health



