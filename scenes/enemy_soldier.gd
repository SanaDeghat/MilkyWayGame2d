extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -850.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var direction = 1 
signal player_damaged 


func _physics_process(delta: float) -> void:
	
	#adding animation 
	#if not is_on_floor():
	#	animated_sprite_2d.animation = "jumping"
	if velocity.x>1 or  velocity.x < -1 :
		animated_sprite_2d.animation = "walking"
	else:
		animated_sprite_2d.animation = "idle"

	# Add the gravity.
	if not is_on_floor():
		#animated_sprite_2d.animation = "jumping"
		velocity += get_gravity() * delta
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == -1.0:
		animated_sprite_2d.flip_h=true
	else :
		animated_sprite_2d.flip_h=false
func _process(delta: float) -> void:
	position.x += direction * SPEED* delta
	var player = $Collision.get_overlapping_areas()
	if player.size() > 0:
		emit_signal("player_damaged",1 )
		return

func _on_timer_timeout() -> void:
	animated_sprite_2d.animation = "idle"

	direction *= -1
	
