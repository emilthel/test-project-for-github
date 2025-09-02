extends Area2D

var velocity = Vector2(10,0)
var time = 0
var rng = RandomNumberGenerator.new()
func _ready():
	var x_velocity = rng.randf_range(-10.0, 10.0)
	var y_velocity = rng.randf_range(-10.0, 10.0)
	velocity = Vector2(x_velocity, y_velocity)*10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += 1
	position += velocity * delta
