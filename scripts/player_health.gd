extends ProgressBar

var min_val
var max_val

func _ready() -> void:
	min_val = Global.min_hel
	max_val = Global.max_hel

func _process(delta: float) -> void:
	self.value = Global.health
	
	if Global.health <= min_val:
		Global.death = true
	
