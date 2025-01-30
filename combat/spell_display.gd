extends Control

class_name spell_display



@onready var cast_button: Button = $HBoxContainer/cast_button
@onready var spell_name: Label = $HBoxContainer/spell_name
@onready var spell_damage: Label = $HBoxContainer/spell_damage


var combat_enemy: Node = null

var player_level : int 
var player_attack : int 

var enemy_defense : int

var move_name : String
var move_power : int 
var move_accuracy : int 
var move_cooldown : int 
var move_crit_chance : int # base from 100% so 90 is 90%



func _ready() -> void:
	#update display 
	cast_button.text = "Y"
	spell_name.text = str(move_name)
	spell_damage.text = str(move_power)
	print_spell_stats()
	
	#setplayer and enemy variables
	player_level = Global.player_data.attack
	player_attack = Global.player_data.defense
	enemy_defense = combat_enemy.enemy_defense
	
func _process(delta: float) -> void:
	pass


func set_player_enemy_variables():
	pass
	

func print_spell_stats():
	printerr("move_name",move_name)
	printerr("move_power",move_power)
	printerr("move_accuracy",move_accuracy)
	printerr("move_cooldown",move_cooldown)
	printerr("enemy_defense",enemy_defense)
	printerr("player_level",player_level)
	printerr("player_attack",player_attack)
	


func get_player_stats():
	pass

func get_enemy_stats():
	pass

func use_ability(_combat_enemy):
	var damage_done : int
	var hit_or_miss : bool = Global.accuracy_check(move_accuracy)
	#if hit_or_miss == true:
	damage_done = Global.calculate_damage(player_level,player_attack,enemy_defense,move_power,Global.critical_yes_or_no(move_crit_chance)) 
	_combat_enemy.enemy_current_health -= damage_done
	printerr("player did "+str(damage_done)+"to "+_combat_enemy.enemy_name)


func _on_cast_button_pressed() -> void:
	use_ability(combat_enemy)
	printerr("ENEMY CURRENT HP",combat_enemy.enemy_current_health)
	printerr("spell used :"+str(move_name))
