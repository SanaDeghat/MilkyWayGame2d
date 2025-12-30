extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_setup ()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func level_setup () -> void:
	var enemies = $LevelRoot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_damaged.connect(_on_player_damaged)
			
	#var player = $LevelRoot.get_node_or_null("player")
	#if player:
	#	player.exit_location.connect(_on_exit_clicked)
func _on_player_damaged(body):
	body.damage()    
