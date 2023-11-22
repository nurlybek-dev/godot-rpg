extends Area2D

@export var speed = 100
@export var chase_speed = 500
@export var chase_distance = 250
@export var chase_cooldown = 3
@export var rand_move_cooldown = 1.0
@export var damage = 1
var target = null
var chase_timer = 0
var chased = false
var chase_direction = null
var chased_distance = 0
var velocity = Vector2.ZERO
var died = false
var rand_move_timer = 0
var rand_position = null

func chase(delta):
	velocity = Vector2.ZERO
#	if rand_position:
#		var direction = (rand_position - position).normalized()
#		velocity = direction * speed * delta
#		if position.distance_to(rand_position) < 10:
#			rand_position = null
	if chased:
		velocity = chase_direction * chase_speed * delta
		chased_distance += velocity.length()
		if chased_distance >= chase_distance * 2:
			chased = false
			chase_timer = 0
			chased_distance = 0
			chase_direction = null
	else:
		if is_instance_valid(target):
			chase_timer += delta
			var distance = position.distance_to(target.position)
			var direction = (target.position - position).normalized()
			if distance <= chase_distance:
				if chase_timer >= chase_cooldown:
					chase_direction = direction
					chased = true
					# rand_position = null
			else:
				velocity = direction * speed * delta
				# rand_position = null
	if velocity:
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run", 2.0 if chased else 1.0)
		position += velocity
	else:
		$AnimatedSprite2D.play("idle")

func die():
	died = true
	$AnimatedSprite2D.offset.y = -15
	$AnimatedSprite2D.play("death")
	$CollisionShape2D.set_deferred("disabled", true)

func _ready():
	chase_cooldown = chase_cooldown + randf_range(0.0, 1.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if died:
#		return
#	chase(delta)

func _on_body_entered(body):
	if body.is_in_group("player"):
		if chased:
			die()
			body.get_node('Health').hit(damage)

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == 'death':
		queue_free()

func _on_random_move_timer_timeout():
	if not chased and velocity == Vector2.ZERO:
		rand_position = position + Vector2(randf_range(-50, 50), randf_range(-50, 50))
	$RandomMoveTimer.wait_time = randf_range(1.0, 1.0 + rand_move_cooldown)

func _on_health_die_signal():
	die()
