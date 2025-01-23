extends Area2D

# ALL ACTION NAMES:
#pickup
#cam_switch
#dialogue
#cutscene
#uninterupted
@export_category("data evaluation")
@export var action_index:int = 1
@export var action_value = 1
@export var action_name:String = ""
@export var action_value_2:Vector2 = Vector2(1,1)
@export_category("auto interact")
@export var auto:bool = false
@export var activation_frequency: String = "hey"
@onready var is_entered:bool = false
#compute_quest()
@export_category("tags")
@export var tag:int = -1
@onready var one_shot = true
@export_category("conditionals")
@export var quest_condition:bool 
@export var quest_name:String
@onready var body_ref 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_entered == true:
		if auto:
			if quest_condition:
				if progress.quest_status(quest_name, "done"):
					if not body_ref.is_busy and one_shot:
						one_shot = false
						apply_data()
			else:
				
				if not body_ref.is_busy and one_shot:
					one_shot = false
					apply_data()
		else:
			if quest_condition:
				if progress.quest_status(quest_name, "done"):
					if body_ref.is_interact and not body_ref.is_busy:
						apply_data()
			else:
				
				if body_ref.is_interact and not body_ref.is_busy:
					apply_data()
	
	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		body_ref = body
		is_entered = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		is_entered = false

func apply_data():
	
		body_ref.is_busy = true
		body_ref.action_index = action_index
		body_ref.action_value[action_index] = action_value
		body_ref.action_second_parameter = action_value_2
		body_ref.action_string = action_name
		body_ref.action_tag = tag
