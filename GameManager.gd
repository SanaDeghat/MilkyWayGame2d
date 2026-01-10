extends Node
var player: Node = null
var actionable: Node = null
signal phase_changed(phase)
var rations := 0
var saved_rations := 0
const CYCLE_LENGTH := 200.0
const MAX_PHASE=8
var elapsed := 0.0
var phase := -1
var time_active := false
var previous_scene_path: String 
var respawn_location_path: String 
var respawn_position: Vector2 = Vector2.ZERO
var previous_position: Vector2 = Vector2.ZERO
var collected_food := {}

func _process(delta):
	if not time_active:
		return

	elapsed += delta
	var new_phase := int((elapsed / CYCLE_LENGTH) * 8)

	if new_phase != phase:
		phase = new_phase
		#
		if player and phase <= MAX_PHASE :
			player.changeClock(MAX_PHASE-phase)
		phase_changed.emit(phase) # emit on change

	if elapsed >= CYCLE_LENGTH:
		player.damage(100)
