extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D


const SPEED = 75.0

var target = null


func _physics_process(delta: float) -> void:
	if target: 
		_attack(delta)



func _attack(delta: float) -> void: 
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
	animated_sprite_2d.play("move_down")
	

func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body



func _on_sight_body_exited(body):
	if body.name == "Player":
		target = null 
		animated_sprite_2d.play("move_down")
