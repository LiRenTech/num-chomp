extends Node2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pages/game/level_1/level_1.tscn")


func _on_l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pages/game/level_2/level_2.tscn")
