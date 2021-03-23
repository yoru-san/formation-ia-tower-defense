extends Object
class_name DijkstraMap

var frontier = PriorityQueue.new()
var score = []
var max_cost = 0
var neighbours = [Vector2(1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(-1, 0)]
var destinations
var cost

func _init(destinations, cost):
	self.destinations = destinations
	self.cost = cost

func handle_neighbour(current, neighbour, cost):
	if neighbour.x < 0 || neighbour.x >= cost.size() || neighbour.y < 0 || neighbour.y >= cost[neighbour.x].size(): return
	if cost[neighbour.x][neighbour.y] == null: return
	var new_cost = score[current.x][current.y] + cost[neighbour.x][neighbour.y]
	if score[neighbour.x][neighbour.y] == null || new_cost < score[neighbour.x][neighbour.y]:
		score[neighbour.x][neighbour.y] = new_cost
		frontier.insert(neighbour, new_cost)
		max_cost = max(max_cost, new_cost)
		
func calculate():
	frontier.clear()
	score.clear()
	max_cost = 0
	for x in range(cost.size()):
		score.append([])
		score[x].resize(cost[x].size())
	for pos in destinations:
		score[pos.x][pos.y] = 0
		frontier.insert(pos, 0)

	while !(frontier.empty()):
		var current = frontier.get_next()
		for neighbour in neighbours:
			handle_neighbour(current, current + neighbour, cost)
			
	# comme les destinations sont souvent des bâtiments, on vérifie après avoir calculé les scores si on peut traverser ces cases ou pas
	for pos in destinations:
		if cost[pos.x][pos.y] == null: score[pos.x][pos.y] = null
	
	
func get_next(pos):
	var lowest_neighbour = Vector2(pos.x, pos.y)
	var lowest_score = score[lowest_neighbour.x][lowest_neighbour.y]
	for neighbour in neighbours:
		var neighbour_pos = pos + neighbour
		if neighbour_pos.x < 0 || neighbour_pos.x >= score.size() || neighbour_pos.y < 0 || neighbour_pos.y >= score[neighbour_pos.x].size(): continue
		var neighbour_score = score[neighbour_pos.x][neighbour_pos.y]
		if neighbour_score != null && neighbour_score < lowest_score:
			lowest_score = neighbour_score
			lowest_neighbour = pos + neighbour
	return lowest_neighbour
	
	
