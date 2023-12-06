extends Node2D

var stack_size 
var item_name
var item_quantity
onready var texture = $TextureRect
onready var label = $Label

func _ready():
	var rand_val = randi()%3 
	if rand_val == 0:
		item_name = "Iron Sword"
		stack_size = 1
	elif rand_val ==1:
		item_name = "Tree Branch"
		stack_size = 5000
	else:
		item_name = "Slime Potion"
		stack_size  = 5000
		
	texture.texture = load("res://player/UI/Inventory/ItemIcons/" + item_name +".png")
	item_quantity = randi()% stack_size + 1
	
	if stack_size == 1:
		label.visible = false
	else:
		labeltext()
		
func labeltext():
	label.text = String(item_quantity)
	
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	label.text = String(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	label.text = String(item_quantity)
	
	
