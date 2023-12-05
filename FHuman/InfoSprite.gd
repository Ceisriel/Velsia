extends Spatial

onready var takedamagesprite = $DamageView
onready var floating_text_heal = preload("res://player/UI/floatingtextGreen.tscn")
onready var floating_text = preload("res://player/UI/floatingtextRed.tscn")


func showDamageTaken(damage):
	var text = floating_text.instance()
	text.amount = round_to_two_decimals(damage)
	takedamagesprite.add_child(text)
func showCriticalDamagetaken(critical_damage):
	var text = floating_text.instance()
	text.amount = round_to_two_decimals(critical_damage)
	takedamagesprite.add_child(text)	
func round_to_two_decimals(number):
	return round(number * 100.0) / 100.0	

func showHealing(heal):
	var text = floating_text_heal.instance()
	text.amount = round_to_two_decimals(heal)
	takedamagesprite.add_child(text)	

