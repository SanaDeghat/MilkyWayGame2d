extends Node2D

var level = 1
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
			
	var exit = $LevelRoot.get_node_or_null("exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
func _on_player_damaged(body):
	body.damage()    

func _on_exit_body_entered(body: Node2D) -> void :
		if body.name == "player":
			level+=1
			print(body.name)
	
