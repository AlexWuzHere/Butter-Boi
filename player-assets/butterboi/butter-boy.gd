extends KinematicBody2D

var move_speed : int = 200
var jump_speed : int = 1_000

onready var velocity = Vector2()
onready var gravity = 5_000
onready var animated_sprite = $"Butter-Boi"

func play_animation(velocity):
	if is_on_floor():
		if abs(velocity.x) > 0:
			animated_sprite.play("Walking")
		elif velocity.x == 0:
			animated_sprite.play("Idle") 
	else:
		animated_sprite.play("Jumping")

func get_input(delta):
	velocity.x = 0
	
	# Handle controls, flip character based on direction
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
		animated_sprite.flip_h = false
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
		animated_sprite.flip_h = true
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y -= jump_speed
	
	# Gravity, move character
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Use normalized velocity to parse animations
	play_animation(velocity)
	
func _physics_process(delta):
	get_input(delta)
