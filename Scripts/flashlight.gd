class_name Flashlight
extends Node2D

@onready var point_light_2d = $PointLight2D
@onready var falloff_timer : Timer = $FalloffTimer
@onready var fresh_timer : Timer = $FreshTimer

var battery_power : float = 0
var flashlight_on : bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	look_at(get_global_mouse_position())
	rotation += deg_to_rad(-90)
	if !falloff_timer.is_stopped() :
		set_flashlight_power(falloff_timer.time_left)

func _ready(): 
	charge_flashlight()
	set_flashlight_power(falloff_timer.wait_time)

func charge_flashlight() -> void : 
	flashlight_on = true
	battery_power = falloff_timer.wait_time
	set_flashlight_power(battery_power)
	fresh_timer.start()
	falloff_timer.stop()

func set_flashlight_power(power: float) -> void :
	point_light_2d.energy = power / 10


func _on_fresh_timer_timeout():
	falloff_timer.start()
