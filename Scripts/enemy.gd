class_name Enemy 
extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var take_damage_sound = $TakeDamage


const SPEED: int = 75
const KNOCKBACK_FORCE: int = 100

var is_alive: bool = true
var health: int = 100
var target = null


func _physics_process(delta: float) -> void:
	if is_alive and target: 
		_attack(delta)



func _attack(delta: float) -> void: 
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
	animated_sprite_2d.play("move_down")


func take_damage(damage: int, attacker_position: Vector2) -> void:
	health -= damage
	print(health)
	if health <= 0:
		_die()
	else:
		take_damage_sound.play()
	#knockback
		var knockback_direction = (position - attacker_position).normalized()
		var target_position = position + knockback_direction * KNOCKBACK_FORCE
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "position", target_position, 0.5)
	
func _die() -> void:
	is_alive = false
	animated_sprite_2d.play("die")
	
	take_damage_sound.pitch_scale = 0.5
	take_damage_sound.play()
	
	#Disable Collision
	$CollisionShape2D.set_deferred("disabled", true)
	$Sight/CollisionShape2D.set_deferred("disabled", true)
	
func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body



func _on_sight_body_exited(body):
	if body.name == "Player" and is_alive:
		target = null 
		animated_sprite_2d.play("move_down")
