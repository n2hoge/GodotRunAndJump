extends Node2D

# カメラの座標関連
const CAMERA_POS_Y = 320	#	カメラの位置(Y)
const CAMERA_OFS_X = 400	#	プレイヤーからのオフセット

@onready var _player = $Player	#	プレイヤー
@onready var _camera = $Camera2D	#	カメラ

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# カメラをプレイヤーに追従させる
	_camera.position.x = _player.position.x + CAMERA_OFS_X
