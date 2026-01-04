extends Node2D

func _ready() -> void:
	Game.previous_scene_path = get_tree().current_scene.scene_file_path
