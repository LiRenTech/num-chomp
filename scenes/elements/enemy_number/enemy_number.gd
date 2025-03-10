class_name EnemyNumber
extends Area2D

@export var velocity = Vector2.ZERO
@export var number = 0

# 白色底色最大就是（20/255）
# 字体最浅不能超过阈值

func _ready() -> void:
	pass # Replace with function body.

func set_number(n: int):
	number = n
	$VisibleNumber.text = str(n)

func set_ui_string(string: String):
	$VisibleNumber.text = string

func update_alpha(number: float):
	$ColorRect.color.a = number

func _physics_process(delta: float) -> void:
	position += velocity * delta
	pass

func die():
	queue_free()
	pass

func _on_body_entered(body: Node2D) -> void:
	#print(body)
	if body.is_in_group("wall_group"):
		queue_free()
	pass # Replace with function body.
