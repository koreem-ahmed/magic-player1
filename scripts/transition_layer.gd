extends CanvasLayer

signal transitioned

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	color_rect.visible = false
	animation.animation_finished.connect(animation_finished)

func animation_finished(anime_name):
	if anime_name == "fade_in":
		transitioned.emit()
		animation.play("fade_out")
	elif anime_name == "fade_out":
		color_rect.visible = false

func _transition():
	color_rect.visible = true
	animation.play("fade_in")
