extends CharacterBody2D

@onready var anim = $player_animation
@onready var atk1_area = $attack_1_area
@onready var atk1_coll = $attack_1_area/attack_1_coll
@onready var atk2_marker = $attack_2_marker
@onready var score_label = $score

const SPEED = 200
const JUMP_FORCE = -300
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var Bullet = preload("res://scenes/player_bullet.tscn")

var is_attacking = false
var shoot_after_attack = false
var death = false

var min_hel = 0
var max_hel = 130
var health = 130

var max_mana = 180

var is_dashing = false
var dash_timer = 0.0
const dash_speed = 600 
const dash_duration = 0.2

var mana_regen_timer = 0.0
const mana_regin_time = 2.5
const mana_amount = 20

func _physics_process(delta):
	
	mana_regen_timer += delta
	if mana_regen_timer >= mana_regin_time:
		Global.mana += mana_amount
		mana_regen_timer = 0.0
	
	score_label.text = str(Global.score)
	
	if Global.mana > 180:
		Global.mana = 180
	
	if death:
		anim.play("die")
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
	
	if Input.is_action_just_pressed("attack") and not is_attacking and Global.mana >= 20:
		Global.mana -= 20
		is_attacking = true
		atk1_coll.disabled = false
		anim.play("attack1")
		return

	if Input.is_action_just_pressed("attack 2") and not is_attacking and Global.mana >= 40:
		Global.mana -= 40
		is_attacking = true
		shoot_after_attack = true
		shoot_bullet()
		anim.play("attack2")
		return

	var dir = Input.get_axis("move_left", "move_right")
	
	
	if Input.is_action_just_pressed("dash") and not is_dashing and not is_attacking and Global.mana >= 30:
		is_dashing = true
		dash_timer = dash_duration
		anim.play("dash")
		Global.mana -= 30
	
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
		
		if dir != 0:
			velocity.x = dir * dash_speed
		else:
			var facing_dir = -1 if anim.flip_h else 1
			velocity.x = facing_dir * dash_speed
	else:
		velocity.x = dir * SPEED

	if dir < 0:
		anim.flip_h = true
		atk1_area.position.x = -23
	elif dir > 0:
		anim.flip_h = false
		atk1_area.position.x = 23
	
	if not is_attacking and not is_dashing:
		if dir != 0:
			anim.play("run")
		else:
			anim.play("default")

	move_and_slide()

func _on_player_animation_animation_finished():
	if anim.animation == "attack1":
		is_attacking = false
		atk1_coll.disabled = true
	
	elif anim.animation == "attack2":
		shoot_after_attack = false
		is_attacking = false

	elif anim.animation == "die":
		Global.score = 0
		Global.mana = 180
		get_tree().call_deferred("reload_current_scene")

func shoot_bullet():
	await get_tree().create_timer(0.2).timeout
	var bull = Bullet.instantiate()
	get_tree().current_scene.add_child(bull)
	bull.global_position = atk2_marker.global_position

	if anim.flip_h:
		bull.dir = -1
	else:
		bull.dir = 1

func _on_attack_1_area_body_entered(body: Node2D) -> void:
	body.health -= 20

#f.dslkjfsdfsdfs
