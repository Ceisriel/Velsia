extends KinematicBody

var health = 100

var interval = 1
var duration = 5
onready var floating_text = preload("res://player/UI/floatingtext.tscn")
onready var takedamagesprite = $InfoSprite/View


func _on_FPS_timeout():
	pass	
func takeDamage(damage):
	health -= damage
	var text = floating_text.instance()
	text.amount = round_to_two_decimals(damage)
	takedamagesprite.add_child(text)
func round_to_two_decimals(number):
	return round(number * 100.0) / 100.0



