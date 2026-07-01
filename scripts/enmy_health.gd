extends ProgressBar

var parent
var min_val
var max_val

func _ready() -> void:
	parent = get_parent().get_parent().get_parent().get_parent()

	min_val = parent.min_hel
	max_val = parent.max_hel

func _process(delta: float) -> void:
	self.value = parent.health
	
	
	if parent.health <= min_val:
		self.visible = false
		parent.death = true
	
