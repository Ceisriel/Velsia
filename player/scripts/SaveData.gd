extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"
onready var player = get_parent()
onready var camera = $"../Camroot/h/v/Camera" 
func _ready():
	loadPlayerData()


func savePlayerData():
	var data = {
		"position": player.translation,
		"rotation": player.rotation_degrees,
		"camera_rotation": camera.rotation_degrees,  # Save the camera's rotation
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
				player.rotation = player_data["rotation"]
			if "camera_rotation" in player_data:
				camera.rotation_degrees = player_data["camera_rotation"]  # Set the camera's rotation


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


func _on_Button_pressed():
	loadPlayerData()

