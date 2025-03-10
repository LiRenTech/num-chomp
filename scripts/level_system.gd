extends Node2D
# 存储关卡的系统

@export var current_max_level = 1
"""当前用户可以选择的最大关卡数"""

func player_win_level(level: int):
	"""用户过关了某个关卡"""
	current_max_level = max(level + 1, current_max_level)
