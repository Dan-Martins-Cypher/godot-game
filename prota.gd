extends CharacterBody2D

@export var velocidade := 200.0
@export var velocidade_correndo := 350.0
@export var desaceleracao_correndo := 500.0
@export var forca_pulo := 400.0
@export var gravidade := 1000.0

var pulos_disponiveis := 2
var estava_correndo := false


func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += gravidade * delta
	else:
		velocity.y = 0
		pulos_disponiveis = 2


	var direcao := Input.get_axis("ui_left", "ui_right")
	var correndo := Input.is_key_pressed(KEY_SHIFT) and direcao != 0


	if direcao != 0:
		if correndo:
			velocity.x = direcao * velocidade_correndo
		else:
			velocity.x = direcao * velocidade
	else:
		if estava_correndo:
			velocity.x = move_toward(
				velocity.x,
				0,
				desaceleracao_correndo * delta
			)
		else:
			velocity.x = 0

	estava_correndo = correndo


	if Input.is_action_just_pressed("ui_accept") and pulos_disponiveis > 0:
		velocity.y = -forca_pulo
		pulos_disponiveis -= 1


	move_and_slide()
