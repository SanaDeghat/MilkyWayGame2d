extends Control


func _ready():
	print("MENU READY")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	Game.time_active=true
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")


func _on_options_button_pressed() -> void:
		print ("options") # Replace with function body.
 # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
