extends Node


var player_stats : Dictionary =  {}
var player_moves : Array = []



var all_moves : Array = [
	{
		"move_name" : "Fire Strike",
		"move_power" : 100,
		"move_accuracy" : 100



	},
	{
		"move_name" : "ice ball",
		"move_power" : 150,
		"move_accuracy" : 80,
	},

]


var all_enemies : Array = [
	{
		"enemy_name" : "Globin",
		"base_max_health": 300,
		"base_attack" : 100,
		"base_defense" : 200,
		"base_speed" : 50,
		"moves" : {
			"name" : "Charge!",
			"base_power":100,
			"accuracy":90
		},
	}
	
	
	
	
	
]



# GLOBAL FUNCTIONS 

	
	
	
func critical_yes_or_no(chance)-> bool: #chance is 
	randomize()
	var random_chance = randi_range(chance,100)
	if random_chance >= 90:
		return true
	else  : return false



func calculate_damage(level: int, attack: int, defense: int, attack_base_power: int, critical: bool) -> int:
	#base damage calculation
	var base_damage = (((2.0 * float(level) / 5.0) + 2.0) * float(attack_base_power) * float(attack) / float(defense)) / 50.0 + 2.0
	#apply random multiplier (between 0.85 and 1.0)
	var random_multiplier = randf_range(0.85, 1.0)
	base_damage *= random_multiplier
	#apply critical damage 
	if critical == true:
		base_damage *= 2 
		printerr("CRITICAL HIT")
	elif critical == false:
		printerr("no crit ")
		pass
	#return the final damage as an integer
	return int(base_damage)
