extends Node2D

var enemy_number = preload("res://scenes/elements/enemy_number/enemy_number.tscn")
const TARGET = 50000

func _ready() -> void:
	$Player.position = $CenterLocation.position
	$GameOver.visible = false
	$Win.visible = false
	$Player.visible = true
	pass


func _physics_process(delta: float) -> void:
	if $Player.is_alive:
		if $Player.get_number() > TARGET:
			# 赢了
			$Win.visible = true
			$Player.visible = false
			var enemies = get_tree().get_nodes_in_group("enemy_group")
			for enemy in enemies:
				enemy.queue_free()
		else:
			# 还没赢
			if randf() < 0.1:
				generate_number()
	else:
		# 游戏结束了
		$GameOver.visible = true
		$Player.visible = false
		var enemies = get_tree().get_nodes_in_group("enemy_group")
		for enemy in enemies:
			enemy.queue_free()
		pass
	pass

func get_player_number():
	return $Player.get_number()

func generate_number():
	# 开始设定随机数字
	var current_number = get_player_number()
	var danger_number_rate = 0.9  # 生成在自己周围浮动的概率
	if randf() < danger_number_rate:
		var gen_number = GameNumberGenerate.danger_number_generate(current_number)
		# 危险敌对，直接朝着自己飞来
		var edge_location = GetEdgePosition.get_random_edge_position(20)
		var enemy: EnemyNumber = enemy_number.instantiate()
		enemy.position = edge_location
		add_child(enemy)
		enemy.add_to_group("enemy_group")
		enemy.set_number(gen_number)
		enemy.velocity = ($Player.position - enemy.position).normalized() * randf_range(10, 60)
	else:
		# 渺小食物，水平移动
		var edge_location = GetEdgePosition.get_random_left_edge_position(20)
		var enemy: EnemyNumber = enemy_number.instantiate()
		enemy.position = edge_location
		add_child(enemy)
		enemy.add_to_group("enemy_group")
		enemy.set_number(1)
		enemy.velocity = Vector2.RIGHT * randf_range(100, 500);
	pass


func _on_back_to_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pages/main/main.tscn")
	pass # Replace with function body.
