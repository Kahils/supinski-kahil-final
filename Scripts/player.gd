class_name Player
extends CharacterBody2D


const SPEED = 300.0

var last_direction: Vector2 = Vector2.RIGHT
var is_attacking: bool = false
var strength: int = 20 


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var swing_sword = $SwingSword
@onready var hitbox = $Hitbox
@onready var flashlight : Flashlight = $Flashlight


func _ready() -> void:
	pass



func _physics_process(_delta: float) -> void:
	# Disable hitbox until attack is triggered 
	hitbox.monitoring = false
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
	
	# skip movement if attacking 
	if is_attacking:
		velocity = Vector2.ZERO
		return

	process_movement()
	process_animation()
	move_and_slide()

func process_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left","right","up","down")

	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction 
		update_hitbox_offset()
	else: 
		velocity = Vector2.ZERO



func process_animation() -> void:
	if is_attacking:
		return
	if velocity != Vector2.ZERO:
		play_animation("run", last_direction)
	else:
		play_animation("idle", last_direction)


func play_animation(prefix: String, direction: Vector2) -> void:
	if direction.x != 0:
		animated_sprite_2d.flip_h = direction.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif direction.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif direction.y > 0:
		animated_sprite_2d.play(prefix + "_down")


#-----------------------------------------------------------
# ATTACKING
#-----------------------------------------------------------

func attack() -> void:
	is_attacking = true
	hitbox.monitoring = true 
	swing_sword.play()
	play_animation("attack", last_direction)
	


func _on_animated_sprite_2d_animation_finished():
	if is_attacking:
		is_attacking = false



#-----------------------------------------------------------
# HITBOX
#-----------------------------------------------------------

func update_hitbox_offset() -> void:

	
	match last_direction:
		Vector2.LEFT:
			hitbox.rotation = deg_to_rad(180.0)
		Vector2.RIGHT:
			hitbox.rotation = deg_to_rad(0.0)
		Vector2.UP:
			hitbox.rotation = deg_to_rad(-90.0)
		Vector2.DOWN:
			hitbox.rotation = deg_to_rad(90.0)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if is_attacking and body is Enemy:
		print("HIT")
		body.take_damage(strength, position)
