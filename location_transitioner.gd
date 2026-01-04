extends Area2D

@export var DestinationScene: PackedScene
@export var CurrentScenePath: String

func _on_player_leave_location():
	var player = get_overlapping_areas()
	if player.size() == 0:
		return

	# Save where we came from

	print( get_parent().scene_file_path)
	Game.previous_position = player[0].global_position

	# Change to the target scene
	if DestinationScene:
		get_tree().change_scene_to_packed(DestinationScene)
