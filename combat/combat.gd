extends Control
@onready var message_v_box_container: VBoxContainer = $dialog_panel/MarginContainer/ScrollContainer/message_VBoxContainer

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
	pass

func write_move_name_and_damage_in_dialog(_move_name,_damage):
	pass

func player_does_damage_to_enemy(_damage):
	pass

func enemy_does_damage_to_player(_damage):
	pass

func cleanup_after_combat_ends():
	pass
