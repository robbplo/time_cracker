class_name KnockbackHitStrategy extends HitStrategy

## Force multiplier that scales the size of the knockback
@export var force: float
## If true, the knockback force is increased the closer the target is to the spell origin
@export var distance_scaling: bool
# TODO: get max range from targeting strategy
@export var max_range: float

func apply(spell: Spell, target: Character):
	var origin = spell.targeting_strategy.get_origin()
	var direction = origin.direction_to(target.global_position)
	var distance = origin.distance_to(target.global_position)
	var distance_quotient = max_range / distance
	target.velocity += direction * force * distance_quotient

