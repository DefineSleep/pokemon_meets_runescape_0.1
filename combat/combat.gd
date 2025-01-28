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
	
	
	
	
	
func spawn_enemy_with_random_stats(_stats : Array):
	var enemy_spawned = COMBAT_ENEMY.instantiate()
	var health = _stats[0]
	var defense = _stats[1]
	var attack = _stats[2]
	var speed = _stats[3]
	

	
	printerr("enemy stats:"+"\nHP:"+str(health)+"\nDEF:"+str(defense)+"\nATK:"+str(attack)+"\nSPD:"+str(speed))
	combat.add_child(enemy_spawned)
	pass


func randomize_enemy_stats(total_stats: int) -> Array:
	var min_health = total_stats * 0.3
	var max_health = total_stats * 0.5
	var health = randi_range(min_health, max_health)

	var remaining_stats = total_stats - health
	var min_defense = remaining_stats * 0.1
	var max_defense = remaining_stats * 0.2
	var defense = randi_range(min_defense, max_defense)

	remaining_stats -= defense
	var min_attack = remaining_stats * 0.2
	var max_attack = remaining_stats * 0.3
	var attack = randi_range(min_attack, max_attack)

	remaining_stats -= attack
	var speed = remaining_stats # Remaining stats go to speed
	return [health , defense, attack, speed]


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
	#write_and_instentiate_damage_message(1,"Test", "Test Move")
	printerr("spawn enemy "+str(Global.all_enemies[0].enemy_name))
	spawn_enemy_with_random_stats(randomize_enemy_stats(Global.all_enemies[0].total_stat_pool))
