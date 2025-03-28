extends LevelAbstract
var black_screen_effect_scene = preload("res://scenes/effects/black_screen/black_screen.tscn")


func _ready() -> void:
	super._ready()
	GENERATE_RATE_PER_TICK = 0.03
	TARGET = 50000

var end_black_screen

func win_hook():
	LevelSystem.player_win_level(4)
	
	end_black_screen = black_screen_effect_scene.instantiate()
	add_child(end_black_screen)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	# 潮汐
	var t = float(Time.get_ticks_msec()) / (1000 * 20)
	GENERATE_RATE_PER_TICK = min(sin(t) ** 1000 + 0.03, 1)
	$ColorRect.color.a = GENERATE_RATE_PER_TICK
	# 通关动画
	if end_black_screen:
		if end_black_screen.finished:
			get_tree().change_scene_to_file("res://scenes/pages/author/author.tscn")

func generate_number():
	# 开始设定随机数字
	var current_number = get_player_number()
	var danger_number_rate = 0.98  # 生成在自己周围浮动的概率
	if randf() < danger_number_rate:
		var gen_number = GameNumberGenerate.danger_number_generate(current_number)
		# 危险敌对，直接朝着自己飞来
		var edge_location = GetEdgePosition.get_random_edge_position(20)
		var enemy: EnemyNumber = enemy_number.instantiate()
		enemy.position = edge_location
		add_child(enemy)
		enemy.add_to_group("enemy_group")
		enemy.set_number(gen_number)
		if randf() < 0.8:
			enemy.set_ui_string(
				GameNumberGenerate.get_enemy_number_covered_string_by_div(gen_number)
			)
		else:
			if randf() < 0.8:
				enemy.set_ui_string(
					GameNumberGenerate.get_enemy_number_covered_string_by_times(gen_number)
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
		enemy.velocity = Vector2.RIGHT * randf_range(200, 500);
	pass
