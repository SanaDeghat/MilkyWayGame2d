extends Area2D

@export var Next_Room : PackedScene


func _on_player_leave_location() -> void:
	var player = get_overlapping_areas()
	if player.size() > 0:
			get_tree().change_scene_to_packed(Next_Room)
