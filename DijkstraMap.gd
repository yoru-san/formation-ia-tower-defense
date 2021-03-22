extends Object
class_name DijkstraMap

var frontier = PriorityQueue.new()
var score = []
var max_cost = 0

func handle_neighbour(current, neighbour, cost):
	if neighbour.x < 0 || neighbour.x >= cost.size() || neighbour.y < 0 || neighbour.y >= cost[neighbour.x].size(): return
	if cost[neighbour.x][neighbour.y] == null: return
	var new_cost = score[current.x][current.y] + cost[neighbour.x][neighbour.y]
	if score[neighbour.x][neighbour.y] == null || new_cost < score[neighbour.x][neighbour.y]:
		score[neighbour.x][neighbour.y] = new_cost
		frontier.insert(neighbour, new_cost)
		max_cost = max(max_cost, new_cost)
		
func calculate(destinations, cost):
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
		handle_neighbour(current, Vector2(current.x + 1, current.y), cost)
		handle_neighbour(current, Vector2(current.x, current.y + 1), cost)
		handle_neighbour(current, Vector2(current.x - 1, current.y), cost)
		handle_neighbour(current, Vector2(current.x, current.y - 1), cost)
		
