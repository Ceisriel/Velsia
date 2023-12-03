extends Node


onready var parent = get_parent()
onready var stats = parent.get_node("Stats")
onready var info_sprite = parent.get_node("InfoSprite")
onready var heal_timer = $HealTimer
var totalHealingDuration = 5.0  # Set the total duration for healing in seconds
var currentHealingTime = 0.0

func _physics_process(delta):
	Heal()
	notExceedMaxHealth()
	startHealing()
func notExceedMaxHealth():
	if stats.health > stats.max_health:
		stats.health = stats.max_health
	
	
#__________________Instantanous healing__________________	
func Heal():
	notExceedMaxHealth()
	var heal = stats.intelligence * (stats.defense * 0.25) + (stats.recovery * 0.666)
	if Input.is_action_pressed("E"):
		if stats.health < stats.max_health:
			stats.health += heal
			info_sprite.showHealing(heal)
		else:
			if stats.energy < stats.max_energy:
				stats.energy + 5
#__________________Continuous healing__________________
#Has a minimum healing amount, but the healing is also based on:
#A percentage of current player health, recovery and intelligence
func startHealing():
	if Input.is_action_pressed("R"):
		totalHealingDuration = stats.intelligence * 10
		currentHealingTime = 0.0  # Reset the current healing time
		# Start the heal timer
		heal_timer.start()
func startHealingAuto():
		totalHealingDuration = stats.intelligence * 10
		currentHealingTime = 0.0  # Reset the current healing time
		# Start the heal timer
		heal_timer.start()		
func stopHealing():
	# Stop the heal timer
	heal_timer.stop()
func _on_HealTimer_timeout():
	var heal_percentage = 0.05
	var baseHeal = stats.intelligence * (max(stats.health, 0) * heal_percentage) + stats.recovery
	var minimum_heal = stats.intelligence * 2.25
	var heal = max(baseHeal, minimum_heal)
	info_sprite.showHealing(heal)
	if stats.health < stats.max_health:
		stats.health += max(heal, 2.0)  # Ensure heal is never smaller than 2
		

	currentHealingTime += 0.5

	# Check if the total healing duration has been reached
	if currentHealingTime >= totalHealingDuration:
		stopHealing()  # Stop the healing process

