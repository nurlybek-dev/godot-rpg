extends Node2D

signal hit_signal
signal die_signal

@export var start_health: int = 0
var health: int = 0

func reset():
	health = start_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

func hit(value: int) -> void:
	print(Time.get_datetime_string_from_system(), ": ", self, " hit ", value)
	health -= value
	hit_signal.emit()
	if health <= 0:
		die_signal.emit()
