extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"
onready var player = get_parent()
onready var stats = get_parent().get_node("Stats")
onready var camera = $"../Camroot/h/v/Camera" 
func _ready():
	loadPlayerData()


func savePlayerData():
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
		"cooridnation": stats.cooridnation,
		"dexterity": stats.dexterity,
		"endurance": stats.endurance,
		"flexibility": stats.flexibility,
		"focus": stats.focus,
		"impact": stats.impact,
		"intelligence": stats.intelligence,
		"loyalty": stats.loyalty,
		"power": stats.power,
		"purity": stats.purity,
		"recovery": stats.recovery,
		"resilience": stats.resilience,
		"resistance": stats.resistance,
		"strength": stats.strength,
		"vitality": stats.vitality,
		"willpower": stats.willpower,
		"wisdom": stats.wisdom,
		"tenacity": stats.tenacity,
		"health": stats.health,
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

			for attribute in ["position", "rotation", "camera_rotation","camera_position", "accuracy", "acrobatics", "agility", "athletics", "balance", "charisma", "coordination", "dexterity", "endurance", "flexibility", "focus", "impact", "intelligence", "loyalty", "power", "purity", "recovery", "resilience", "resistance", "strength", "vitality", "willpower", "wisdom", "tenacity","health"]:
				if attribute in player_data:
					if attribute == "position": # this works 
						player.translation = player_data[attribute]
					if attribute == "rotation": #bugged for some reason
						player.rotation = player_data[attribute]
					if attribute == "camera_rotation": #bugged for some reason
						camera.rotation_degrees = player_data[attribute]
					if attribute == "camera_position": #bugged for some reason
						camera.translation = player_data[attribute]	
					else: # this works 
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
