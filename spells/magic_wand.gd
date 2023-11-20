extends Node2D

@export var bullet_scene: PackedScene

func get_nearest_node_in_group(group_name):
	var nearest_node = null
	var nearest_distance = 1000000
	# Iterate through all nodes in the specified group
	for node in get_tree().get_nodes_in_group(group_name):
		var distance = global_position.distance_squared_to(node.global_position)
		
		# Check if the current node is closer than the previously found nearest node
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_node = node

	return nearest_node


func _on_timer_timeout():
	var target = get_nearest_node_in_group('enemy')
	if target:
		look_at(target.global_position)
	else:
		look_at(get_global_mouse_position())
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.rotation = rotation
	get_tree().get_root().add_child(bullet)
