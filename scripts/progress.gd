extends Node
enum Quest {DONE, PENDING, UNINITIATED}
@onready var quest_tracker:Dictionary = {
	"The Fallen Mates": Quest.UNINITIATED
}
@onready var is_quest_completed: bool = false
@onready var quest_reference: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func complete_quest(quest_name:String):
	quest_tracker[quest_name] = Quest.DONE
	is_quest_completed = true
	quest_reference = quest_name
func initaite_quest(quest_name:String):
	quest_tracker[quest_name] = Quest.PENDING
	
func quest_status(quest_name:String, quest_status:String):
	var state: bool = false
	if quest_status == "done":
		if quest_tracker[quest_name] == Quest.DONE:
			state = true
	elif quest_status == "pending":
		if quest_tracker[quest_name] == Quest.PENDING:
			state = true
	elif quest_status == "uninitiated":
		if quest_tracker[quest_name] == Quest.UNINITIATED:
			state = true
	return state
