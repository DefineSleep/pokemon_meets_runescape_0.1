extends Control

class_name spell_display


@onready var cast_button: Button = $HBoxContainer/cast_button
@onready var spell_name: Label = $HBoxContainer/spell_name
@onready var spell_damage: Label = $HBoxContainer/spell_damage


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
func _process(delta: float) -> void:
	pass


func get_player_stats():
	pass

func get_enemy_stats():
	pass

func use_ability()->int:
	var damage_done : int
	var hit_or_miss : bool = Global.accuracy_check(move_accuracy)
	if hit_or_miss == true:
		damage_done = Global.calculate_damage(player_level,player_attack,enemy_defense,move_power,Global.critical_yes_or_no(move_crit_chance)) 
	return damage_done


func _on_cast_button_pressed() -> void:
	printerr("spell used :"+str(move_name))
