extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0

var speed_multiplier = 20.0
var jump_multiplier = -20.0

signal jumped

var direction = 0

#const SPEED = 100.0
#const JUMP_VELOCITY = -100.0

func _input(event: InputEvent) -> void:
	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier#JUMP_VELOCITY
		jumped.emit()
	if event.is_action_pressed("move_down"):
		#handles falling through one way platforms
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier#SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, speed*speed_multiplier)

	move_and_slide()
