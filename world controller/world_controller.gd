extends Node

@onready var overworld: Node2D = $overworld
@onready var combat: Control = $CanvasLayer/combat
@onready var overworld_player: CharacterBody2D = $overworld/overworld_player
@onready var overworld_menu: Control = $CanvasLayer2/overworld_menu

@onready var end_of_combat_rewards: Control = $end_of_combat_screen/end_of_combat_rewards


var is_player_in_combat : bool = false
var is_overworld_menu_opened : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	combat_layer_processing_handler()


func _input(event: InputEvent) -> void:
	show_menu(event)
	start_combat(event)
	end_combat(event)
			
			
			
			
			
func show_menu(input):
	if !is_player_in_combat:
		if input.is_action_pressed("overworld_menu"):
			if overworld_menu.is_visible():
				overworld_menu.hide()
				get_tree().paused = false
			else:
				overworld_menu.show()
				get_tree().paused = true
	else: return

func end_combat(input):
	if input.is_action_pressed("combat_end"):
		if combat.is_visible():
			combat.hide()
			is_player_in_combat = false
			get_tree().paused = false
			overworld.show()
			
func start_combat(input):
		if input.is_action_pressed("combat_start"):
			combat.show()
			is_player_in_combat = true
			get_tree().paused = true
			overworld.hide()
			combat.combat_start()
			
func combat_layer_processing_handler():
	if is_player_in_combat:
		combat.set_process(true)
		combat.set_process_input(true)
	elif !is_player_in_combat:
		combat.set_process(false)
		combat.set_process_input(false)

#-----------------------------------
func end_combat_without_input(_win_bool:bool):
		if combat.is_visible():
			combat.hide()
			is_player_in_combat = false
			get_tree().paused = false
			overworld.show()
			end_of_combat_rewards.show()
			
			
func combat_finished(_win_bool:bool):
	if _win_bool == true:
		printerr("battle won")
		end_combat_without_input(true)
	if _win_bool == false:
		printerr("battle lost")
		end_combat_without_input(false)




func close_end_of_combat_screen():
	end_of_combat_rewards.hide()




















#-----------------------------------
