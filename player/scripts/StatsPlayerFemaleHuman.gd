extends Node

#crude stats
var health = 100
const base_health = 100
var max_health = 100
const base_max_health = 100
var energy = 100
var max_energy = 100
const base_max_energy = 100
var resolve = 100
var max_resolve = 100
const base_max_resolve = 100

var weight = 120
var walk_speed = 3 
var run_speed = 6
var climb_speed = 1.5
var jumping_power = 5
var dash_power = 12
var attribute = 100000000
var spent_attribute_points = 0
var defense =  10
var coordination = 1

var creativity = 1
var wisdom = 1
var memory = 1
var intelligence = 1
var willpower = 1

var power = 1
var strength = 1.5
var impact = 1
var resistance = 1
var tenacity = 1

var accuracy = 1
var dexterity = 1

var balance = 1
var focus = 1

var acrobatics = 1
var agility = 1
var athletics = 1
var flexibility = 1
var placeholder_ = 1

var endurance = 1
var stamina = 1
var vitality = 1
var vigor = 1
var recovery = 1

var charisma = 1
var loyalty = 1 
var diplomacy = 1
var leadership = 1
var empathy = 1



#Leveling compounding attributes 
var spent_attribute_points_cre = 0
var spent_attribute_points_wis = 0
var spent_attribute_points_mem = 0
var spent_attribute_points_int = 0
var spent_attribute_points_wil = 0

var spent_attribute_points_pow = 0
var spent_attribute_points_str = 0
var spent_attribute_points_imp = 0
var spent_attribute_points_res = 0
var spent_attribute_points_ten = 0

var spent_attribute_points_acc = 0
var spent_attribute_points_dex = 0

var spent_attribute_points_bal = 0
var spent_attribute_points_foc = 0

var spent_attribute_points_acr = 0
var spent_attribute_points_agi = 0
var spent_attribute_points_ath = 0
var spent_attribute_points_fle = 0
#var placeholder_

var spent_attribute_points_end = 0
var spent_attribute_points_sta = 0
var spent_attribute_points_vit = 0
var spent_attribute_points_vig = 0
var spent_attribute_points_rec = 0

var spent_attribute_points_cha = 0
var spent_attribute_points_loy = 0 
var spent_attribute_points_dip = 0
var spent_attribute_points_lea = 0
var spent_attribute_points_emp = 0


#_______stored______
var st_charisma = charisma
var st_loyalty =  loyalty
var st_diplomacy = diplomacy
var st_leadership = leadership
var st_empathy = empathy

var st_accuracy = accuracy
var st_dexterity = dexterity
var st_coordination = coordination
var st_balance = balance
var st_focus = focus

var st_endurance = endurance
var st_stamina = stamina
var st_vitality = vitality
var st_vigor = vigor
var st_recovery = recovery

var st_acrobatics = acrobatics
var st_agility = agility
var st_athletics = athletics
var st_flexibility = flexibility
var st_placeholder = placeholder_


var st_power = power
var st_strength = strength
var st_impact = impact
var st_resistance = resistance
var st_tenacity = tenacity

var st_creativity = creativity
var st_wisdom = wisdom
var st_memory = memory
var st_intelligence = intelligence
var st_willpower = willpower




