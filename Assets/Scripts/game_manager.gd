extends Node

var starting_area = 0
var area_container : Node2D
var player : PlayerController

var current_area = 0
var area_path = "res://Assets/Scenes/Areas/"

var energy_cells = 0

func _ready():
	area_container = get_tree().get_first_node_in_group("area_container")
	player = get_tree().get_first_node_in_group("player")
	load_area(starting_area)
	#reset_energy_cells()

func next_area():
	load_area(current_area)
	current_area += 1 # ++ not working is a travesty
	pass
	
func load_area(area_number):
	var full_path = area_path + "area_" + str(area_number) + ".tscn" #get the full file path for the selected scene
	#get_tree().change_scene_to_file(full_path)
	#print("player has entered portal")
	var scene = load(full_path) as PackedScene
	if !scene:
		print("scene not found from file path: failed to load")
		return #returns nothing if the scene file path is invalid
		
	#yeet previous scene (I am cringe but I am free)
	for child in area_container.get_children():
		child.queue_free()
		await child.tree_exited #waits until child scene is actually unloaded before trying to load new scene
		
	var instance = scene.instantiate()
	area_container.add_child(instance)
	
	reset_energy_cells()
	
	var player_start_position = get_tree().get_first_node_in_group("player_start_position") as Node2D
	player.teleport_to_location(player_start_position.position)
	print("player start position: " + str(player_start_position.position))
	#player.teleport_to_location(Vector2(0.0,-40.0))
	
func add_energy_cell():
	energy_cells += 1
	if energy_cells >= 4:
		#open portal
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		portal.open()
		pass
	
func reset_energy_cells():
	energy_cells = 0
