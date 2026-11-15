extends CharacterBody2D
const JUMP_VELOCITY = -460
var idle_time = 0.0
@export var speed: float = 155.0
var gravity_scale = 1.0
var last_facing = 1
var not_pressing = 2

func _ready() -> void:
	$AnimatedSprite2d.play("default")

func _physics_process(delta: float) -> void:
	platformer_movement(delta)

func platformer_movement(delta):
	#Jumping
	if not is_on_floor():
		velocity.y += get_gravity().y * gravity_scale * delta
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#Moving Left and Right	
	var direction = Input.get_axis("Left", "Right")
	if direction != 0:
		idle_time = 0.0
		last_facing = direction
		velocity.x = direction * speed
		if direction == -1:
			$AnimatedSprite2d.play("walkleft")
		if direction == 1:
			$AnimatedSprite2d.play("walkright")
			
		#To detect not pressing to stop moving
	if not Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		direction = 0
		velocity.x = 0

	if direction == 0:
		$AnimatedSprite2d.play("default")
	



	move_and_slide()
