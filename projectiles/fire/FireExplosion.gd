extends Node2D

@export var explosion_projectile_scene: PackedScene = null
@export var explosion_count: int = 3
@export var explosion_offset: float = 50.0
@export var explosion_spawn_time: float = 0.2

var _spawn_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_timer_timeout()
	$Timer.wait_time = explosion_spawn_time
	$Timer.start()

func _on_timer_timeout():
	var explosion = explosion_projectile_scene.instantiate()
	var offset = Vector2(explosion_offset * _spawn_count, 0).rotated(rotation)
	explosion.position = global_position + offset
	get_tree().get_root().add_child(explosion)
	_spawn_count += 1
	if _spawn_count >= explosion_count:
		queue_free()
