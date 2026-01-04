extends CharacterBody2D

const SPEED := 400.0
const JUMP_VELOCITY := -850.0
const CLIMB_SPEED := 200.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_soundeffect: AudioStreamPlayer2D = $Death_soundeffect
@onready var actionable_finder: Area2D = $"actionable finder"
@onready var exit_finder: Area2D = $exit_finder
@onready var ladder_finder: Area2D = $ladder_finder

var health := 1
var on_ladder := false
var climbing := false

const MAN_WITH_THE_RIFFLE = preload("uid://c2so27i1be0qg")

signal leave_location

func _ready() -> void:
	Game.player = self   # 🔑 register globally

func _physics_process(delta: float) -> void:
	if health <= 0:
		return

	if Input.is_action_just_pressed("ui_accept"):
		if actionable_finder.get_overlapping_areas().size() > 0:
			DialogueManager.show_example_dialogue_balloon(
				MAN_WITH_THE_RIFFLE, "start"
			)
			return
		elif exit_finder.get_overlapping_areas().size() > 0:
			leave_location.emit()
			return
	var direction := Input.get_axis("left", "right")
	var vertical_dir := Input.get_axis("up", "down")
	var grounded := is_on_floor()

	# Ladder
	if on_ladder:
		if vertical_dir != 0:
			velocity.y = vertical_dir * CLIMB_SPEED
			climbing = true
		else:
			if grounded:
				climbing = false
				
			
	else:
		climbing = false

	# Gravity
	if not grounded and not climbing:
		velocity += get_gravity() * delta
		

	# Jump
	if Input.is_action_just_pressed("up") and grounded and not climbing:
		velocity.y = JUMP_VELOCITY

	# Horizontal
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Flip
	if direction != 0:
		animated_sprite_2d.flip_h = direction < 0

	# Animations
	if climbing: 
		if vertical_dir != 0: animated_sprite_2d.play("climbing") 
		else: 
			animated_sprite_2d.pause()
			velocity.y = 0

	elif not grounded:
		animated_sprite_2d.play("jumping")
	elif abs(velocity.x) > 1:
		animated_sprite_2d.play("running")
	else:
		animated_sprite_2d.play("idle")

# =========================
# DAMAGE
# =========================
func damage(amount: int) -> void:
	if health <= 0:
		return

	health -= amount
	animated_sprite_2d.play("damaged")
	print("Health:", health)

	if health <= 0:
		death()

func death() -> void:
	death_soundeffect.play()
	animated_sprite_2d.play("death")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		animated_sprite_2d.stop()
		animated_sprite_2d.frame = animated_sprite_2d.sprite_frames.get_frame_count("death") - 1


func _on_ladder_finder_body_entered(body: Node2D) -> void:
	on_ladder=true

func _on_ladder_finder_body_exited(body: Node2D) -> void:
	on_ladder=false
