@tool
extends TileMap

var rng = RandomNumberGenerator.new()

var _k = 0
var _lo = 0
var _hi = 0

func _ready():
	rng.randomize()
	
	var _noise = FastNoiseLite.new()
	_noise.seed = rng.randf_range(0,999999)
	
	for _i in range(200):
		for _j in range (0,300):
			_k = _noise.get_noise_2d(_i, _j)
			if  _k < -0.2 :
				set_cell(0,Vector2i(_i,_j), 0, Vector2i(rng.randi_range(0, 7), rng.randi_range(0, 7)))
				_lo += 1
			elif _k > 0.3:
				set_cell(0,Vector2i(_i,_j,), 0, Vector2i(rng.randi_range(0, 7), rng.randi_range(0, 7)))
				_hi += 1
			else:
				set_cell(0, Vector2i(_i, _j,), 0, Vector2i(rng.randi_range(0, 7), rng.randi_range(0, 7)))
