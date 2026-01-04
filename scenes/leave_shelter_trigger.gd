extends Area2D

func _on_player_leave_location():
	var player = get_overlapping_areas()
	if player.size() == 0:
		return

	# Return to the previous scene
	
	get_tree().change_scene_to_file(Game.previous_scene_path)
