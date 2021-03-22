extends Area2D

var last_move = 0

func _process(delta):
	var time = OS.get_ticks_msec()
	if time - last_move >= 1000:
		last_move = time
		var world = get_node("..")
		if world.dijkstra.has("distance_to_base"):
			var tile_map = world.tile_map
			var tile_pos = tile_map.world_to_map(position)
			position = tile_map.map_to_world(world.dijkstra["distance_to_base"].get_next(tile_pos))
