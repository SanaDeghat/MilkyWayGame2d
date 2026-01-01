extends CharacterBody2D

const SPEED := 80.0
var i = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $hitbox

signal player_damaged(damage: int)

var direction := 1
var can_damage := true
func _ready():
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	velocity.x = direction * SPEED
	velocity += get_gravity() * delta
	move_and_slide()

	animated_sprite_2d.animation = "walking" if abs(velocity.x) > 1 else "idle"
	animated_sprite_2d.flip_h = direction < 0

func _process(_delta: float) -> void:
	if can_damage and hitbox.get_overlapping_areas().size() > 0:
		player_damaged.emit(1)       # optional, mostly for debugging
		Game.player.damage(1)        # apply damage through global Game singleton
		can_damage = false
		$DamageCooldownTimer.start() # cooldown timer node to prevent spam

func _on_damage_cooldown_timeout() -> void:
	can_damage = true

func _on_timer_timeout() -> void:
	direction *= -1
