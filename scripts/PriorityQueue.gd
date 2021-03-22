extends Object
class_name PriorityQueue

var values = []

func compare(a, b):
	return a.priority < b.priority
		
func insert(value, priority):
	var obj = {"value": value, "priority": priority}
	var index = values.bsearch_custom(obj, self, "compare")
	values.insert(index, obj)
	
func get_next():
	return values.pop_front().value
	
func clear():
	values.clear()
	
func empty():
	return !values.size()
