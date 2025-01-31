extends Control

@onready var label: Label = $Label

var entity_name : String = "test_name"

var damage_numbers : int = 5
var damage_text : String
var move_used_name : String


func _ready() -> void:
	damage_text = print_damage_message(damage_numbers,entity_name,move_used_name)
	label.text = damage_text


func print_damage_message(_damage_number,_entity_name,_move_name)->String:
	return "%s used %s did %d damage" %[_entity_name,_move_name,_damage_number] 
