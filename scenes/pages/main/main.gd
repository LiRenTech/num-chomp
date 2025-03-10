extends Node2D


func _ready() -> void:
	MusicController.play_home_music()
	if LevelSystem.current_max_level > 4:
		$AuthorButton.visible = true
	else:
		$AuthorButton.visible = false
