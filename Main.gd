extends Node2D

export (PackedScene) var Tower

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var tower = Tower.instance()
			get_node("World").add_entity(tower, event.position)
		
