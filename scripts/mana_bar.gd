extends ProgressBar

var min_val
var max_val

func _ready() -> void:
	max_val = Global.max_mana

func _process(delta: float) -> void:
	self.value = Global.mana
