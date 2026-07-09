extends Control


func _on_start_pressed() -> void:
	TransitionLayer._transition()
	await TransitionLayer.transitioned
	get_tree().change_scene_to_file("res://scenes/levels/levels_menu.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()
