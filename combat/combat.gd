extends Control

const DAMAGE_MESSAGE = preload("res://damage_message.tscn")
const COMBAT_ENEMY = preload("res://combat_enemy.tscn")
@onready var combat: Control = $"."
const ORC_ENEMY_IMAGE = preload("res://assets/enemy_combat.png")
const CHAT_MESSAGE = preload("res://chat_message.tscn")

@onready var message_v_box_container: VBoxContainer = $dialog_panel/MarginContainer/ScrollContainer/message_VBoxContainer
@onready var enemy_image: TextureRect = $enemy_panel/MarginContainer/enemy_image
@onready var spell_v_container: VBoxContainer = $player_spell_container/MarginContainer/ScrollContainer/spell_v_container

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

# ALL COMBAT FUNCTIONS

func combat_start(): # THIS FUNCTION IS CALLED WHEN start_combat() IN WORLD CONTROLLER IS CALLED
	printerr("start combat")
	spawn_goblin()
	import_player_equiped_moves_to_menu()



func spawn_goblin():
	spawn_enemy_with_random_stats(randomize_enemy_stats(Global.all_enemies[0].total_stat_pool))
	get_enemy_image(ORC_ENEMY_IMAGE)
	chatbox_basic_message(str(Global.all_enemies[0].enemy_name)+" has spawned")



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
		spell_v_container.add_child(spell_display_instance)
		
	
	
func get_enemy_image(image_variable): # TODO make this more efficient or cleaner than loading all images in variables
	enemy_image.texture = image_variable 


	
func spawn_enemy_with_random_stats(_stats : Array):
	var enemy_spawned = COMBAT_ENEMY.instantiate()
	var health = _stats[0]
	var defense = _stats[1]
	var attack = _stats[2]
	var speed = _stats[3]
	


	printerr("enemy stats:"+"\nHP:"+str(health)+"\nDEF:"+str(defense)+"\nATK:"+str(attack)+"\nSPD:"+str(speed))
	combat.add_child(enemy_spawned)



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
	

func chatbox_basic_message(_string)->void:
	var messages = CHAT_MESSAGE.instantiate()
	messages.message_to_print = _string
	message_v_box_container.add_child(messages)

# TEST BUTTON
func _on_button_pressed() -> void:
	#write_and_instentiate_damage_message(1,"Test", "Test Move")
	import_player_equiped_moves_to_menu()
	printerr("spawn enemy "+str(Global.all_enemies[0].enemy_name))
	spawn_enemy_with_random_stats(randomize_enemy_stats(Global.all_enemies[0].total_stat_pool))
