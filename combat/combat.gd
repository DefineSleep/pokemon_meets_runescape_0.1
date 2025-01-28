extends Control

const DAMAGE_MESSAGE = preload("res://damage_message.tscn")
const COMBAT_ENEMY = preload("res://combat_enemy.tscn")
@onready var combat: Control = $"."



@onready var message_v_box_container: VBoxContainer = $dialog_panel/MarginContainer/ScrollContainer/message_VBoxContainer
@onready var enemy_image: TextureRect = $enemy_panel/MarginContainer/enemy_image

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

# ALL COMBAT FUNCTIONS

func combat_starts(_enemy):
	pass

func import_player_equiped_moves_to_menu():
	var moves_equiped = Global.player_moves # Array of moves, 
	# for each moves in array , instantiate move display with information attached to it 
	
	
	
func spawn_enemy_with_random_stats():
	var enemy_spawned = COMBAT_ENEMY.instantiate()
	
	
	
	combat.add_child(enemy_spawned)
	pass







func player_does_damage_to_enemy(_damage):
	pass

func enemy_does_damage_to_player(_damage):
	pass

func cleanup_after_combat_ends():
	pass



func write_and_instentiate_damage_message(_damage_amount, _entity_attacking_name, _move_used): # PRETTY MUCH DONE
	var damage_messages = DAMAGE_MESSAGE.instantiate()
	
	damage_messages.entity_name = _entity_attacking_name
	damage_messages.damage_numbers = _damage_amount
	damage_messages.move_used_name = _move_used
	
	message_v_box_container.add_child(damage_messages)
	
	pass



# TEST BUTTON
func _on_button_pressed() -> void:
	write_and_instentiate_damage_message(1,"Test", "Test Move")
