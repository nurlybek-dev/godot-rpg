extends CanvasLayer

var timer: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	timer = 0
	$Label.text = str(timer/60).pad_zeros(2) + ':' + str(timer%60).pad_zeros(2)
	$ProgressBar.value = 100
	$GameOverContainer.visible = false
	$Timer.start()

func _on_timer_timeout():
	timer += 1
	$Label.text = str(timer/60).pad_zeros(2) + ':' + str(timer%60).pad_zeros(2)


func _on_player_health_hit(value):
	$ProgressBar.value = value
	$Timer.stop()

func _on_player_health_die():
	$GameOverContainer.visible = true
