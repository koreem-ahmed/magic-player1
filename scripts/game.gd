extends Node2D


func _on_winning_body_entered(body: Node2D) -> void:
	if Global.score >= 3:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
