extends Area2D
class_name Enemy

export (float) var speed
export (float) var hitpoints = 20
export (String) var dijkstra
var destination

func _process(delta):
	z_index = position.y
	var world = get_node("..")
	if world.dijkstra.has(dijkstra):
		var distance = 0
		if destination:
			distance = position.distance_to(destination)
		var tile_map = world.tile_map
		var tile_pos = tile_map.world_to_map(position)
		var move_amount = delta * speed / world.get_cost(tile_pos)
		if (distance < move_amount):
			destination = tile_map.map_to_world(world.dijkstra[dijkstra].get_next(tile_pos))
		position = position.move_toward(destination, move_amount)
		
func take_damage(amount):
	hitpoints -= amount
	if (hitpoints <= 0):
		queue_free()
