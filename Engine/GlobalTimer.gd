extends Node

signal started
signal quarter_note(index: int)
signal sixteenth_note(index: int)

## If the timer is currently active
var running: bool = false
## Bpm of the song
@export var bpm: float = 112.0
## Duration of a quarter note in seconds
var quarter_note_duration: float = 60.0 / bpm
## Duration of a sixteenth note in seconds
var sixteenth_note_duration: float = quarter_note_duration / 4.0
## Total time since the music started playing
var elapsed_time: float = 0
## Amount of quarter notes since starting
var total_quarter_notes: int = 0
## Amount of sixteenth notes since starting
var total_sixteenth_notes: int = 0
## In seconds
@onready var output_latency: float = AudioServer.get_output_latency()
@onready var player: AudioStreamPlayer = get_tree().root.get_child(-1).find_child("Song")

func _ready():
	# add a short delay so others can listen to started event
	# ideally the song should not start when the scene is ready, but after everything is loaded
	await get_tree().process_frame
	if player:
		player.play()
		start()

func _process(_delta):
	if not running or not player:
		return

	elapsed_time = player.get_playback_position() \
		+ AudioServer.get_time_since_last_mix() \
		- output_latency

	print(Config.global_timer_offset)

	var new_quarter_notes = floor(elapsed_time / quarter_note_duration)
	if new_quarter_notes > total_quarter_notes:
		_add_quarter_note()

	var new_sixteenth_notes = floor(elapsed_time / sixteenth_note_duration)
	if new_sixteenth_notes > total_sixteenth_notes:
		_add_sixteenth_note()

func start():
	running = true
	started.emit()
	_add_quarter_note()
	_add_sixteenth_note()

func _add_quarter_note():
	total_quarter_notes += 1
	quarter_note.emit(total_quarter_notes % 4)

func _add_sixteenth_note():
	total_sixteenth_notes += 1
	sixteenth_note.emit(total_sixteenth_notes % 16)

## Considered on time when within a sixteenth note duration of the quarter note
func is_on_time():
	var distance = distance_to_quarter_note()
	# print(str("distance to quarter note: ", distance, " ms"))
	return abs(distance) < sixteenth_note_duration

## Returns the 'distance' in seconds to the nearest quarter note.
## The value is negative if called just before the note and positive if called just after.
func distance_to_quarter_note() -> float:
	var adjusted_time = elapsed_time - Config.global_timer_offset
	var offset = fmod(adjusted_time, quarter_note_duration)
	if offset < quarter_note_duration / 2:
		return offset
	else:
		return offset - quarter_note_duration
