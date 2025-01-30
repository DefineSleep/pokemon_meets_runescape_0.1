extends Node


@onready var player_data : Dictionary = {
	"player_name" : "Test_name",
	"player_level" : 1,

	"max_health" : 100,
	"current_health" : 100,

	"max_mana" : 200,
	"current_mana" : 100,

	"max_energy" : 120,
	"current_energy": 100,

	"phy_attack" : 23,
	"mag_attack" : 23,
	"phy_defense" : 30,
	"mag_defense" : 30,
	"speed" : 420,

	"currency" : 0,
	"inventory" : [],







}

@onready var player_moves : Array = [
	all_moves[1],
	all_moves[2],
	all_moves[3],
	all_moves[0]
	


]



# can put all this in json and load it , use quick arrays and dicts for now
var all_moves : Array = [
	{
		"move_name" : "Fire Strike",
		"move_power" : 100,
		"move_accuracy" : 100,
		"move_cooldown" : 2, # calculated in turns TODO: make a turn counter
		"critical_chance" : 10
	},
	{
		"move_name" : "ice ball",
		"move_power" : 150,
		"move_accuracy" : 80,
		"move_cooldown" : 1,
		"critical_chance" : 10
		
	},
	{
		"move_name" : "Storm",
		"move_power" : 200,
		"move_accuracy" : 100,
		"move_cooldown" : 3,
		"critical_chance" : 10
	},
	{
		"move_name" : "Snow Ball",
		"move_power" : 50,
		"move_accuracy" : 100,
		"move_cooldown" : 0,
		"critical_chance" : 10
	},
	{
		"move_name" : "Sword Slash",
		"move_power" : 75,
		"move_accuracy" : 95,
		"move_cooldown" : 0,
		"critical_chance" : 10
	},
	{
		"move_name" : "Goblin Spit",
		"move_power" : 75,
		"move_accuracy" : 95,
		"move_cooldown" : 0,
		"critical_chance" : 10
	},

]




var all_enemies : Array = [
	{
		"enemy_name" : "Mage Globin",
		"total_stat_pool" : 200,
		"base_max_health": 300,
		"base_attack" : 10,
		"base_defense" : 20,
		"base_speed" : 5,
		"moves" : [all_moves[4],all_moves[5],all_moves[0],all_moves[1]],
		"drops":[],
		"equipment_transform":{}
	},
	{
		"enemy_name" : "Slime",
		"total_stat_pool" : 200,
		"base_max_health": 120,
		"base_attack" : 5,
		"base_defense" : 4,
		"base_speed" : 2,
		"moves" : {
			"name" : "Splatter",
			"base_power": 30,
			"accuracy": 90
		},
		"drops":[],
		"equipment_transform":{}
	},
	{
		"enemy_name" : "Bandit",
		"total_stat_pool" : 250,
		"base_max_health": 200,
		"base_attack" : 8,
		"base_defense" : 7,
		"base_speed" : 6,
		"moves" : {
			"name" : "Ambush Strike",
			"base_power": 50,
			"accuracy": 95
		},
		"drops":[],
		"equipment_transform":{}
	},
	{
		"enemy_name" : "Skeleton Warrior",
		"base_max_health": 250,
		"base_attack" : 70,
		"base_defense" : 90,
		"base_speed" : 35,
		"moves" : {
			"name" : "Bone Smash",
			"base_power": 75,
			"accuracy": 85
		},
		"drops":[],
		"equipment_transform":{}
	},
	{
		"enemy_name" : "Lich",
		"base_max_health": 300,
		"base_attack" : 100,
		"base_defense" : 80,
		"base_speed" : 40,
		"moves" : {
			"name" : "Dark Pulse",
			"base_power": 90,
			"accuracy": 80
		},
		"drops":[],
		"equipment_transform":{}
	}
]

var all_game_items = [
	{
		"item_name":"Potion",
		"affected_stat":"hp",
		"effect_value":10,
		},
	{
		"item_name":"i-Potion",
		"affected_stat":"hp",
		"effect_value":50,
	},
	{
		"item_name":"i-Potion",
		"affected_stat":"hp",
		"effect_value":50,
	},
	{},
	{},
	{},
	{},
	{},
]
# phy_attack , mag_attack, phy_defense, mag_defense, speed
var all_enemy_items = [
	{
		"parent_monster": all_enemies[0],
		"item_name":"Goblin Mail",
		"item_stat_range":[2,2,10,10,1],
		"element":"neutral"
	},
	{
		"parent_monster": all_enemies[1],
		"item_name":"Slime Sword",
		"item_stat_range":[20,20,0,0,4],
		"element":"water"
	},


]
# GLOBAL FUNCTIONS 

	
	
	
func critical_yes_or_no(chance)-> bool: #chance is 
	randomize()
	var random_chance = randi_range(1,100)
	if random_chance <= chance:
		return true
	else  : return false

func accuracy_check(_move_accuracy)->bool:
	randomize()
	var random_number : int = randi_range(1,100)
	if random_number >= _move_accuracy :
		return true
	else : return false


func calculate_damage(level: int, attack: int, defense: int, attack_base_power: int, critical: bool) -> int:
	#base damage calculation
	var base_damage = (((2.0 * float(level) / 5.0) + 2.0) * float(attack_base_power) * float(attack) / float(defense)) / 50.0 + 2.0
	#apply random multiplier (between 0.85 and 1.0)
	var random_multiplier = randf_range(0.85, 1.0)
	base_damage *= random_multiplier
	#apply critical damage 
	if critical == true:
		base_damage *= 1.5 
		printerr("CRITICAL HIT")
	elif critical == false:
		printerr("no crit ")
	#return the final damage as an integer
	return int(base_damage)
