extends Node3D
class_name Spell

## Called when the components for the spell are prepared
## Use for visual cues, sound effects and the like
func prepare() -> void:
	pass

## Called when the components are consumed to cast the spell
## Use to apply its effects and bring ruin to your enemies
func cast() -> void:
	pass

## Call this function when the effects of the spell have ended
func end() -> void:
	pass
