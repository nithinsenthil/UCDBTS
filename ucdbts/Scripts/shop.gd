extends Node2D

var player:Player = interactions.player
var timer: Timer
var first_item:Item
var second_item:Item
@onready var first_item_display:TextureRect = $FirstItemDisplay
@onready var second_item_display:TextureRect = $SecondItemDisplay
@onready var first_item_label:Label = $FirstItemLabel
@onready var second_item_label:Label = $SecondItemLabel
@onready var audio_manager: AudioManager = $AudioManager
@onready var audio_player: AudioStreamPlayer2D = $AudioManager/Background/Shop


func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.1
	timer.one_shot = true
	timer.timeout.connect(_check_music)
	add_child(timer)
	timer.start()
	audio_player.playing = false
	generate_items()
	if ResourceManager.has_celsius:
		ResourceManager.remove_celius()



func _check_music():
	if audio_player == null:
		return
	elif !audio_player.playing:
		audio_manager.fade_music_in(audio_player, -5)
	
	timer.start()


func generate_items() -> void:
	var one:PackedScene = ResourceManager.items_list.pick_random()
	var two:PackedScene = ResourceManager.items_list.pick_random()
	
	while one == two:
		two = ResourceManager.items_list.pick_random()
	first_item = one.instantiate() as Item
	second_item = two.instantiate() as Item
	add_child(first_item)
	add_child(second_item)
	first_item_display.texture = load(first_item.texture_path)
	second_item_display.texture = load(second_item.texture_path)
	first_item_label.text = "%s\n$%d" % [first_item.item_name, first_item.value]
	second_item_label.text = "%s\n$%d" % [second_item.item_name, second_item.value]
	$HeldItemsValue.text = "$%d" % ResourceManager.get_pocket_value()


func _on_leave_shop_pressed() -> void:
	signals.button_click.emit()
	ResourceManager.next_level()
	SceneManager.load_new_scene("res://Scenes/level_1.tscn", "fade_to_black")


func _on_sell_bikes_pressed() -> void:
	signals.button_click.emit()
	ResourceManager.sell_bikes()
	$HeldItemsValue.text = "$%d" % ResourceManager.get_pocket_value()


func _on_buy_1_pressed() -> void:
	signals.button_click.emit()
	if ResourceManager.buy_item(first_item):
		first_item_display.visible = false
		first_item_label.visible = false
		$Buy1.visible = false


func _on_buy_2_pressed() -> void:
	signals.button_click.emit()
	if ResourceManager.buy_item(second_item):
		second_item_display.visible = false
		second_item_label.visible = false
		$Buy2.visible = false
