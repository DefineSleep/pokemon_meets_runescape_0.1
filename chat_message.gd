extends Control

@onready var label: Label = $Label

var message_to_print : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = message_to_print


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
