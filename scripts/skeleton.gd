extends Node2D

@onready var animated: AnimatedSprite2D = $Animated
@onready var left: RayCast2D = $left
@onready var right: RayCast2D = $right
@onready var d_left: RayCast2D = $"d-left"
@onready var d_right: RayCast2D = $"d-right"
@onready var attacking_area: Area2D = $attacking_area
@onready var detection_area: Area2D = $detection_area
@onready var attack_col: CollisionShape2D = $attacking_area/attack_col
@onready var detection_col: CollisionShape2D = $detection_area/detection_col

const Speed = 60
var direction = 1

var death = false
var health = 150
var max_hel = 150
var min_hel = 0

var is_attacking = false
var can_attack = true

var player_pos: Vector2

func _ready():
	attack_col.disabled = true

func _physics_process(delta):
	if death:
		if animated.animation != "die":
			animated.play("die")
		return
	
	if not Global.player:
		is_attacking = false
		return
	
	player_pos = Global.player.global_position
	
	if is_attacking:
		if not d_left.is_colliding():
			face_to(-1)
		
		elif not d_right.is_colliding():
			face_to(1)
		
		if player_pos.x < global_position.x: # track the player position
			face_to(-1)
		else:
			face_to(1)
			
		animated.play("attack")
		attack_col.disabled = false
		
		position.x += Speed * direction * delta
	
	else:
		if not d_left.is_colliding():
			face_to(-1)
		elif not d_right.is_colliding():
			face_to(1)
		
		if left.is_colliding():
			face_to(1)
		elif right.is_colliding():
			face_to(-1)
		
		if animated.animation != "run":
			animated.play("run")
		
		position.x += direction * Speed * delta
	

func _on_animated_animation_finished() -> void:
	if animated.animation == "die":
		print("died")
		Global.score += 1
		queue_free()
	
	if animated.animation == "attack":
		attack_col.disabled = true
		can_attack = false

func _on_detection_area_body_entered(body: Node2D) -> void: # begin attacking
	if body == Global.player:
		is_attacking = true

func _on_detection_area_body_exited(body: Node2D) -> void: #stop attacking
	if body == Global.player:
		is_attacking = false

func _on_attacking_area_body_entered(body: Node2D) -> void: #damage
	if body == Global.player:
		Global.health -= 30

func face_to(dir: int): # directions function
	direction = dir
	animated.flip_h = dir < 0
	attacking_area.position.x = 22 * dir

func _on_attack_timer_timeout() -> void:
	can_attack = true
