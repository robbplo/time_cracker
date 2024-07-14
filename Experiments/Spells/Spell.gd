class_name Spell extends Node3D

@export var duration: float
@export var targeting_strategy: TargetingStrategy
@export var collision_strategy: CollisionStrategy
@export var hit_strategies: Array[HitStrategy]
@export var visual_strategies: Array[VisualStrategy]

func _ready() -> void:
	collision_strategy.collided.connect(_on_collided)

## Called when the components for the spell are prepared
## Use for visual cues, sound effects and the like
func prepare() -> void:
	pass

## Called when the components are consumed to cast the spell
## Use to apply its effects and bring ruin to your enemies
func cast() -> void:
	collision_strategy.get_colliders(self)
	for strategy in visual_strategies:
		strategy.apply(self)


## Call this function when the effects of the spell have ended
func end() -> void:
	pass

func _on_collided(body: Character):
	for strategy in hit_strategies:
		strategy.apply(self, body)
