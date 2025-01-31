extends Control

const DAMAGE_MESSAGE = preload("res://combat/damage_message.tscn")
const COMBAT_ENEMY = preload("res://combat/combat_enemy.tscn")
const CHAT_MESSAGE = preload("res://combat/chat_message.tscn")

const ORC_ENEMY_IMAGE = preload("res://assets/enemy_combat.png")
@onready var combat: Control = $"."
@onready var enemy_health_bar: ProgressBar = $enemy_health_mana_energy_container/MarginContainer/VBoxContainer/enemy_health_bar
@onready var player_health_bar: ProgressBar = $player_health_mana_energy_container/MarginContainer/VBoxContainer/player_health_bar
@onready var combat_enemy_node: Node = $combat_enemy
@onready var message_v_box_container: VBoxContainer = $dialog_panel/MarginContainer/ScrollContainer/message_VBoxContainer
@onready var enemy_image: TextureRect = $enemy_panel/MarginContainer/enemy_image
@onready var spell_v_container: VBoxContainer = $player_spell_container/MarginContainer/ScrollContainer/spell_v_container
#0move_name,1entity_speed,2damage
@onready var enemy_turn: Array = ["",1,1]
@onready var player_turn: Array = ["",1,1]
@onready var turn_base_order: Array = [player_turn, enemy_turn]
@onready var world_controller: Node = $"../.."
@onready var scroll_container: ScrollContainer = $dialog_panel/MarginContainer/ScrollContainer


#test
@onready var label: Label = $Label


func _ready() -> void:
	pass
func _process(delta: float) -> void:
	health_bar_calculations(combat_enemy_node.enemy_current_health,enemy_health_bar)
	health_bar_calculations(Global.player_data.current_health,player_health_bar)
	
	max_health_bar_calculations(combat_enemy_node.enemy_max_health,enemy_health_bar)
	max_health_bar_calculations(Global.player_data.max_health,player_health_bar)
	label.text = str(enemy_turn)
	
	
	
	

func combat_start(): # EVERYTHING STARTS HERE
	spawn_goblin()
	import_player_equiped_moves_to_menu()
	printerr("First check",turn_base_order)
	
	
	
	pass



#--------------------------------------------------------
func spawn_goblin():
	spawn_enemy_with_random_stats(randomize_enemy_stats(Global.all_enemies[0].total_stat_pool), Global.all_enemies[0].enemy_name, Global.all_enemies[0])
	get_enemy_image(ORC_ENEMY_IMAGE)
	chatbox_basic_message(str(Global.all_enemies[0].enemy_name) + " has spawned")
	max_health_bar_calculations(combat_enemy_node.enemy_max_health, enemy_health_bar)

func import_player_equiped_moves_to_menu():
	var moves_equiped = Global.player_moves
	var spell_display_scene = preload("res://combat/spell_display.tscn")
	for move in moves_equiped:
		var spell_display_instance = spell_display_scene.instantiate() as spell_display
		spell_display_instance.move_name = move["move_name"]
		spell_display_instance.move_power = move["move_power"]
		spell_display_instance.move_accuracy = move["move_accuracy"]
		spell_display_instance.move_cooldown = move["move_cooldown"]
		spell_display_instance.combat_enemy = $combat_enemy
		spell_display_instance.spell_casted.connect(player_spell_chosen_data_update)
		spell_v_container.add_child(spell_display_instance)
		
		
#--------------------------------------------------------
# Player Turn
func player_spell_chosen_data_update(spell_name: String, spell_damage: int) -> void:
	var entity_speed: int = Global.player_data.speed
	player_turn.clear()
	player_turn += [spell_name, entity_speed, spell_damage]
	enemy_spell_chosen_data_update(combat_enemy_node.enemy_moves)

# Enemy Turn
func enemy_spell_chosen_data_update(_enemy_spells: Array) -> void:
	var random_number = randi_range(1, 4)
	match random_number:
		1:
			enemy_turn[0] = _enemy_spells[0].move_name
			enemy_turn[1] = combat_enemy_node.enemy_speed
			enemy_turn[2] = Global.calculate_damage(combat_enemy_node.enemy_level,combat_enemy_node.enemy_attack,Global.player_data.phy_defense,_enemy_spells[0].move_power,Global.critical_yes_or_no(_enemy_spells[0].critical_chance))
			printerr("player",player_turn)
			printerr("enemy",enemy_turn)
			
			turn_base_order.clear()
			turn_base_order += check_who_is_faster_sort_array_according(enemy_turn,player_turn)
			apply_damage_master()
		2:
			enemy_turn[0] = _enemy_spells[1].move_name
			enemy_turn[1] = combat_enemy_node.enemy_speed
			enemy_turn[2] = Global.calculate_damage(combat_enemy_node.enemy_level,combat_enemy_node.enemy_attack,Global.player_data.phy_defense,_enemy_spells[0].move_power,Global.critical_yes_or_no(_enemy_spells[0].critical_chance))
			printerr("player",player_turn)
			printerr("enemy",enemy_turn)
			
			turn_base_order.clear()
			turn_base_order += check_who_is_faster_sort_array_according(enemy_turn,player_turn)
			apply_damage_master()
		3:
			enemy_turn[0] = _enemy_spells[2].move_name
			enemy_turn[1] = combat_enemy_node.enemy_speed
			enemy_turn[2] = Global.calculate_damage(combat_enemy_node.enemy_level,combat_enemy_node.enemy_attack,Global.player_data.phy_defense,_enemy_spells[2].move_power,Global.critical_yes_or_no(_enemy_spells[2].critical_chance))
			printerr("player",player_turn)
			printerr("enemy",enemy_turn)
			turn_base_order.clear()
			turn_base_order += check_who_is_faster_sort_array_according(enemy_turn,player_turn)
			apply_damage_master()
		4:
			enemy_turn[0] = _enemy_spells[3].move_name
			enemy_turn[1] = combat_enemy_node.enemy_speed
			enemy_turn[2] = Global.calculate_damage(combat_enemy_node.enemy_level,combat_enemy_node.enemy_attack,Global.player_data.phy_defense,_enemy_spells[3].move_power,Global.critical_yes_or_no(_enemy_spells[3].critical_chance))
			printerr("player",player_turn)
			printerr("enemy",enemy_turn)
			turn_base_order.clear()
			turn_base_order += check_who_is_faster_sort_array_according(enemy_turn,player_turn)
			apply_damage_master()

# Determine Turn Order
func check_who_is_faster_sort_array_according(_enemy_turn: Array, _player_turn: Array) -> Array:
	return [_player_turn, _enemy_turn] if _player_turn[1] >= _enemy_turn[1] else [_enemy_turn, _player_turn]

#---------------------------------

func apply_damage_master():
	var turn_queue = turn_base_order
	
	if turn_queue[0] == player_turn:
		printerr("player is first")
		apply_damage_from_player(player_turn)
		if combat_enemy_node.enemy_current_health <= 0:
			printerr("enemy died")
			world_controller.combat_finished(true)
		else:apply_damage_from_enemy(enemy_turn)
		
		
		
	if turn_queue[1] == player_turn:
		printerr("Enemy is first")
		apply_damage_from_enemy(enemy_turn)
		if combat_enemy_node.enemy_current_health <= 0:
			printerr("player died")
			world_controller.combat_finished(false)
		else:apply_damage_from_enemy(enemy_turn)
#---------------------------------
# Apply Damage
func apply_damage_from_player(_array: Array):
	var move_name: String = _array[0]
	var move_final_damage: int = _array[2]
	combat_enemy_node.enemy_current_health -= move_final_damage
	write_and_instentiate_damage_message(move_final_damage, Global.player_data.player_name, move_name)

func apply_damage_from_enemy(_array: Array):
	var move_name: String = _array[0]
	var move_final_damage: int = _array[2]
	Global.player_data.current_health -= move_final_damage
	write_and_instentiate_damage_message(move_final_damage, combat_enemy_node.enemy_name, move_name)

# End Combat Handling
func end_combat_when_enemy_death():
	pass

func cleanup_after_combat_ends():
	for child in message_v_box_container.get_children():
		child.queue_free()
	for child in spell_v_container.get_children():
		child.queue_free()

# UI Updates
func max_health_bar_calculations(_max_health, _progress_bar_node):
	_progress_bar_node.max_value = _max_health

func health_bar_calculations(_current_health, _progress_bar_node):
	_progress_bar_node.value = _current_health

# Utility Functions

func scroll_to_bottom() -> void:
	await get_tree().process_frame  # Wait for UI to update
	await get_tree().process_frame  # Wait an extra frame (ensures resizing)
	if scroll_container:  # Check if still valid
		scroll_container.set_v_scroll(scroll_container.get_v_scroll_bar().max_value)


func write_and_instentiate_damage_message(_damage_amount, _entity_attacking_name, _move_used):
	var damage_messages = DAMAGE_MESSAGE.instantiate()
	damage_messages.entity_name = _entity_attacking_name
	damage_messages.damage_numbers = _damage_amount
	damage_messages.move_used_name = _move_used
	message_v_box_container.add_child(damage_messages)
	scroll_to_bottom()

func chatbox_basic_message(_string) -> void:
	var messages = CHAT_MESSAGE.instantiate()
	messages.message_to_print = _string
	message_v_box_container.add_child(messages)
	scroll_to_bottom()
	
func get_enemy_image(image_variable):
	enemy_image.texture = image_variable


#---------------------
func type_of_enemy_that_spawns():
	pass

#---------------------



func spawn_enemy_with_random_stats(_stats: Array,_enemy_name: String,_enemy_info):
	combat_enemy_node.enemy_max_health = _stats[0]
	combat_enemy_node.enemy_defense = _stats[1]
	combat_enemy_node.enemy_attack = _stats[2]
	combat_enemy_node.enemy_speed = _stats[3]
	combat_enemy_node.enemy_name = _enemy_name
	combat_enemy_node.enemy_current_health = _stats[0]
	
	#TODO polish this fking garbage
	combat_enemy_node.enemy_moves = _enemy_info.moves
	
	combat_enemy_node.enemy_level = 5 # TODO change combat levels to be random and affect amount of base stats
	printerr("enemy stats:\nHP:" + str(_stats[0]) + "\nDEF:" + str(_stats[1]) + "\nATK:" + str(_stats[2]) + "\nSPD:" + str(_stats[3]))

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
	var speed = remaining_stats
	return [health, defense, attack, speed]

# Debug Buttons
func _on_button_pressed() -> void:
	pass
func _on_button_2_pressed() -> void:
	pass
