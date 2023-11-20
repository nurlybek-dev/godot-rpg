extends Projectile
class_name ThunderBirdProjectile



func _ready():
	super._ready()
	velocity = Vector2.ZERO


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == 'default':
		var root = get_tree().get_root()
		var parent = get_parent()
		position = parent.global_position
		rotation = parent.get_parent().rotation
		parent.remove_child(self)
		root.add_child(self)
		$AnimatedSprite2D.play("fly")
		velocity = Vector2(speed, 0).rotated(rotation)

func _on_area_entered(area):
	if area.is_in_group('enemy'):
		area.get_node('Health').hit(damage)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
