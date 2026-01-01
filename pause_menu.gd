extends CanvasLayer

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		toggle()

func toggle():
	Game.toggle_pause()
	visible = Game.paused

func _on_resume_pressed():
	Game.toggle_pause()
	visible = false

func _on_quit_pressed():
	get_tree().quit()
