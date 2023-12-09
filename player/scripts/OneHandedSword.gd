extends Node

onready var player = get_parent().get_parent()
onready var stats = player.get_node("Stats")
onready var weapons = $".."

var critical_chance : float = 0.5  # Adjust this value for the critical chance

func baseAttackMovement():
	player.horizontal_velocity = player.direction * stats.agility * (player.dash_power * 0.45)

func dealBaseDamage():
	var damage = stats.strength * 7

	# Introduce a chance to deal critical damage
	if randf() < critical_chance:
		damage *= 1.5  # 50% more damage for critical hit

	var hitbox = weapons.currentInstance.get_node("Hitbox")
	var bodies = hitbox.get_overlapping_bodies()

	for body in bodies:
		if body.is_in_group("Enemy"):
			var body_stats = body.get_node("Stats")
			var info_sprite = body.get_node("InfoSprite")
			body_stats.health -= damage
			info_sprite.showDamageTaken(damage)
