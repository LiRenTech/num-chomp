extends Node2D

var content: Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	content = $Content	
	$BackButton.visible = false
	MusicController.play_end_music()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#content.position.y -= 20 * delta
	pass

func _physics_process(delta: float) -> void:
	content.position.y -= 20 * delta
	if content.offset_bottom < 1000:
		$BackButton.visible = true
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pages/main/main.tscn")
	pass # Replace with function body.
