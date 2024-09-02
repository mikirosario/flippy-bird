extends TextureRect

var indicator_velocity : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("I am indicator rar: %s" % indicator_velocity)
	var tween = create_tween().set_loops()
	tween.tween_property(self, "position", Vector2(self.position.x, self.position.y + 10), indicator_velocity)
	tween.tween_property(self, "position", Vector2(self.position.x, self.position.y), indicator_velocity)
