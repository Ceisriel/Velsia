extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"
onready var player = get_parent()
onready var stats = get_parent().get_node("Stats")
onready var camera = $"../Camroot/h/v/Camera" 
func _ready():
	loadPlayerData()


func savePlayerData2():
	var data = {
		"position": player.translation,
		"rotation": player.rotation_degrees,
		"camera_rotation": camera.rotation_degrees,  # Save the camera's rotation
		"camera_position": camera.translation,
		"accuracy": stats.accuracy,
		"acrobatics": stats.acrobatics,
		"agility": stats.agility,
		"athletics": stats.athletics,
		"balance": stats.balance,
		"charisma": stats.charisma,
		"cooridnation": stats.coordination,
		"dexterity": stats.dexterity,
		"endurance": stats.endurance,
		"flexibility": stats.flexibility,
		"focus": stats.focus,
		"impact": stats.impact,
		"intelligence": stats.intelligence,
		#"loyalty": stats.loyalty,
		"power": stats.power,
		"recovery": stats.recovery,

		"resistance": stats.resistance,
		"strength": stats.strength,
		"vitality": stats.vitality,
		"willpower": stats.willpower,
		"wisdom": stats.wisdom,
		"tenacity": stats.tenacity,
		
		"health": stats.health,
		
		"attributes": stats.attribute,
		"attributes_spent": stats.spent_attribute_points,
		}
		
		
func savePlayerData():
	var data = {
		"position": player.translation,
		#"rotation": player.rotation_degrees,
		#"camera_rotation": camera.rotation_degrees,  # Save the camera's rotation
		#"camera_position": camera.translation,

		#"attributes_spent": stats.spent_attribute_points,		
		
#Brain attributes
		#"creativity": stats.creativy,
		"wisdom" : stats.wisdom,
		"memory": stats.memory,
		"intelligence": stats.intelligence,
		"willpower": stats.willpower,

#Brute attributes
		"power": stats.power,
		"strength": stats.strength,
		"impact": stats.impact,
		"resistance": stats.resistance,
		"tenacity": stats.tenacity,

#Precision attributes
		"accuracy": stats.accuracy,
		"dexterity": stats.dexterity,
		"coordination": stats.coordination,
		"balance": stats.balance,
		"focus": stats.focus,

#Nimble attributes
		"acrobatics": stats.acrobatics,
		"agility": stats.agility,
		"athletics": stats.athletics,
		"flexibility": stats.flexibility,
		"placeholder_": stats.placeholder_,

#Toughness attributes
		"endurance": stats.endurance,
		"stamina": stats.stamina,
		"vitality": stats.vitality,
		"vigor": stats.vigor,
		"recovery": stats.recovery,

#Social attributes 
		"charisma": stats.charisma,
		"loyalty": stats.loyalty,
		"diplomacy": stats.diplomacy,
		"leadership": stats.leadership,
		"empathy": stats.empathy,

#crude stats
		"health_percent": stats.health_percent,
		"health": stats.health,
		"energy": stats.energy,
		"resolve": stats.resolve,
		"max_health": stats.max_health,
		"max_energy": stats.max_energy,
		"max_resolve": stats.max_resolve,
		
		
#leveling 
		"attribute": stats.attribute,
		"spent_attribute_points_int": stats.spent_attribute_points_int,
		"spent_attribute_points_wis": stats.spent_attribute_points_wis,
		"spent_attribute_points_cha": stats.spent_attribute_points_cha,
		}

	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)

	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_var(data)
		file.close()

func loadPlayerData():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "P@paB3ar6969")
		if error == OK:
			var player_data = file.get_var()
			file.close()


			for attribute in ["position", "rotation", "camera_rotation", "camera_position", "accuracy", "acrobatics", "agility", "athletics", "balance", "charisma", "coordination", "dexterity", "endurance", "flexibility", "focus", "impact", "intelligence", "power", "recovery", "resilience", "resistance", "strength", "vitality", "willpower", "wisdom", "tenacity", "health","attribute","spent_attribute_points_cha","spent_attribute_points_wis", "spent_attribute_points_int", "coordination", "health_percent"]:
				if attribute in player_data:
					if attribute == "position":
						player.translation = player_data[attribute]
					elif attribute == "rotation":
						player.rotation_degrees = player_data[attribute]
					elif attribute == "camera_rotation":
						camera.rotation_degrees = player_data[attribute]
					elif attribute == "camera_position":
						camera.translation = player_data[attribute]
					if attribute == "attributes":
						stats.attributes = player_data[attribute]  # Assuming stats.attributes is a dictionary
					if attribute == "health":
						stats.health = player_data[attribute]  # Assuming stats.attributes is a dictionary	
					if attribute == "max_health":
						stats.max_health = player_data[attribute]  # Assuming stats.attributes is a dictionary											
					elif attribute == "attributes_spent":
						stats.spent_attribute_points = player_data[attribute]
					else:
						stats.set(attribute, player_data[attribute])

func resetSavedData():
	var dir = Directory.new()
	if dir.file_exists(save_path):
		dir.remove(save_path)
		print("Saved data reset")

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_P:  # Replace with the desired key code
			resetSavedData()

func console_write(value):
	print(str(value))




func _on_SaveDataTimer_timeout():
	savePlayerData()
