extends Spatial

onready var an = $AnimationPlayer
onready var parent  = $".."
onready var blend = 0.3
onready var weapon = $"../RightHandWeaponManager"
onready var onehandedsword = $"../RightHandWeaponManager/OneHandedSword"

func animations():
	if Input.is_action_pressed("attack"):
		if weapon.currentInstance != null:
			if not parent.is_cursor:
				an.play("base attack sword")
				onehandedsword.baseAttackMovement()
	#elif parent.frontstep:
		#an.play("slide", blend)	
	#elif not parent.is_on_floor() and parent.is_climbing:
	#	an.play("climb",blend)			
	#elif Input.is_action_pressed("jump") and parent.is_walking:
	#	if not parent.is_climbing:
		#	an.play("fall",blend)			
	
	elif parent.is_walking:
		an.play("Walk")

	#elif Input.is_action_pressed("jump"):
		#if not parent.is_climbing:
			#an.play("fall",blend)		
		
	#elif not parent.is_on_floor():
		#if not parent.is_climbing:
		#	an.play("fall",blend)		
					
	else:
		an.play("Idle", blend)	

func _on_FPS_timeout():
	animations()
