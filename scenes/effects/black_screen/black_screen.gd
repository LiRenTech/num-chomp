extends Node2D

var black: ColorRect
@export var finished = false
@export var time_sec = 4  # s

var cur_sec: float = 0.0

func _ready() -> void:
	black = $Black

func _physics_process(delta: float) -> void:
	cur_sec += delta
	black.color.a = min(1, cur_sec / time_sec)
	if black.color.a == 1:
		finished = true
