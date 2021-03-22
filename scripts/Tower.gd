extends TileMapEntity

export var attack_range = 100
export var attack_speed = 1
var attack_radius
var timer
var target

# Called when the node enters the scene tree for the first time.
func _ready():
	attack_radius = Area2D.new()
	var collision_shape = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = attack_range
	collision_shape.set_shape(shape)
	attack_radius.add_child(collision_shape)
	add_child(attack_radius)
	timer = Timer.new()
	add_child(timer)
	timer.start(1 / attack_speed)
	timer.connect("timeout", self, "shoot")

func shoot():	
	if target && !attack_radius.overlaps_area(target):
		target = null
	if !target:
		var overlapping = attack_radius.get_overlapping_areas()
		for obj in overlapping:
			if obj is Enemy:
				target = obj
				print_debug(target.name)
				break
