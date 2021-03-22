extends Node2D

export (int) var width = 64
export (int) var height = 64
var entities = []
var tile_map
var dijkstra = {}
var graphs = {}

func _ready():
	for x in range(width):
		entities.append([])
		entities[x].resize(height)
	tile_map = get_node("TileMap")
	dijkstra['distance_to_base'] = DijkstraMap.new()
	graphs['cost'] = []
	for x in range(width):
		graphs['cost'].append([])
		graphs['cost'][x].resize(height)
		for y in range(height):
			var group = tile_map.get_group(Vector2(x, y))
			if group == 'water' || group == 'tree': graphs['cost'][x][y] = null
			elif group == 'road': graphs['cost'][x][y] = 0.2
			else: graphs['cost'][x][y] = 1
			
	var base = get_node("Base")
	add_entity(base, base.position)
		
func add_entity(entity, pos):
	var tile_pos = tile_map.world_to_map(pos)
	if tile_pos.x < 0 || tile_pos.x > entities.size() - 1 || tile_pos.y < 0 || tile_pos.y > entities[tile_pos.x].size() - 1 || entities[tile_pos.x][tile_pos.y]: return
	
	var group = tile_map.get_group(tile_pos)
	if group == 'road' || group == 'water' || group == 'tree': return
	
	if !group:
		print_debug(tile_map.get_cell_autotile_coord(tile_pos.x, tile_pos.y))
	
	add_child(entity)
	var entity_positions = []
	var tilemap_entity = entity as TileMapEntity
	if tilemap_entity:
		for x in range(tilemap_entity.width):
			for y in range(tilemap_entity.height):
				entity_positions.append(Vector2(tile_pos.x + x, tile_pos.y + y))
	else: entity_positions.append(tile_pos)
	for pos in entity_positions:
		entities[pos.x][pos.y] = entity
		graphs['cost'][pos.x][pos.y] = null

	if (tilemap_entity && tilemap_entity.tag == 'base'):
		dijkstra['distance_to_base'].calculate(entity_positions, graphs['cost'])
	
	entity.position = Vector2(tile_pos.x * tile_map.cell_size.x, tile_pos.y * tile_map.cell_size.y)
	entity.z_index = tile_pos.y
	get_node("../DebugDrawing").dijkstra(dijkstra['distance_to_base'], tile_map.cell_size)
	
