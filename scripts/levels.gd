extends Node2D


@onready var level_2_bocker: ColorRect = $"level 2 bocker"
@onready var level_2_bocker_2: ColorRect = $"level 2 bocker2"
@onready var level_3_bocker: ColorRect = $"level 3 bocker"
@onready var level_3_bocker_2: ColorRect = $"level 3 bocker2"

func _process(delta: float) -> void:
	if Global.win >= 1:
		level_2_bocker.queue_free()
		level_2_bocker_2.queue_free()
	
	if Global.win >= 2:
		level_3_bocker.queue_free()
		level_3_bocker_2.queue_free()

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_level_2_pressed() -> void:
	pass
