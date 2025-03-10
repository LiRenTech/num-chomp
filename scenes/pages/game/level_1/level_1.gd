extends LevelAbstract
# level1

func _ready() -> void:
	super._ready()
	TARGET = 50000

func win_hook():
	print("win")
	pass
