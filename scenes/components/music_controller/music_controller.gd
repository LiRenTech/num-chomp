extends Control

@onready var _player = $AudioStreamPlayer

func play(track_url : String):
	var track = load(track_url)
	_player.stream = track
	_player.stream.loop = true
	_player.play()

func stop():
	_player.stop()

func play_home_music():
	stop()
	play("res://assets/music/home.mp3")

func play_game_music():
	stop()
	play("res://assets/music/game.mp3")
