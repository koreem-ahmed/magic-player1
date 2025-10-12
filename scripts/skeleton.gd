extends Node2D

var direction = 1

const Speed = 60

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var left: RayCast2D = $left
@onready var right: RayCast2D = $right

func _process(delta: float) -> void:
	
	position.x += delta * direction * Speed
	
	if !left.is_colliding() :
		direction = 1
		animated_sprite_2d.flip_h = false
	if !right.is_colliding() :
		direction = -1
		animated_sprite_2d.flip_h = true
	
