extends Area2D

var speed = 1500
var velocity 
var playerObject
var direction = 1

@onready var timer: Timer = $Timer

func _ready() -> void:
	playerObject = get_node("es://scenes/player.tscn").get_node("AnimatedSprite2D")
	$Timer.connect("timeout", _on_time_out)
	

func _process(delta: float) -> void:
	if direction == 1:
		velocity = Vector2(-1, 0).rotated(rotation_degrees) * delta * speed
		$magic/CPUParticles2D.gravity.x = 3000
	else:
		velocity = Vector2(1, 0).rotated(rotation_degrees) * delta * speed
		$magic/CPUParticles2D.gravity.x = -3000
	position += velocity

func _on_time_out():
	queue_free()
