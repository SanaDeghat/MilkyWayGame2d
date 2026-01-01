extends Node

var player: Node = null
var paused := false

func toggle_pause():
	paused = !paused
	get_tree().paused = paused
