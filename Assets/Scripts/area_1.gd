extends Node2D

@export var wait_time = 10.0

var current_track = 0

func _ready() -> void:
	pass
	#wait(wait_time)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	var param = $FmodEventEmitter2D.get_parameter("MenuLayer")
	print(param)
	$FmodEventEmitter2D.set_parameter("MenuLayer", "Sub Menu")

#test function, when player jumps switch the music track
func _on_player_jumped() -> void:

	print("jump signal working?")

	if current_track == 0:
		$FmodEventEmitter2D.set_parameter("MenuLayer", "Sub Menu")
		current_track = 1
	elif current_track == 1:
		$FmodEventEmitter2D.set_parameter("MenuLayer", "Top Menu")
		current_track = 0
