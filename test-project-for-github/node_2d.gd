extends Area2D

var velocity = Vector2(100,0)
var maxsize: float = 100
var size = maxsize/2
var rng = RandomNumberGenerator.new()
var parent = null
var child = null
@onready var screensize = get_viewport().get_visible_rect().size

func _ready():
	if not visible:
		set_process(false)
	#var x_velocity = rng.randf_range(-10.0, 10.0)
	#var y_velocity = rng.randf_range(-10.0, 10.0)
	#velocity = Vector2(x_velocity, y_velocity)*10
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta
	size += 1
	#var scalefactor = 1 + size/200
	var scalefactor = 1
	scale = Vector2(scalefactor,scalefactor)	
	if maxsize < size:
		#Reproduction
		var clone = duplicate()
		get_parent().add_child(clone)
		clone.velocity = clone.velocity.rotated(PI+rng.randf_range(-1, 1))
		clone = self.child
		size -= maxsize/2
		
	#Despawns if off screen
	if position.x < 0 or screensize.x < position.x:
		queue_free()
	elif position.y < 0 or screensize.y < position.y:
		queue_free()

#BUGGED
func _on_area_entered(area: Area2D) -> void:
	#If area is my child, spare
	if area == self.child or area.child == self:
		pass
	else:
		area.queue_free()
