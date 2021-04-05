extends HBoxContainer

export (NodePath) var building_item
var main

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/Main")
	for index in range(main.towers.size()):
		var button = get_node(building_item).duplicate()
		add_child(button)
		button.text = main.towers[index].name
		button.connect("pressed", self, "_on_button", [index])
	get_node(building_item).queue_free()
		
func _on_button(index):
	main.tower_index = index
