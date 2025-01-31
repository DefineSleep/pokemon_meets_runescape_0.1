extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	player_movement(delta)
	test_animation()

func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("scroll_up"): # add camera zoom attached to this 
		#printerr("scrolling up")
	#if event.is_action_pressed("scroll_down"):
		#printerr("scrolling down")
	pass

#---------
# MOVEMENT OVERWORLD
#---------
const SPEED : int = 100
var current_dir = "down"

func player_movement(delta):
	if Input.is_action_pressed("right"):
		play_animation(1)
		current_dir = "right"
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		play_animation(1)
		current_dir = "left"
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("down"):
		play_animation(1)
		current_dir = "down"
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("up"):
		play_animation(1)
		current_dir = "up"
		velocity.x = 0
		velocity.y = -SPEED
	else : 
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func play_animation(movement):
	var _dir = current_dir
	var _animation = animated_sprite_2d
	
	if _dir == "right":
		if movement == 1:
			_animation.play("walk_right")
		elif movement == 0:
			_animation.play("idle_right")
	if _dir == "left":
		if movement == 1:
			_animation.play("walk_left")
		elif movement == 0:
			_animation.play("idle_left")
	if _dir == "up":
		if movement == 1:
			_animation.play("walk_up")
		elif movement == 0:
			_animation.play("idle_up")
	if _dir == "down":
		if movement == 1:
			_animation.play("walk_down")
		elif movement == 0:
			_animation.play("idle_down")
		
	
func test_animation():
	if Input.is_key_label_pressed(KEY_SPACE):
		animated_sprite_2d.play("axe_swing_right")
