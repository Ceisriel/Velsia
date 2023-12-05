extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"
onready var player = get_parent()
onready var player_mesh = get_parent().get_node("Mesh")
onready var stats = get_parent().get_node("Stats")
onready var camera = get_parent().get_node("Camroot/h/v/Camera")
onready var camera_h = get_parent().get_node("Camroot/h")
onready var camera_v = get_parent().get_node("Camroot/h/v")
func _ready():
	loadPlayerData()


func savePlayerData():
	var data = {
		"position": player.translation,
		"rotation": player_mesh.rotation_degrees,
#camera stuff
		"H_rotation": camera_h.rotation_degrees,
		"V_rotation": camera_v.rotation_degrees,
		"camera_position": camera.translation,
		"camera_rotation": camera.rotation_degrees,  # Save the camera's rotation		
#Attributes		
#leveling 
		"attribute": stats.attribute,
		"spent_attribute_points_int": stats.spent_attribute_points_int,
		"spent_attribute_points_wis": stats.spent_attribute_points_wis,
		"spent_attribute_points_cha": stats.spent_attribute_points_cha,
		"spent_attribute_points_vit": stats.spent_attribute_points_vit,
		
#Brain attributes
		"creativity": stats.creativity,
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

			if "position" in player_data:
				player.translation = player_data["position"]
			if "rotation" in player_data:
				player.rotation_degrees = player_data["rotation"]
#attributes 
			if "attribute" in player_data:
				 stats.attribute = player_data["attribute"]
			if "spent_attribute_points_int" in player_data:
				stats.spent_attribute_points_int = player_data["spent_attribute_points_int"]
			if "spent_attribute_points_cha" in player_data:
				stats.spent_attribute_points_cha = player_data["spent_attribute_points_cha"]
			if "spent_attribute_points_wis" in player_data:
				stats.spent_attribute_points_wis = player_data["spent_attribute_points_wis"]
			if "spent_attribute_points_vit" in player_data:
				stats.spent_attribute_points_vit = player_data["spent_attribute_points_vit"]
#Brute attributes
			if "power" in player_data:
				stats.power = player_data["power"]
			if "strength" in player_data:
				stats.strength = player_data["strength"]				
			if "impact" in player_data:
				stats.impact = player_data["impact"]				
			if "resistance" in player_data:
				stats.resistance = player_data["resistance"]
			if "tenacity" in player_data:
				stats.tenacity = player_data["tenacity"]
#Brain attributes
			if "creativity" in player_data:
				stats.creativity = player_data["creativity"]
			if "wisdom" in player_data:
				stats.wisdom = player_data["wisdom"]
			if "memory" in player_data:
				stats.memory = player_data["memory"]				
			if "intelligence" in player_data:
				stats.intelligence = player_data["intelligence"]				
			if "willpower" in player_data:
				stats.willpower = player_data["willpower"]
#Precision attributes
			if 	"accuracy" in player_data:
				 stats.accuracy = player_data["accuracy"]
			if "dexterity" in player_data:
				stats.dexterity = player_data["dexterity"]
			if "cooridnation" in player_data:
				stats.coordination = player_data["cooridnation"]								
			if "balance" in player_data:
				stats.balance = player_data["balance"]
			if "focus" in player_data:
				stats.focus  = player_data["focus"]
#Nimble attributes
			if "acrobatics" in player_data:
				 stats.acrobatics = player_data["accuracy"]
			if "agility" in player_data:
				 stats.agility = player_data["agility"]
			if "flexibility" in player_data:
				stats.flexibility = player_data["flexibility"]
			if "athletics" in player_data:
				stats.athletics = player_data["athletics"]				
#Toughness attributes
			if "endurance" in player_data:
				stats.dexterity = player_data["endurance"] 
			if "stamina" in player_data:
				stats.stamina = player_data["stamina"]
			if "vitality" in player_data:
				stats.vitality = player_data["vitality"]
			if "vigor" in player_data:
				stats.vigor = player_data["vigor"]
			if "recovery" in player_data:
				stats.recovery = player_data["recovery"]
#Social attributes 
			if "charisma" in player_data:
				stats.charisma = player_data["charisma"]
			if "loyalty" in player_data:
				stats.loyalty = player_data["loyalty"]
			if "diplomacy" in player_data:
				stats.diplomacy = player_data["diplomacy"]
			if "leadership" in player_data:
				stats.leadership = player_data["leadership"]
			if "empathy" in player_data:
				stats.empathy = player_data["empathy"]
#crude stats 				
			if "health" in player_data:
				stats.health = player_data["health"]
			if "max_health" in player_data:
				stats.max_health = player_data["max_health"]				
			if "energy" in player_data:
				stats.energy = player_data["energy"]
			if "max_energy" in player_data:
				stats.max_energy = player_data["max_energy"]
			if "resolve" in player_data:
				stats.resolve = player_data["resolve"]
			if "max_resolve" in player_data:
				stats.max_resolve = player_data["max_resolve"]

				
				
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
