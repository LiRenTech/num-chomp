extends Node2D


func _ready() -> void:
	if LevelSystem.current_max_level < 2:
		$L2.disabled = true
	if LevelSystem.current_max_level < 3:
		$L3.disabled = true
	if LevelSystem.current_max_level < 4:
		$L4.disabled = true
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_l_1_pressed() -> void:
	MusicController.play_game_music()
	get_tree().change_scene_to_file("res://scenes/pages/game/level_1/level_1.tscn")


func _on_l_2_pressed() -> void:
	MusicController.play_game_music()
	get_tree().change_scene_to_file("res://scenes/pages/game/level_2/level_2.tscn")


func _on_l_3_pressed() -> void:
	MusicController.play_game_music()
	get_tree().change_scene_to_file("res://scenes/pages/game/level_3/level_3.tscn")


func _on_l_4_pressed() -> void:
	MusicController.play_game_music()
	get_tree().change_scene_to_file("res://scenes/pages/game/level_4/level_4.tscn")


func _on_back_to_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pages/main/main.tscn")
