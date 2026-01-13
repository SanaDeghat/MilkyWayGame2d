extends CanvasLayer
var last_input_was_controller: bool = false
#@onready var animated_sprite_2d: AnimatedSprite2D = $Control/Panel/VBoxContainer/TextureRect/AnimatedSprite2D

func _ready():
	visible=false

func _input(event):
	"""	if animated_sprite_2d == null:
		return
	if event is InputEventKey:
		animated_sprite_2d.animation = "Keyboard"
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion :
		animated_sprite_2d.animation = "Controller"""
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func pause():
	#get_tree().paused = true
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
