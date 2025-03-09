class_name EnemyNumber
extends Area2D

@export var velocity = Vector2.ZERO
@export var number = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_number(n: int):
	number = n
	$VisibleNumber.text = str(n)

func set_ui_string(string: String):
	$VisibleNumber.text = string

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
