extends CharacterBody2D

@export var velocidade := 200.0
@export var forca_pulo := 400.0
@export var gravidade := 1000.0

var pulos_disponiveis := 2

func _physics_process(delta):


	if not is_on_floor():
		velocity.y += gravidade * delta
	else:
		pulos_disponiveis = 2

	var esquerda_direita := Input.get_axis("ui_right", "ui_left")

	velocity.x = esquerda_direita * velocidade

	# Pulo
	if Input.is_action_just_pressed("ui_up") and pulos_disponiveis > 0:
		velocity.y = -forca_pulo
		pulos_disponiveis -= 1

	move_and_slide()
