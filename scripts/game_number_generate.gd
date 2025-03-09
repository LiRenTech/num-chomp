extends Node

func danger_number_generate(current_number: int) -> int:
	var big_list = []
	for i in range(10):
		big_list.append(current_number * 2 ** i + 2 ** i)
	
	big_list.append(current_number - 3)
	return big_list.pick_random()
