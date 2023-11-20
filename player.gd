extends CharacterBody2D

signal health_hit(value)
signal health_die
@export var speed = 150
@onready var start_position = position


func reset():
	position = start_position
	$Health.reset()

func move():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	move_and_slide()

func animate():
	var mouse_position = get_global_mouse_position()
	var dx = global_position.x - mouse_position.x
	if dx > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
#
	if velocity != Vector2.ZERO:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	move()
	animate()

func _on_health_die_signal():
	health_die.emit()

func _on_health_hit_signal():
	health_hit.emit($Health.health)
