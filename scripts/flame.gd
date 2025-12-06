extends Area2D

@onready var game_maneger: Node = %"Game maneger"

func _on_body_entered(body: Node2D) -> void:
	Global.score  += 1
	queue_free()
