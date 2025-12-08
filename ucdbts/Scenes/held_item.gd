extends TextureRect

func _ready():
	var item = ResourceManager.get_held_item()
	if item:
		print("item: " + item.item_name)
		print("loading texture " + item.icon_path + " vs " + item.texture_path)
		texture = load(item.icon_path)
		print("file_exists: ", FileAccess.file_exists(item.icon_path))
	else:
		print("no item")
		
	
	
func _process(delta):
	#print(texture)
	pass
