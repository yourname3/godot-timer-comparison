extends Node2D

const TIMER_LENGTH = 29.1 / 60

var beginning_of_time = 0.0

func get_time():
	return Time.get_ticks_usec() / 1000000.0

func _ready():
	beginning_of_time = get_time()

func _process(delta):
	# Add one because we switch once at time = 0
	var correct_switch_count = 1 + floor((get_time() - beginning_of_time) / TIMER_LENGTH)
	
	print("correct: ", correct_switch_count, " manual: ", $ManualTimer.switch_count, " godot: ", $GodotTimer.switch_count)
