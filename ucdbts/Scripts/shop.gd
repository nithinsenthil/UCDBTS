extends Node2D


var player:Player = interactions.player
var timer: Timer
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


func _check_music():
	if audio_player == null:
		return
	elif !audio_player.playing:
		audio_manager.fade_music_in(audio_player, -5)
	
	timer.start()


func _on_leave_shop_pressed() -> void:
	signals.button_click.emit()
	ResourceManager.next_level()
	SceneManager.load_new_scene("res://Scenes/level_1.tscn", "fade_to_black")


func _on_sell_bikes_pressed() -> void:
	signals.button_click.emit()
	ResourceManager.sell_bikes()
