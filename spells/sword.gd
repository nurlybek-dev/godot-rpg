extends Node2D

@export var bullet_scene: PackedScene

@onready var _shoot_position = $ShootPosition

func _on_timer_timeout():
	look_at(get_global_mouse_position())
	var bullet = bullet_scene.instantiate()
	bullet.position = _shoot_position.global_position
	bullet.rotation = rotation
	get_tree().get_root().add_child(bullet)
