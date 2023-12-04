extends Spatial

onready var an = $"../AnimationPlayer"
onready var parent  =$"../.."
onready var blend = 0.3


func animations():
	if parent.is_attacking:
		an.play("fireball",blend)
	elif not parent.is_on_floor() and parent.is_climbing:
		an.play("climb",blend)			
	elif Input.is_action_pressed("jump") and parent.is_walking:
		if not parent.is_climbing:
			an.play("fall",blend)			
	
	elif parent.is_walking:
		an.play("walk")

	elif Input.is_action_pressed("jump"):
		if not parent.is_climbing:
			an.play("fall",blend)		
		
	elif not parent.is_on_floor():
		if not parent.is_climbing:
			an.play("fall",blend)		
					
	else:
		an.play("idle", blend)	

func _on_FPS_timeout():
	animations()
