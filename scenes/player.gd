extends CharacterBody2D

const SPEED := 400.0
const JUMP_VELOCITY := -850.0
const CLIMB_SPEED := 200.0
@export var MAX_FOOD := 5
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_soundeffect: AudioStreamPlayer2D = $Death_soundeffect
@onready var actionable_finder: Area2D = $"actionable finder"
@onready var exit_finder: Area2D = $exit_finder
@onready var ladder_finder: Area2D = $ladder_finder
@onready var fade_to_black_animation: CanvasLayer = $fadeToBlackAnimation
var health := 1
var on_ladder := false
var climbing := false
var is_dead := false
const MAN_WITH_THE_RIFFLE = preload("uid://c2so27i1be0qg")
var rationsList : Array[TextureRect]
signal leave_location
func player_check()->void:
	print("check")
func _ready() -> void:
	
	Game.player = self   # 🔑 register globally
	for child in $CanvasLayer/Control/HBoxContainer.get_children():
		rationsList.append(child)
	changeClock(8-Game.phase)
	update_hunger_display()
func _physics_process(delta: float) -> void:
	if health <= 0:
		if Input.is_action_just_pressed("ui_accept"):
			fade_to_black_animation.play("fadeToBlack")
			get_tree().change_scene_to_file("res://scenes/shelter.tscn")
			Game.elapsed=0
			Game.rations=Game.saved_rations
			health=1

		else:
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
func food_collected() -> void:
	Game.rations+=1
	update_hunger_display()
func update_hunger_display() -> void:
	for i in range(rationsList.size()):
		rationsList[i] .visible= i<Game.rations
func death() -> void:
	death_soundeffect.play()
	Game.previous_scene_path = Game.respawn_location_path
	animated_sprite_2d.play("death")
	
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		animated_sprite_2d.stop()
		animated_sprite_2d.frame = animated_sprite_2d.sprite_frames.get_frame_count("death") - 1
func changeClock(time:int) -> void:
	$CanvasLayer/AnimatedSprite2D.animation = str(time)


func _on_ladder_finder_body_entered(body: Node2D) -> void:
	on_ladder=true

func _on_ladder_finder_body_exited(body: Node2D) -> void:
	on_ladder=false
