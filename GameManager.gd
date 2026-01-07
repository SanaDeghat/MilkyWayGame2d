extends Node
var player: Node = null
signal phase_changed(phase)

const CYCLE_LENGTH := 20.0
var elapsed := 0.0
var phase := -1
var time_active := false
var previous_scene_path: String 
var respawn_location_path: String 
var previous_position: Vector2 = Vector2.ZERO
func _process(delta):
	if not time_active:
		return

	elapsed += delta
	var new_phase := int((elapsed / CYCLE_LENGTH) * 8)

	if new_phase != phase:
		phase = new_phase
		#
		if player and phase < 9 :
			player.changeClock(8-phase)
		phase_changed.emit(phase) # emit on change

	if elapsed >= CYCLE_LENGTH:
		player.damage(100)
