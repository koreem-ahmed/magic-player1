extends Node2D


@onready var animated: AnimatedSprite2D = $animated
@onready var right: RayCast2D = $right
@onready var left: RayCast2D = $left
@onready var d_right: RayCast2D = $"d-right"
@onready var d_left: RayCast2D = $"d-left"
@onready var shot_place: Marker2D = $shot_place
@onready var detect_area: Area2D = $detect_area
@onready var attack_timer: Timer = $"attack-timer"

var direction = 1
const Speed = 50

var death = false
var health = 150
var max_hel = 150
var min_hel = 0

var is_attacking = false
var can_attack = true
var attacking_in_progress = false

var player_pos: Vector2

var bullet = preload("res://scenes/Enemies/Necromancer_bullet.tscn")

func  _physics_process(delta) -> void:
	if death:
		death = true
		is_attacking = false
		attack_timer.stop()
		animated.play("die")
		return
	
	if Global.player:
		player_pos = Global.player.global_position
	
	if not is_attacking:
		position.x += Speed * direction * delta
		attack_timer.stop()
		
		if not d_left.is_colliding():
			direction = 1
			animated.flip_h = false
			shot_place.position.x = 22
		
		elif not d_right.is_colliding():
			direction = -1
			animated.flip_h = true
			shot_place.position.x = -22
		
		if right.is_colliding():
			direction = -1
			animated.flip_h = true
			shot_place.position.x = -22
		
		if left.is_colliding():
			direction = 1
			animated.flip_h = false
			shot_place.position.x = 22
			
			
		if animated.animation != "run":
			animated.play("run")
	
	else: # if attacking
		attack_timer.start()
		if player_pos.x < global_position.x: # track the p layer position
			direction = -1
			animated.flip_h = true
			shot_place.position.x = -22

		else:
			direction = 1
			animated.flip_h = false
			shot_place.position.x = 22
			
		attacking_in_progress = true
		animated.play("attack")


func _on_animated_animation_finished() -> void:
	if animated.animation == "die":
		print("died")
		Global.score += 1
		queue_free()
	
	if animated.animation == "attack":
		attack()
		attacking_in_progress = false
		
		if not detect_area.has_overlapping_bodies():
			is_attacking = false

func attack() -> void:
	var bullet_ins = bullet.instantiate()
	get_tree().root.add_child(bullet_ins)
	bullet_ins.global_position = shot_place.global_position
	bullet_ins.dir = (player_pos - shot_place.global_position).normalized()

func _on_detect_area_body_entered(body: Node2D) -> void:
	is_attacking = true


func _on_detect_area_body_exited(body: Node2D) -> void:
	if not attacking_in_progress:
		is_attacking = false


func _on_attacktimer_timeout() -> void:
	if is_attacking:
		attacking_in_progress = true
		animated.play("attack")
