extends Node

var score = 0
@onready var coinsc: Label = $"../Player/coinsc"

func add_point():
	score += 1
	coinsc.text = str(score)
