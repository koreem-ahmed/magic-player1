extends CharacterBody2D


@onready var player_animation: AnimatedSprite2D = $player_animation
@onready var score: Label = $score
@onready var attack_1_area: Area2D = $attack_1_area
@onready var attack_1_coll: CollisionShape2D = $attack_1_area/attack_1_coll
@onready var attack_2_marker: Marker2D = $attack_2_marker

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var Bullet = preload("res://player_bullet.gd")
var is_attacking = false
var death = false

var health = 120
var max_hel = 120
var min_hel = 0

func _physics_process(delta: float) -> void:
	score.text = str(Global.score)
	if death:
		player_animation.play("die")
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		basic_attack()
	
	if Input.is_action_just_pressed("attack 2"):
		is_attacking = true
		proj_attack()
	
	
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		player_animation.flip_h = true
	elif direction > 0:
		player_animation.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	
	
	if direction != 0:
		player_animation.play("run")
	
	else:
		player_animation.play("default")


func basic_attack() -> void:
	player_animation.play("attack1")

func proj_attack() -> void:
	player_animation.play("attack2")
	var bullet_ins = Bullet.instantiate()
	get_tree().root.add_child(bullet_ins)
	bullet_ins.global_position = attack_2_marker.global_position
	
	if player_animation.flip_h == true:
		bullet_ins.dir = -1
	else:
		bullet_ins.dir = 1
	
	is_attacking = false
	



func _on_player_animation_animation_finished() -> void:
	if player_animation.animation == "die":
		Global.score = 0
		get_tree().reload_current_scene()
		
	
	if player_animation.animation == "attack1" or "attack2":
		is_attacking = false
		attack_1_coll.disabled = false


func _on_attack_1_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	body.health -= 30
