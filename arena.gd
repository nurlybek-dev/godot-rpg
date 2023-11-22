extends Node2D

var game_over = false

func restart():
	$EnemyContainer.process_mode = Node.PROCESS_MODE_INHERIT
	$Player.process_mode = Node.PROCESS_MODE_INHERIT
	$Player.reset()
	$EnemyContainer.reset()
	$UI.reset()
	game_over = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over and Input.is_action_just_pressed("ui_accept"):
		restart()

func _on_player_health_die():
	$EnemyContainer.process_mode = Node.PROCESS_MODE_DISABLED
	$Player.process_mode = Node.PROCESS_MODE_DISABLED
	game_over = true
