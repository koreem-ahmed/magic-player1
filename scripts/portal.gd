extends Node2D


func _on_body_entered(body):
	if body == Global.player:
		Global.win += 1
		if Global.win >=3:
			call_deferred("_final_win")
		else:
			if Global.score >= 3:
				call_deferred("_change_level")

func _change_level():
	TransitionLayer._transition()
	await TransitionLayer.transitioned
	get_tree().change_scene_to_file("res://scenes/levels/levels_menu.tscn")

func _final_win():
	TransitionLayer._transition()
	await TransitionLayer.transitioned
	get_tree().change_scene_to_file("res://scenes/control/winning.tscn")
