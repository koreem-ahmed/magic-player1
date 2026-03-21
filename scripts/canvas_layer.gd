extends CanvasLayer

@onready var animation: AnimationPlayer = $AnimationPlayer

func dissolve(target) -> void:
	animation.play("dissolve")
	get_tree().change_scene_to_file(target)
	animation.play_backwards("dissolve")
