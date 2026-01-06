extends Area2D

@export var DestinationScene: PackedScene
@export var intractble_indicator_x: int
@export var intractble_indicator_y: int
@export var intractble_indicator_scale: int

@onready var intractble_indicator: AnimatedSprite2D = $Intractble_indicator



func _on_player_leave_location():
	var player = get_overlapping_areas()
	if player.size() == 0:
		return
	

	# Save where we came from

	print( DestinationScene.resource_path)
	Game.previous_position = player[0].global_position

	# Change to the target scene
	if DestinationScene:
		get_tree().change_scene_to_packed(DestinationScene)

#func _ready() -> void:
#	intractble_indicator.global_position = Vector2(intractble_indicator_x, intractble_indicator_y)
#	intractble_indicator.scale.x = intractble_indicator_scale	

func _on_area_entered(area: Area2D) -> void:
	intractble_indicator.visible = true
	intractble_indicator.play("Show")

func _on_area_exited(area: Area2D) -> void:
	intractble_indicator.play("hide")


func _on_intractble_indicator_animation_finished() -> void:
	if intractble_indicator.animation == "hide" :
		intractble_indicator.visible = false
