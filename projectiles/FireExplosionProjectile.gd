extends Projectile
class_name FireExplosionProjectile

func _on_area_entered(area):
	if area.is_in_group('enemy'):
		area.get_node('Health').hit(damage)
