extends Node2D

var rects = []

func dijkstra(map, tile_size):
	rects.clear()
	for x in range(map.score.size()):
		for y in range(map.score[x].size()):
			if map.score[x][y] == null: continue
			rects.append({"rect": Rect2(x * tile_size.x, y * tile_size.y, tile_size.x, tile_size.y), "color": Color.from_hsv((map.score[x][y] / map.max_cost) * 0.66, 1, 1, 0.5)})
	update()

func _draw():
	for rect in rects:
		draw_rect(rect.rect, rect.color)
