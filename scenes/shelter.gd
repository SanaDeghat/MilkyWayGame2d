extends Node2D
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

@onready var canvas_layer: CanvasLayer = $CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if Game.phase <= Game.MAX_PHASE and Game.rations>=2:
			reset_cycle()
func reset_cycle() -> void:
	Game.respawn_location_path = Game.previous_scene_path
	Game.saved_rations = Game.rations
	Game.elapsed=0
	Game.time_active=false
	canvas_layer.play("fadeToBlack")
	Game.rations -= 2
	Game.player.update_hunger_display()
	Game.time_active=true
