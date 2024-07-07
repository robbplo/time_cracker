extends ProgressBar

@onready var parent: Character = get_parent()

func _ready() -> void:
	parent.health_changed.connect(update)
	update(parent.health, 0)

func update(amount, _previous):
	max_value = parent.max_health
	value = amount
