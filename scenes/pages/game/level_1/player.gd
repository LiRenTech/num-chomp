extends CharacterBody2D


const SPEED = 500.0

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
	#if Input.get_action_strength("w"):
		#velocity = Vector2.UP * SPEED * delta
	#elif Input.get_action_strength("s"):
		#velocity = Vector2.DOWN * SPEED * delta
	#elif Input.get_action_strength("a"):
		#velocity = Vector2.LEFT * SPEED * delta
	#elif Input.get_action_strength("d"):
		#velocity = Vector2.RIGHT * SPEED * delta
	#move_and_slide()


func _on_get_hurt_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_group"):
		var enemy: EnemyNumber = area
		if enemy.number > number:
			is_alive = false
			#enemy.die()
		elif enemy.number < number:
			number += enemy.number
			update_ui()
			enemy.die()
	pass # Replace with function body.
