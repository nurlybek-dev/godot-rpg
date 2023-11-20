extends Node2D

@export var damage = 2

func _on_sword_bullet_area_entered(area):
	if area.is_in_group('enemy'):
		area.get_node('Health').hit(damage)
