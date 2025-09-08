extends Node2D


@onready var level = $Level
@onready var player = $Level/Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var level_paused = false

#BUGGED
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		
	
