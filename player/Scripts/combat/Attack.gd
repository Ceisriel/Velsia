extends Node

onready var explosion_scene = preload("res://player/skills/fireball/FireballExplosion.tscn")
onready var fireball_scene = preload("res://player/skills/fireball/fireball.tscn")
onready var parent = get_parent()
onready var muzle = $"../Hunter/muzle"
onready var aim = $"../Camroot/h/v/Camera/RayCast"
onready var hitbox = $"../Hunter/Area"
var damage = 12
var effect = 0.5
var duration = 3

func dealDamage():
	var enemies = hitbox.get_overlapping_bodies()
	for enemy in enemies:
		if enemy.is_in_group("Enemy"):
			enemy.takeDamage(damage)
			enemy.getSlowed(effect)
			


func _physics_process(_delta):
	if Input.is_action_just_pressed("attack"):
		shoot()


func shoot():
	var new_fireball = fireball_scene.instance()
	muzle.add_child(new_fireball)
	new_fireball.look_at(aim.get_collision_point(),Vector3.UP)
	


