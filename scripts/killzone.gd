extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("you died")
	Global.score = 0
	Global.mana = 180
	get_tree().call_deferred("reload_current_scene")
