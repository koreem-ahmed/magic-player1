extends Node2D


func _on_body_entered(body):
	if body == Global.player:
		Global.win += 1
		if Global.score >= 3:
			call_deferred("_change_level")

func _change_level():
	get_tree().change_scene_to_file("res://scenes/levels/levels_menu.tscn")
