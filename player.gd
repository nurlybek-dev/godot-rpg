extends CharacterBody2D

signal health_hit(value)
signal health_die
@export var speed = 150
@onready var start_position = position

@export var weapon_scenes: Array[PackedScene] = []

var _weapons: Array[Weapon] = []
var _active_weapon = null
var _acitve_weapon_idx = 0


func _ready():
	change_weapon(0)

func change_weapon(idx):
	if idx < len(weapon_scenes):
		if _active_weapon:
			_active_weapon.queue_free()
		var w = weapon_scenes[idx].instantiate()
		$Weapon.add_child(w)
		_active_weapon = w
		_acitve_weapon_idx = idx
	else:
		print("Weapon ", idx, " not found")

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

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode >= 49 and event.keycode <= 57:
			var weapon_idx = event.keycode-49
			if _acitve_weapon_idx != weapon_idx:
				change_weapon(weapon_idx)

func _on_health_die_signal():
	health_die.emit()

func _on_health_hit_signal():
	health_hit.emit($Health.health)
