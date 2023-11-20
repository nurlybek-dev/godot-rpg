extends Weapon

class_name ThunderWandWeapon

@export var thunder_strike_distance: float = 200.0

@onready var _basic_shoot_position = $BasicShootPosition
@onready var _special_shoot_position = $SpecialShootPosition
@onready var _ultimate_shoot_position = $UltimateShootPosition


func basic_attack():
	instanciate_projectile(
		basic_projectile_scene, 
		_basic_shoot_position.global_position, 
		rotation
		)

func special_attack():
	var target_position = get_global_mouse_position()
	var t = clamp(thunder_strike_distance / global_position.distance_to(target_position), 0.0, 1.0)
	
	# Interpolate between the two positions
	var interpolatedPosition = global_position.lerp(target_position, t)
	instanciate_projectile(
		special_projectile_scene, 
		interpolatedPosition,
		0
	)

func ultimate_attack():
	var projectile = instanciate_projectile(
		ultimate_projectile_scene, 
		Vector2.ZERO,
		0,
		_ultimate_shoot_position
	)
	super.ultimate_attack()
	
	if projectile:
		projectile.connect("tree_exited", _on_ultimate_tree_exited)

func _on_ultimate_tree_exited():
	_ultimate_attack_active = false
