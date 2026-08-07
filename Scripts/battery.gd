class_name Battery
extends Area2D




func _on_body_entered(body):
	var player = body as Player
	player.flashlight.charge_flashlight()
	queue_free()
