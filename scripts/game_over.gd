extends CanvasLayer


func _ready() -> void:
	self.hide()


func _on_retry_pressed() -> void:
	get_tree().paused = false
	Global.death = false
	Global.mana = 180
	Global.score = 0
	get_tree().reload_current_scene()
	


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/mainmenu.tscn")


func game_over():
	get_tree().paused = true
	self.show()
