
@icon("res://icons/16x16/dialogue_page.png")
extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_json(path: String) -> Dictionary:
	'''
	loads a dictionnary from a json file
	
	path : String
		the path to the json file to load
	
	return : Dictionnary
		the data parsed as a gdScript Dictionnary
	
	raises : 
	'''
	var json_content = FileAccess.get_file_as_string(path) # parse json contents as string
	var json = JSON.new()
	var error = json.parse(json_content) # parse json format
	var json_data = Dictionary() # prepare output
	if error == OK: # if no parsing errors
		var data_received = json.data # read data
		# throw error if the data is not dict-like
		assert(typeof(data_received) == TYPE_DICTIONARY, "ValueError : json file must be dict-like")
		json_data = data_received
	else:
		# throw error when the json parsing failed
		print("JSON Parse Error: ", json.get_error_message(), " in `", path, "` at line ", json.get_error_line())
		push_error(error)
	
	return json_data
