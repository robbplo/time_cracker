#@tool
#
extends TileMap

var rng = RandomNumberGenerator.new()

var _k = 0
var _lo = 0
var _mid = 0
var _hi = 0
var _empty = 0

func _ready():
	rng.randomize()

	var _noise = FastNoiseLite.new()
	_noise.seed = rng.randf_range(0,999999)

	for _i in range(-200, 200):
		for _j in range (-300,300):
			_k = _noise.get_noise_2d(_i, _j)
			if  _k < -0.5 :
				set_cell(0,Vector2i(_i,_j), 0, Vector2i(randf_range(-1,7),randf_range(-1,7)))
				_lo += 1
			elif _k > -0.5 && _k <0:
				set_cell(0,Vector2i(_i,_j,), 1, Vector2i(randf_range(-1,7),randf_range(-1,7)))
				_mid += 1
			elif _k > 0 && _k < 0.4:
				set_cell(0,Vector2i(_i,_j,), 2, Vector2i(randf_range(-1,7),randf_range(-1,7)))
				_hi += 1
			else:
				set_cell(0, Vector2i(_i, _j,), -1, Vector2i(randf_range(-1,7),randf_range(-1,7)))
				_empty += 1
