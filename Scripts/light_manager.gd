extends PointLight2D

@onready var animated_sprite_2d = $"../AnimatedSprite2D"

var canvas: CanvasModulate


# Called when the node enters the scene tree for the first time.
#func _ready():
	#canvas = get_tree().root.find_child("Darkness")
	#if canvas != null:
		#enabled = true
		#animated_sprite_2d.self_modulate = Color.WEB_GRAY
	#else: 
		#enabled = false
		#animated_sprite_2d.self_modulate = Color.WHITE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
