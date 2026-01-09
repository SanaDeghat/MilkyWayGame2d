extends Area2D
@onready var intractble_indicator: AnimatedSprite2D = $Intractble_indicator
@export var dialogue_resource : DialogueResource
@export var dialogue_start : String = "start"

func _on_area_entered(area: Area2D) -> void:
	print("entered")
	intractble_indicator.visible = true
	intractble_indicator.play("Show")

func _on_area_exited(area: Area2D) -> void:
	intractble_indicator.play("hide")


func _on_intractble_indicator_animation_finished() -> void:
	if intractble_indicator.animation == "hide" :
		intractble_indicator.visible = false
func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
