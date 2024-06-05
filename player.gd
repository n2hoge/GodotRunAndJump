extends CharacterBody2D

const ANIM_SPEED = 7			# アニメーション速度
const GRAVITY = 45				# 重力
const JUMP_POWER = 1000			# ジャンプ力
const MOVE_SPEED = 300			# 移動速度
const MAX_JUMP_CNT = 2			# 2段ジャンプまで可能

@onready var _spr = $Player		# スプライト

var _tAnim:float = 0			# アニメーションタイマー
var _is_jumping = false			# ジャンプ中フラグ
var _cnt_jump = 0				# ジャンプ回数
var _speed := MOVE_SPEED		# 移動速度

# 更新
func _process(delta:float) -> void:
	# アニメーションの更新
	_update_anim(delta)
	
func _update_anim(delta:float) -> void:
	_tAnim += delta
	
	if _is_jumping:
		# ジャンプ中
		_spr.frame = 2
		return
	
	var t = int(_tAnim * ANIM_SPEED) % 2
	var tbl = [2, 3] 			# 走りアニメーションのみ使う
	_spr.frame = tbl[t]

# 重力とジャンプ処理
func _physics_process(delta: float) -> void:
	
	#重力を反映
	velocity.y += GRAVITY
	
	if is_on_floor():
		# 着地した
		_is_jumping = false
		velocity.y = 0 			# 重力クリア
		_cnt_jump = 0			# ジャンプ回数をリセット
	else:
		# ジャンプ中
		_is_jumping = true
	
	if _cnt_jump < MAX_JUMP_CNT:
		if Input.is_action_just_pressed("ui_accept"):
			# ジャンプ
			velocity.y = -JUMP_POWER
			_cnt_jump += 1
		
	move_and_slide()
