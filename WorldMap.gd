extends Node2D

export (int) var width = 64
export (int) var height = 64
var entities = []
var tile_map

func _ready():
	for x in range(width):
		entities.append([])
		entities[x].resize(height)
	tile_map = get_node("TileMap") as TileMap
		
func add_entity(entity, pos):
	var tile_pos = tile_map.world_to_map(pos)
	if tile_pos.x < 0 || tile_pos.x > entities.size() || tile_pos.y < 0 || tile_pos.y > entities[tile_pos.x].size() || entities[tile_pos.x][tile_pos.y]: return
	add_child(entity)
	entities[tile_pos.x][tile_pos.y] = entity
	entity.position = Vector2(tile_pos.x * tile_map.cell_size.x, tile_pos.y * tile_map.cell_size.y)
	entity.z_index = tile_pos.y
	
