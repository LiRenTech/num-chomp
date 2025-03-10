extends LevelAbstract
# level2

func _ready() -> void:
	super._ready()
	GENERATE_RATE_PER_TICK = 0.04
	TARGET = 50000

func win_hook():
	print("win")
	pass

func generate_number():
	# 开始设定随机数字
	var current_number = get_player_number()
	var danger_number_rate = 0.95  # 生成在自己周围浮动的概率
	if randf() < danger_number_rate:
		var gen_number = GameNumberGenerate.danger_number_generate(current_number)
		# 危险敌对，直接朝着自己飞来
		var edge_location = GetEdgePosition.get_random_edge_position(20)
		var enemy: EnemyNumber = enemy_number.instantiate()
		enemy.position = edge_location
		add_child(enemy)
		enemy.add_to_group("enemy_group")
		enemy.set_number(gen_number)
		if randf() < 0.5:
			enemy.set_ui_string(
				GameNumberGenerate.get_enemy_number_covered_string_by_plus(gen_number)
			)
		else:
			enemy.set_ui_string(
				GameNumberGenerate.get_enemy_number_covered_string_by_subtract(gen_number)
			)
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
