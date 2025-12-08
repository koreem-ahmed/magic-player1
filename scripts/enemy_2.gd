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

var bullet = preload("res://scenes/enemy_2_bullet.tscn")

func  _physics_process(delta) -> void:
	
	if death:
		death = true
		is_attacking = false
		attack_timer.stop()
		animated.play("die")
		return
	
	if not is_attacking:
		position.x += Speed * direction * delta
		
		
		if not left.is_colliding():
			direction = 1
			animated.flip_h = false
			shot_place.position.x = 22
		
		elif not right.is_colliding():
			direction = -1
			animated.flip_h = true
			shot_place.position.x = -22
		
		if animated.animation != "run":
			animated.play("run")
	
	else: 
		if d_left.is_colliding():
			direction = -1
			animated.flip_h = true
			shot_place.position.x = -22

		elif d_right.is_colliding():
			direction = 1
			animated.flip_h = false
			shot_place.position.x = 22
			
		if animated.animation != "attack":
			animated.play("attack")


func _on_animated_animation_finished() -> void:
	if animated.animation == "die":
		print("died")
		Global.score += 1
		queue_free()
	
	if animated.animation == "attack":
		attack()

func attack() -> void:
	var bullet_ins = bullet.instantiate()
	get_tree().root.add_child(bullet_ins)
	bullet_ins.global_position = shot_place.global_position

	if animated.flip_h == true:
		bullet_ins.dir = -1
	else:
		bullet_ins.dir = 1
	attack_timer.start()

func _on_detect_area_body_entered(body: Node2D) -> void:
	is_attacking = true


func _on_detect_area_body_exited(body: Node2D) -> void:
	is_attacking = false


func _on_attacktimer_timeout() -> void:
	if is_attacking:
		animated.play("attack")
