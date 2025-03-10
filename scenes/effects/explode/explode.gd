# explode.tscn 的 Node2D 脚本
extends Node2D

func _ready():
	# 获取粒子节点
	var particles = $GPUParticles2D
	# 连接粒子播放完毕的信号
	particles.finished.connect(_on_particles_finished)
	# 开始播放
	particles.emitting = true

func _on_particles_finished():
	queue_free() # 销毁自身
