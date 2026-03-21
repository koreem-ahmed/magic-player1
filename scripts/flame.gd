extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if Global.mana < 180:
		Global.mana  += 70
	queue_free()
