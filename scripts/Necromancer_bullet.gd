extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var speed = 300
var dir: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += dir * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	Global.health -= 35
	queue_free()
