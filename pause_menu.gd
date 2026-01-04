extends CanvasLayer

func _ready():
	visible=false
func _input(event):
	if event.is_action_pressed("pause"):
		
		if get_tree().paused:
			resume()
		else:
			pause()

func pause():
	get_tree().paused = true
	Game.time_active = false 
	visible = true

func resume():
	get_tree().paused = false
	Game.time_active = true 

	visible = false

	

func _on_resume_pressed():
	resume()
	

func _on_quit_pressed():
	get_tree().quit()
