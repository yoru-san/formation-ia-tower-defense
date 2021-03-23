extends Node2D

export (PackedScene) var tower
var world

func _ready():
	world = get_node("World")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var new_tower = tower.instance()
			world.add_entity(new_tower, event.position)
		if event.button_index == BUTTON_RIGHT and event.pressed:
			var tile_pos = world.tile_map.world_to_map(event.position)
			if tile_pos.x > 0 && tile_pos.x < world.width && tile_pos.y > 0 && tile_pos.y < world.height && world.entities[tile_pos.x][tile_pos.y]:
				var entity = world.entities[tile_pos.x][tile_pos.y]
				if entity is Tower:
					world.remove_entity(entity)
	if Input.is_action_just_pressed("toggle_debug"):
		get_node("DebugDrawing").cycle()
