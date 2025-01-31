extends Control

@onready var win_loss_label: Label = $window_container/screen_title/win_loss_label
@onready var world_controller: Node = $"../.."

var did_player_win : bool 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print_screen_title(did_player_win)
	
	
	
	
func print_screen_title(_did_player_win:bool):
	if _did_player_win:
		win_loss_label.text = "Winner"
	elif !_did_player_win:
		win_loss_label.text = "Loser"
	else : 
		win_loss_label.text = "ERROR"
		printerr("ERROR")


func _on_ok_button_pressed() -> void:
	world_controller.close_end_of_combat_screen()
