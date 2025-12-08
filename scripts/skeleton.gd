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

var direction = 1
const Speed = 60

var death = false
var health = 150
var max_hel = 150
var min_hel = 0

var is_attacking = false
var can_attack = true

func _physics_process(delta):
	position.x += direction * Speed * delta
	
	if death:
		animated.play("die")
		return
	
	if not left.is_colliding():
		direction = -1
		animated.flip_h = true
		attacking_area.position.x = -22

	elif not right.is_colliding():
		direction = 1
		animated.flip_h = false
		attacking_area.position.x = 22
	
	if is_attacking:
		
		if d_left.is_colliding():
			direction = -1
			animated.flip_h = true
			attacking_area.position.x = -22

		elif d_right.is_colliding():
			direction = 1
			animated.flip_h = false
			attacking_area.position.x = 22
			
		animated.play("attack")
		attack_col.disabled = false
		return
	
	
	else:
		if animated.animation != "run":
			animated.play("run")
			position.x += Speed * direction * delta
		



func _on_animated_animation_finished() -> void:
	if animated.animation == "die":
		print("died")
		Global.score += 1
		queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	is_attacking = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	is_attacking = false


func _on_attacking_area_body_entered(body: Node2D) -> void:
	if can_attack:
		can_attack = false
		body.health -= 30
	
		await get_tree().create_timer(1).timeout
		
		can_attack = true
