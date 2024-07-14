extends Node

## Reference to Player node. Set in Player._ready()
var player: Player
var hi: Player

## Get reference to Player node.
## Will crash the game if called before the Player node is ready.
func get_player() -> Player:
	assert(player is Player, "Player player was not set, presumably not in tree")
	return player
