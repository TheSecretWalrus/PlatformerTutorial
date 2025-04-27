extends Node

var current_area = 0
var area_path = "res://Assets/Scenes/Areas/"

var energy_cells = 0

func _ready():
	reset_energy_cells()

func next_level():
	current_area += 1 # ++ not working is a travesty
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	print("player has entered portal")
	pass
	
func set_up_area():
	reset_energy_cells()
	#oooh new comment hehe
	
func add_energy_cell():
	energy_cells += 1
	if energy_cells >= 2:
		#open portal
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		portal.open()
		pass
	
func reset_energy_cells():
	energy_cells = 0
