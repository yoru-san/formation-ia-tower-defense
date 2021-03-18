extends Node2D

export (int) var width = 64
export (int) var height = 64
var entities = []
var tile_map

func _ready():
	for x in range(width):
		entities.append([])
		entities[x].resize(height)
	tile_map = get_node("TileMap")
	var base = get_node("Base")
	add_entity(base, base.position)
		
func add_entity(entity, pos):
	var tile_pos = tile_map.world_to_map(pos)
	if tile_pos.x < 0 || tile_pos.x > entities.size() - 1 || tile_pos.y < 0 || tile_pos.y > entities[tile_pos.x].size() - 1 || entities[tile_pos.x][tile_pos.y]: return
	
	var group = tile_map.get_group(tile_pos)
	if group == 'road' || group == 'water' || group == 'tree': return
	
	add_child(entity)
	var tilemap_entity = entity as TileMapEntity
	if tilemap_entity:
		for x in range(tilemap_entity.width):
			for y in range(tilemap_entity.height):
				entities[tile_pos.x + x][tile_pos.y + y] = entity
	else: entities[tile_pos.x][tile_pos.y] = entity
	
	entity.position = Vector2(tile_pos.x * tile_map.cell_size.x, tile_pos.y * tile_map.cell_size.y)
	entity.z_index = tile_pos.y
	
