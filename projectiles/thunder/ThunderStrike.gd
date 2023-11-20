extends Projectile
class_name ThunderStrikeProjectile

func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame == 5:
		$CollisionShape2D.set_deferred('disabled', false)
	elif $AnimatedSprite2D.frame > 6:
		$CollisionShape2D.set_deferred('disabled', true)
