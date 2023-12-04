extends Node

#crude stats
var health = 100
var max_health = 100
var energy = 100
var max_energy = 100
var resolve = 100
var max_resolve = 100
var weight = 120
var walk_speed = 3 
var run_speed = 6
var climb_speed = 1.5
var jumping_power = 5
var dash_power = 12
var attribute = 10
var defense =  10
#stored 
var st_health = health
var st_max_health = max_health
var st_energy = max_energy
var st_max_energy = max_energy
var st_resolve = resolve
var st_max_resolve =  max_resolve
var st_weight = weight
var st_walk_speed = walk_speed
var st_run_speed = run_speed
var st_climb = climb_speed
var st_jumping_power = jumping_power
var st_dash_power = dash_power
var st_defense = defense

var accuracy = 1
var acrobatics = 1.25
var agility = 1
var athletics = 1
var balance = 1
var charisma = 1
var cooridnation = 1
var dexterity = 1
var endurance = 1
var flexibility = 1
var focus = 1
var impact = 1
var intelligence = 1
var loyalty = 1
var power = 1
var purity = 1
var recovery = 4.5
var resilience = 1
var resistance = 1
var strength = 1.5
var vitality = 1
var willpower = 1
var wisdom = 1
var tenacity = 1


#player attributes but stored, must have to update attributes with weapons and armors
var st_accuracy = accuracy
var st_acrobatics = acrobatics
var st_agility = agility
var st_athletics = athletics
var st_dexterity = dexterity
var st_endurance = endurance
var st_focus = focus
var st_impact = impact
var st_intelligence = intelligence
var st_power = power
var st_recovery = recovery
var st_resistance = resistance
var st_strength = strength
var st_vitality = vitality
var st_wisdom = wisdom
var st_balance = balance
var st_coordination = cooridnation
var st_charisma = charisma
var st_willpower = willpower 
var st_resilience = resilience
var st_flexibility = flexibility
var st_purity = purity
var st_loyalty = loyalty 
var st_tenacity = tenacity

func updateAttributes():
	climb_speed = st_climb * strength
	dash_power = st_dash_power * agility
	run_speed = st_run_speed * agility
