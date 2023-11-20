extends Area2D

@export var speed = 100
@export var damage = 1

var velocity
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(speed, 0).rotated(rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta

func _on_life_timer_timeout():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group('enemy'):
		area.get_node('Health').hit(damage)
	queue_free()
