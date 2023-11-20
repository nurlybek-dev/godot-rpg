extends Projectile

@export var duration: float = 5.0
@export var damage_tick: float = 0.5

var _duration: float = 0.0
var _tick_cooldown: float = 0.0
@onready var _sprite = $AnimatedSprite2D


func _ready():
	super._ready()
	velocity = Vector2.ZERO
	disconnect("area_entered", _on_area_entered)

func _process(delta):
	_duration += delta
	_tick_cooldown += delta
	if _tick_cooldown >= damage_tick:
		var areas = get_overlapping_areas()
		for area in areas:
			if area.is_in_group('enemy'):
				area.get_node('Health').hit(damage)
	
	if _duration >= duration:
		$AnimatedSprite2D.play('impact')
