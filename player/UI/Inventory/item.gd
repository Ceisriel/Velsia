extends Node2D

var stack_size
var item_name
var item_quantity
var stack_size_max = 9999999999999
onready var texture = $TextureRect
onready var label = $Label

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		item_name = "Iron Sword"
		stack_size = 1
	elif rand_val == 1:
		item_name = "Tree Branch"
		stack_size = stack_size_max
	else:
		item_name = "Slime Potion"
		stack_size = stack_size_max

	texture.texture = load("res://player/UI/Inventory/ItemIcons/" + item_name + ".png")
	item_quantity = randi() % stack_size + 1

	if stack_size == 1:
		label.visible = false
	else:
		labeltext()

func labeltext():
	var formatted_quantity = format_number(item_quantity)
	label.text = formatted_quantity

func round_to_one_decimal(number):
	return round(number * 10.0) / 10.0

func format_number(number):
	if number >= 1000000000:   # 1 billion
		return str(round_to_one_decimal(number / 1000000000.0)) + "b"
	elif number >= 1000000:      # 1 million
		return str(round_to_one_decimal(number / 1000000.0)) + "m"
	elif number >= 1000:         # 1 thousand
		return str(round_to_one_decimal(number / 1000.0)) + "k"
	else:
		return str(number)

func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	labeltext()

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	labeltext()
