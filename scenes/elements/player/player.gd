extends CharacterBody2D


@export var number = 0
@export var is_alive = true

func _ready() -> void:
	set_number(5)
	pass

func set_number(n: int):
	number = n
	$Number.text = str(n)

func get_number() -> int:
	return number

func update_ui():
	$Number.text = str(number)

func _physics_process(delta: float) -> void:
	var mouse_screen = get_viewport().get_mouse_position()
	position = mouse_screen


func _on_get_hurt_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_group"):
		var enemy: EnemyNumber = area
		if enemy.number > number:
			is_alive = false
		elif enemy.number < number:
			
			
			# 计算比率
			var rate = float(enemy.number) / number
			play_chomp_sound(rate + 1)
			
			number += enemy.number
			update_ui()
			enemy.die()
	pass # Replace with function body.

func play_chomp_sound(pitch_scale: float):
	$Chomp.pitch_scale = pitch_scale
	$Chomp.play()
	pass
