extends Node2D

@export var enemy_scene: PackedScene = null
var player = null
var screen_size: Vector2 = Vector2.ZERO

var game_timer: float = 120.0


func reset():
	while $Timers.get_child_count() > 0:
		var child = $Timers.get_child(0)
		$Timers.remove_child(child)
		child.queue_free()
	
	while $Enemies.get_child_count() > 0:
		var child = $Enemies.get_child(0)
		$Enemies.remove_child(child)
		child.queue_free()
	
	add_timer()

func add_timer():
	var timer = Timer.new()
	timer.connect('timeout', _on_timer_timeout)
	timer.autostart = true
	$Timers.add_child(timer)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	game_timer += delta
	if game_timer > 60:
		add_timer()
		game_timer -= 60

func _on_timer_timeout():
	if not is_instance_valid(player):
		return
	var enemy = enemy_scene.instantiate()
	var rand_position = player.position
	
	var enemy_spawn_location = get_node("Path2D/PathFollow2D")
	enemy_spawn_location.progress_ratio = randf()
	
	enemy.position = enemy_spawn_location.position
	enemy.target = player
	$Enemies.add_child(enemy)
