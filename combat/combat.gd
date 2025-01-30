extends Control

const DAMAGE_MESSAGE = preload("res://damage_message.tscn")
const COMBAT_ENEMY = preload("res://combat_enemy.tscn")
@onready var combat: Control = $"."
const ORC_ENEMY_IMAGE = preload("res://assets/enemy_combat.png")
const CHAT_MESSAGE = preload("res://chat_message.tscn")

@onready var enemy_health_bar: ProgressBar = $enemy_health_mana_energy_container/MarginContainer/VBoxContainer/enemy_health_bar


@onready var combat_enemy_node: Node = $combat_enemy

@onready var message_v_box_container: VBoxContainer = $dialog_panel/MarginContainer/ScrollContainer/message_VBoxContainer
@onready var enemy_image: TextureRect = $enemy_panel/MarginContainer/enemy_image
@onready var spell_v_container: VBoxContainer = $player_spell_container/MarginContainer/ScrollContainer/spell_v_container



# 0movename , 1speed, 2damage
#@onready var enemy_turn : Array = []
#@onready var player_turn : Array = []

#turn_base_order = []
@onready var player_turn = ["fire Strike",50, 25] #name,speed,damage
@onready var enemy_turn = ["Sword Slash",75, 55] #name,speed,damage

@onready var turn_base_order : Array = [player_turn,enemy_turn]




func _ready() -> void:
	pass

func _process(delta: float) -> void:
	health_bar_calculations(combat_enemy_node.enemy_current_health,enemy_health_bar)
	end_combat_when_enemy_death()
# ALL COMBAT FUNCTIONS


func apply_enemy_inflicted_damage(_damage):
	pass #TODO THIS RIGHT HERE WHEN I WAKE UP
	
func apply_player_inflicted_damage(_damage):
	pass


# takes in turn arrays and returns it sorted by speed
func check_who_is_faster_sort_array_according(_enemy_turn:Array,_player_turn:Array)->Array:
	var speed_player = _player_turn[1]
	var speed_enemy =  _enemy_turn[1]
	
	if speed_player >= speed_enemy:
		return [_player_turn,_enemy_turn]
	else : return [_enemy_turn,_player_turn]
	


func add_move_and_speed_to_turn(_turn_array,_move,_speed,_damage):
	_turn_array.append(_move)
	_turn_array.append(_speed)
	_turn_array.append(_damage)
	



func enemy_ai_pick_move():
	pass




func clear_all_turn_arrays():
	enemy_turn.clear()
	player_turn.clear()
	pass



func end_combat_when_enemy_death():
	if combat_enemy_node.enemy_current_health <= 0:
		printerr("enemy dead")
	else : printerr("enemy is alive")
	pass


func combat_start(): # THIS FUNCTION IS CALLED WHEN start_combat() IN WORLD CONTROLLER IS CALLED
	printerr("start combat")
	spawn_goblin()
	import_player_equiped_moves_to_menu()

func max_health_bar_calculations(_max_health,_progress_bar_node):
	_progress_bar_node.max_value=_max_health
	
func health_bar_calculations(_current_health,_progress_bar_node):
	_progress_bar_node.value=_current_health

func spawn_goblin():
	spawn_enemy_with_random_stats(randomize_enemy_stats(Global.all_enemies[0].total_stat_pool))
	get_enemy_image(ORC_ENEMY_IMAGE)
	chatbox_basic_message(str(Global.all_enemies[0].enemy_name)+" has spawned")
	max_health_bar_calculations(combat_enemy_node.enemy_max_health,enemy_health_bar)



func import_player_equiped_moves_to_menu(): #TODO change this if adding elements
	var moves_equiped = Global.player_moves # Array of moves, 
	var spell_display_scene = preload("res://combat/spell_display.tscn")
	# for each moves in array , instantiate move display with information attached to it 
	for move in moves_equiped:
		var spell_display_instance = spell_display_scene.instantiate() as spell_display
		# set move stats to the instance
		spell_display_instance.move_name = move["move_name"]
		spell_display_instance.move_power = move["move_power"]
		spell_display_instance.move_accuracy = move["move_accuracy"]
		spell_display_instance.move_cooldown = move["move_cooldown"]
		
		spell_display_instance.combat_enemy = $combat_enemy
		spell_v_container.add_child(spell_display_instance)
		
	
	
func get_enemy_image(image_variable): # TODO make this more efficient or cleaner than loading all images in variables
	enemy_image.texture = image_variable 


	
func spawn_enemy_with_random_stats(_stats : Array):
	var health = _stats[0]
	var defense = _stats[1]
	var attack = _stats[2]
	var speed = _stats[3]
	combat_enemy_node.enemy_max_health = health
	combat_enemy_node.enemy_defense = defense
	combat_enemy_node.enemy_attack = attack
	combat_enemy_node.enemy_speed = speed
	
	
	combat_enemy_node.enemy_current_health = health
	printerr("enemy stats:"+"\nHP:"+str(health)+"\nDEF:"+str(defense)+"\nATK:"+str(attack)+"\nSPD:"+str(speed))


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




func player_does_damage_to_enemy(_spell_name,_damage,_entity_attacking):
	write_and_instentiate_damage_message(_damage,_entity_attacking,_spell_name)

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

func chatbox_basic_message(_string)->void:
	var messages = CHAT_MESSAGE.instantiate()
	messages.message_to_print = _string
	message_v_box_container.add_child(messages)


func use_skill():
	pass

# TEST BUTTON
func _on_button_pressed() -> void:
	printerr(combat_enemy_node.enemy_max_health)
	printerr(combat_enemy_node.enemy_defense)
	printerr(combat_enemy_node.enemy_attack)
	printerr(combat_enemy_node.enemy_speed)
	
	
