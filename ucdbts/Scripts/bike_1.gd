extends TextureRect

func _ready():
	self.texture = load("res://Assets/bikes/bike6.png")
	
func _process(delta):
	if ResourceManager.get_num_held_bikes() > 0:
		self.visible = true
	else:
		self.visible = false
