extends ProgressBar

var parent
var min_val
var max_val

func _ready() -> void:
	parent = get_parent()
	max_val = parent.max_mana

func _process(delta: float) -> void:
	self.value = Global.mana
