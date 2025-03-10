extends Node

func danger_number_generate(current_number: int) -> int:
	"""
	根据主角当前的数字，生成一个即将进来的敌人
	大概率都是比自己大的，而且是成指数状态比自己大的，这是因为防止出现：
	很快的吃掉周围的数字进而极速数值膨胀，短时间内吃掉屏幕上一切数字
	"""
	var big_list = []
	for i in range(10):
		big_list.append(current_number * 2 ** i + 2 ** i)
	
	big_list.append(current_number - 3)
	return big_list.pick_random()

func get_enemy_number_covered_string_by_plus(enemy_number: int) -> String:
	"""
	通过加法形式的字符串来伪装原始数字
	"""
	var a = randi_range(0, enemy_number)
	var b = enemy_number - a
	return str(a) + "+" + str(b)

func get_enemy_number_covered_string_by_subtract(enemy_number: int) -> String:
	"""
	通过减法形式的字符串来伪装原始数字
	"""
	# 比自己大2~10被的数字
	var a = randi_range(enemy_number * 2, enemy_number * 10)
	var b = a - enemy_number
	return str(a) + "-" + str(b)
