class_name AudioManager
extends Node2D

const mute_db := -80.0 # To mute the audio player
const default_music_db := 0.0 # This is for normal volume
const fade_time := 2.0 # The time it takes to fade in/out in seconds

var current_music_player : AudioStreamPlayer2D # the current player
var steal_track: AudioStreamPlayer2D

func _ready() -> void:
	signals.player_step.connect(_on_player_step)
	signals.button_click.connect(_on_button_click)
	signals.start_stealing.connect(_on_start_stealing)
	signals.stop_stealing.connect(_on_stop_stealing)

	current_music_player = $Background/TitleScreen


func fade_music_in(track: AudioStreamPlayer2D, default_db: float) -> void:
	current_music_player = track # Specify the song
	current_music_player.volume_db = mute_db # Mute the player
	current_music_player.play() # Start playing
	# Use tweens for transition:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(current_music_player, "volume_db", default_db, fade_time)


func fade_music_out() -> void:
	if current_music_player != null:
		print("EASING OUT")
		var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
		tween.tween_property(current_music_player, "volume_db", mute_db, fade_time)

func fade_affect_in(track: AudioStreamPlayer2D, default_db: float) -> void:
	track.volume_db = mute_db # Mute the player
	track.play() # Start playing
	# Use tweens for transition:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(track, "volume_db", default_db, fade_time)


func fade_affect_out(track: AudioStreamPlayer2D) -> void:
	if track != null:
		print("EASING OUT")
		var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
		tween.tween_property(track, "volume_db", mute_db, fade_time)



func _on_player_step():
	$Player/PlayerStep.play()

func _on_button_click():
	$Effects/MenuButtonClick.play()

func _on_start_stealing():
	print("Start steal")
	var item = ResourceManager.get_held_item()
	steal_track = $Theft/Default
	if item == null:
		steal_track.play()
		return
	var item_name = item.get_item_name()
	match item_name:
		"Chainsaw":
			steal_track = $Theft/Chainsaw
		"Bolt Cutters":
			steal_track = $Theft/BoltCutters
		"Lockpick":
			steal_track = $Theft/Lockpick
	# fade_affect_in(steal_track, -10)
	steal_track.play()
		

func _on_stop_stealing(stolen: bool):
	print("End steal")
	if steal_track == null:
		return
	steal_track.stop()
	if stolen:
		$Theft/BrokenLock.play()
