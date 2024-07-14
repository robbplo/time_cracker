class_name DamageHitStrategy extends HitStrategy

@export var damage: float

func apply(_spell: Spell, target: Character):
	target.take_damage(damage)
