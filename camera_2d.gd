extends Camera2D
@onready var screen_size: Vector2 = get_viewport_rect().size
@onready var player_node = Game.player
@export var randomstregnth :float = 30.0
@export var shakeFade :float = 5.0

var rng  = RandomNumberGenerator.new()
var shake_strength : float = 0.0

func apply_Shake() -> void:
	shake_strength = randomstregnth
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_screen_position()
	await get_tree().process_frame
	position_smoothing_enabled = true
	position_smoothing_speed = 7.0

	Game.phase_changed.connect(_on_phase_changed)

func Randon_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func _process(delta: float) -> void:
	if player_node.is_dead:
		return
	if Input.is_action_just_pressed("shake"):
		apply_Shake()
		
	if shake_strength > 1:
		shake_strength = lerpf (shake_strength, 0, shakeFade * delta)
		offset = Randon_offset()
	else:
		set_screen_position()

func _on_phase_changed(phase: int) -> void:
	if phase == 3:
		apply_Shake()


func set_screen_position():
	var player_pos = player_node.global_position
	var x = floor(player_pos.x / screen_size.x) * screen_size.x + screen_size.x/2
	var y = floor(player_pos.y / screen_size.y) * screen_size.y + screen_size.y/2 +40
	global_position = Vector2 (x,y)
