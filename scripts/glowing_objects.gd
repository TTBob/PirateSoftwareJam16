extends Node2D
@onready var all_children:Array[Node] = get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func change_cycle(cycle_name:String):
	var cycle_amount:float = 1
	if cycle_name == "day":
		cycle_amount = 1
	elif cycle_name == "night":
		cycle_amount = 0.1
	for source in all_children.size():
		all_children[source].energy = cycle_amount
