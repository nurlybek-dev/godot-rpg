extends Node2D

@export var bullet_scene: PackedScene

@onready var _shoot_position = $ShootPosition
@onready var _sprite = $Pivot/Sprite2D


func _process(delta):
	var mouse_position = get_global_mouse_position()
	var dx = global_position.x - mouse_position.x
	
	if dx > 0:
		_sprite.flip_v = true
	elif dx < 0:
		_sprite.flip_v = false
	
	look_at(get_global_mouse_position())

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = _shoot_position.global_position
	bullet.rotation = rotation
	get_tree().get_root().add_child(bullet)


func _on_timer_timeout():
	shoot()
