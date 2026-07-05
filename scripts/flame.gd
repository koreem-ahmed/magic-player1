extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if Global.mana < 180:
		Global.mana  += 70
	
	if Global.health < 130:
		Global.health += 30
	queue_free()
