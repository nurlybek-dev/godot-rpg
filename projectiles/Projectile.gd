extends Area2D
class_name Projectile

@export var speed = 100
@export var damage: float = 1.0

var velocity

func _ready():
	velocity = Vector2(speed, 0).rotated(rotation)
	connect("area_entered", _on_area_entered)
	connect("body_entered", _on_area_entered)
	$AnimatedSprite2D.connect("animation_finished", _on_animation_finished)

func _physics_process(delta):
	position += velocity * delta

func _on_area_entered(area):
	print(area)
	if area.is_in_group('enemy'):
		area.get_node('Health').hit(damage)
	velocity = Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play('impact')

func _on_animation_finished():
	if $AnimatedSprite2D.animation == 'impact':
		queue_free()
