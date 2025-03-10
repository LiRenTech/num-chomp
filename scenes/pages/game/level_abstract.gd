class_name LevelAbstract
extends Node2D


var enemy_number = preload("res://scenes/elements/enemy_number/enemy_number.tscn")
var result_panel_scene = preload("res://scenes/components/result_panel/result_panel.tscn")
var win_result_panel: ResultPanel
var fail_result_panel: ResultPanel

@export var TARGET = 50000
@export var GENERATE_RATE_PER_TICK = 0.1
enum GameState {
	playing,
	win,
	louse
}

var game_state = GameState.playing
var last_tick_game_state = GameState.playing

func check_game_state():
	last_tick_game_state = game_state
	if $Player.is_alive:
		if $Player.get_number() > TARGET:
			game_state = GameState.win
		else:
			game_state = GameState.playing
	else:
		game_state = GameState.louse

func _ready() -> void:
	win_result_panel = result_panel_scene.instantiate()
	win_result_panel.set_content("you win!", "celebrate!")
	win_result_panel.retry_pressed_signal.connect(_on_back_to_home_button_pressed)
	add_child(win_result_panel)
	
	fail_result_panel = result_panel_scene.instantiate()
	fail_result_panel.set_content("you lose", "you lose the game")
	fail_result_panel.retry_pressed_signal.connect(_on_back_to_home_button_pressed)
	add_child(fail_result_panel)
	
	$Player.position = $CenterLocation.position
	$Player.visible = true
	$Player.set_number(5)

func _process(delta: float) -> void:
	# 每一个块跟随鼠标距离远近而变化
	var R = 200
	var mouse_world = get_global_mouse_position()
	for enemy in get_tree().get_nodes_in_group("enemy_group"):
		var dis = (enemy.position - mouse_world).length()
		enemy.update_alpha(max(-(0.2 / R) * dis + 0.2, 0))

func _physics_process(delta: float) -> void:
	check_game_state()
	if game_state == GameState.win and last_tick_game_state == GameState.playing:
		# 赢了
		win_result_panel.checkout_visible(true)
		clear_enemy()
		win_hook()
	elif game_state == GameState.playing:
		if randf() < GENERATE_RATE_PER_TICK:
			generate_number()
	elif game_state == GameState.louse and last_tick_game_state == GameState.playing:
		
		fail_result_panel.checkout_visible(true)
		$Player.visible = false
		clear_enemy()


func win_hook():
	pass

func clear_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy_group")
	for enemy in enemies:
		enemy.queue_free()

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
