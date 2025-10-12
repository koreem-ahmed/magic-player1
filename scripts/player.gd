extends CharacterBody2D

@onready var player: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 150.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0 :
		player.flip_h = false
	elif direction < 0:
		player.flip_h = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("attack"):
			player.play("attack-m")
		elif direction == 0:
			player.play("default")
		else:
			player.play("run")
	else:
		player.play("fall")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	move_and_slide()
