extends Node


func get_random_edge_position(margin: int = 0) -> Vector2:
	# 设置生成位置在屏幕外的随机边缘
	var viewport_rect = get_viewport().get_visible_rect()
	var edge = randi() % 4  # 随机选择四个边
	
	var spawn_pos = Vector2()
	match edge:
		0: # 左边缘
			spawn_pos = Vector2(-margin, randf_range(margin, viewport_rect.size.y - margin))
		1: # 右边缘
			spawn_pos = Vector2(viewport_rect.size.x + margin, randf_range(margin, viewport_rect.size.y - margin))
		2: # 上边缘
			spawn_pos = Vector2(randf_range(margin, viewport_rect.size.x - margin), -margin)
		3: # 下边缘
			spawn_pos = Vector2(randf_range(margin, viewport_rect.size.x - margin), viewport_rect.size.y + margin)
	return spawn_pos


func get_random_left_edge_position(margin: int = 0) -> Vector2:
	var viewport_rect = get_viewport().get_visible_rect()
	return Vector2(-margin, randf_range(margin, viewport_rect.size.y - margin))
