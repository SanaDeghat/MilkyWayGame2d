extends Node2D

func _ready() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		print("enemy")
		enemy.player_damaged.connect(_on_player_damaged)

func _on_player_damaged(damage: int) -> void:
	print ("player damaged")
	if Game.player:
		Game.player.damage(damage)
