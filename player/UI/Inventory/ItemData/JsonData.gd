extends Node

var item_data: Dictionary

func _ready():
	item_data = load_data("res://Data/ItemData.json")

func load_data(file_path: String) -> Dictionary:
	var json_data: JSONParseResult
	var file_data = File.new()

	# Open the file using the correct file path
	if file_data.open(file_path, File.READ) == OK:
		json_data = JSON.parse(file_data.get_as_text())
		file_data.close()
		return json_data.result as Dictionary  # Access the 'result' property
	else:
		print("Failed to open file:", file_path)
		return {}
