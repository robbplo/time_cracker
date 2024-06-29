extends Node2D

var sum_offset = 0.0
var input_count = 0.0
var new_offset = 0.0 :
	set(value):
		new_offset = value
		$NewOffsetLabel.text = str("New offset: ", round(new_offset * 1000.0), " ms")

func _ready():
	update_active_offset()

func _unhandled_key_input(event):
	if event.is_pressed() and event.keycode == KEY_SPACE:
		var offset = GlobalTimer.distance_to_quarter_note()
		sum_offset += offset
		input_count += 1.0
		new_offset = sum_offset / input_count

func update_active_offset():
	var active_offset = round(Config.global_timer_offset * 1000.0)
	$ActiveOffsetLabel.text = str("Active offset: ", active_offset, " ms")

func reset():
	sum_offset = 0.0
	input_count = 0.0
	new_offset = 0.0

func _on_reset_calibration_button_pressed():
	reset()

func _on_remove_offset_button_pressed():
	Config.erase("global_timer", "offset")
	update_active_offset()
	reset()

func _on_store_offset_button_pressed():
	Config.global_timer_offset += new_offset
	update_active_offset()
	reset()
