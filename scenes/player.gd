extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -850.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var health = 1;
@onready var death_soundeffect: AudioStreamPlayer2D = $Death_soundeffect

	
func _physics_process(delta: float) -> void:
	if health <= 0:
		return
	#adding animation 
	#if not is_on_floor():
	#	animated_sprite_2d.animation = "jumping"
	if velocity.x>1 or  velocity.x < -1 :
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "idle"

	# Add the gravity.hihihihi
	if not is_on_floor():
		animated_sprite_2d.animation = "jumping"
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/de celeration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == -1.0:
		animated_sprite_2d.flip_h=true
	else :
		animated_sprite_2d.flip_h=false
	
func damage()-> void:
			if health > 0:
				animated_sprite_2d.animation = "damaged"
				health -= 1
				print(health)
			if health ==0:
				
				death()
			
			
			
func death()-> void:
	death_soundeffect.play()
	health =-1;
	animated_sprite_2d.animation = "death"
