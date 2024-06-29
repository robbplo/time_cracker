extends Node

const PATH = "user://config.cfg"

var config = ConfigFile.new()

## Fired when any config value is changed
signal config_changed(section, key, value)

## Calibration offset for the global timer. Time in seconds that is subtracted from the total
## elapsed time in the song.
var global_timer_offset: float :
	get: return config.get_value("global_timer", "offset", 0.0)
	set(value): set_value("global_timer", "offset", value)
signal global_timer_offset_changed(value)

func _ready():
	_load()

func set_value(section: String, key: String, value: Variant):
	config.set_value(section, key, value)
	_save()
	# emit the general signal
	config_changed.emit(section, key, value)
	# emit the config-specific signal
	emit_signal(str(section, "_", key, "_", "changed"), value)

func erase(section: String, key: String):
	config.erase_section_key(section, key)
	_save()

func _load():
	config.load(PATH)

func _save():
	config.save(PATH)
