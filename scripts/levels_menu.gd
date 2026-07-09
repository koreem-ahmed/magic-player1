extends Control

@onready var level_2_bocker: ColorRect = $"level 2 bocker"
@onready var level_2_bocker_2: ColorRect = $"level 2 bocker2"
@onready var level_3_bocker: ColorRect = $"level 3 bocker"
@onready var level_3_bocker_2: ColorRect = $"level 3 bocker2"

func _ready() -> void:
	Global.score = 0
	

func _process(delta: float) -> void:
	if Global.win >= 1:
		if is_instance_valid(level_2_bocker):
			level_2_bocker.queue_free()
		if is_instance_valid(level_2_bocker_2):
			level_2_bocker_2.queue_free()
	 
	if Global.win >= 2:
		if is_instance_valid(level_3_bocker):
			level_3_bocker.queue_free()
		if is_instance_valid(level_3_bocker_2):
			level_3_bocker_2.queue_free()

func _on_level_1_pressed() -> void:
	TransitionLayer._transition()
	await TransitionLayer.transitioned
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_level_2_pressed() -> void:
	TransitionLayer._transition()
	await TransitionLayer.transitioned
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")


func _on_level_3_pressed() -> void:
	TransitionLayer._transition()
	await TransitionLayer.transitioned
	get_tree().change_scene_to_file("res://scenes/levels/level_3.tscn")
