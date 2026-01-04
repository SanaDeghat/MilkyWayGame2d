extends Node

var player: Node = null
signal phase_changed(phase)

var previous_scene_path: String
var previous_position: Vector2 = Vector2.ZERO

const CYCLE_LENGTH := 20.0
var elapsed := 0.0
var phase := -1
var time_active := false

func _process(delta):
	if not time_active:
		return

	elapsed += delta
	var new_phase := int((elapsed / CYCLE_LENGTH) * 4)
	if new_phase != phase:
		phase = new_phase
#		emit phase_changed(new_phase)

	if elapsed >= CYCLE_LENGTH:
		pass

func restart_time():
	elapsed = 0.0
	phase = -1
