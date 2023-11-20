extends Node2D
class_name Weapon

@export var basic_projectile_scene: PackedScene = null
@export var special_projectile_scene: PackedScene = null
@export var ultimate_projectile_scene: PackedScene = null

@export var basic_attack_cooldown = 1.0
@export var special_attack_cooldown = 5.0
@export var ultimate_attack_cooldown = 10.0
var _basic_attack_cooldown_timer = 0.0
var _special_attack_cooldown_timer = 0.0
var _ultimate_attack_cooldown_timer = 0.0

var _basic_attack_active = false
var _special_attack_active = false
var _ultimate_attack_active = false

@onready var _sprite = $Sprite2D

func _process(delta):
	if not _basic_attack_active and _basic_attack_cooldown_timer < basic_attack_cooldown:
		_basic_attack_cooldown_timer += delta
	if not _special_attack_active and _special_attack_cooldown_timer < special_attack_cooldown:
		_special_attack_cooldown_timer += delta
	if not _ultimate_attack_active and _ultimate_attack_cooldown_timer < ultimate_attack_cooldown:
		_ultimate_attack_cooldown_timer += delta

	if not _basic_attack_active and not _special_attack_active and not _ultimate_attack_active:
		if Input.is_action_pressed("ultimate_attack"):
			_ultimate_attack()
		elif Input.is_action_pressed("special_attack"):
			_special_attack()
		elif Input.is_action_pressed("basic_attack"):
			_basic_attack()

	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	var dx = global_position.x - mouse_position.x
	if dx > 0:
		scale.y = -1
	elif dx < 0:
		scale.y = 1

func _basic_attack():
	if _basic_attack_cooldown_timer >= basic_attack_cooldown:
		basic_attack()
		_basic_attack_cooldown_timer = 0

func _special_attack():
	if _special_attack_cooldown_timer >= special_attack_cooldown:
		special_attack()
		_special_attack_cooldown_timer = 0

func _ultimate_attack():
	if _ultimate_attack_cooldown_timer >= ultimate_attack_cooldown:
		ultimate_attack()
		_ultimate_attack_cooldown_timer = 0

func basic_attack():
	_basic_attack_active = true
	
func special_attack():
	_special_attack_active = true
	
func ultimate_attack():
	_ultimate_attack_active = true

func instanciate_projectile(
	scene: PackedScene, position: Vector2, rotation: float, parent: Node=null
):
	if scene != null:
		var projectile = scene.instantiate()
		projectile.position = position
		projectile.rotation = rotation
		if parent:
			parent.add_child(projectile)
		else:
			get_tree().get_root().add_child(projectile)
		
		return projectile
