extends Weapon

class_name FireWandWeapon

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
	instanciate_projectile(
		special_projectile_scene, 
		_special_shoot_position.global_position, 
		rotation
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


