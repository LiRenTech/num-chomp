class_name ResultPanel
extends Node2D

@export var title: String = "Default Title"  # 导出标题参数
@export var content: String = "this is content"
var titleLabel: Label
var contentLabel: Label

signal retry_pressed_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	titleLabel = $Title
	contentLabel = $Details
	_update_ui()
	visible = false

func checkout_visible(is_visible: bool):
	visible = is_visible

func _update_ui():
	if !titleLabel:
		print("titleLabel is null")
	else:
		titleLabel.text = title
	if !contentLabel:
		print("contentLabel is null")
	else:
		contentLabel.text = content

func set_content(title_str: String, content_str: String):
	title = title_str
	content = content_str
	_update_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_pressed() -> void:
	retry_pressed_signal.emit()
	queue_free()
