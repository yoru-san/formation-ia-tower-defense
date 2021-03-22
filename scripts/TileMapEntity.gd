extends Area2D
class_name TileMapEntity

# Declare member variables here. Examples:
export (int) var width = 1
export (int) var height = 1
export (String) var tag

func _ready():
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(width / 2, height / 2)
	collision_shape.set_shape(shape)
	add_child(collision_shape)
	collision_shape.position = Vector2(width / 2, height / 2)
