extends Spatial

onready var ani =$Fbody/AnimationPlayer
onready var parent = get_parent()
var merge = 0.2


func _on_FPS_timeout():
	animation()

func animation():
	if parent.throwing_fireball:
		ani.play("fireball", merge)				
	elif parent.is_jumping and parent.is_walking and not parent.is_climbing:
		ani.play("fall", merge)		
	elif parent.is_walking and parent.is_on_floor():
		ani.play("walk")
	elif parent.is_climbing:
		ani.play("climb",merge, parent.climbing_speed / 1.5)				
	elif parent.is_jumping:
		ani.play("jump",merge, 2.5)
	elif not parent.is_on_floor() and not parent.is_climbing:
		ani.play("fall",merge)
	else:
		ani.play("idle", merge)
