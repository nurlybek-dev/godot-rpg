extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for child_index in range(get_child_count()):
		var child_node = get_child(child_index)
		if child_node.died:
			continue
		child_node.chase(delta)
