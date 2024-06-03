extends CanvasLayer
onready var transition = get_node("Fill")
onready var animacao = get_node("Fill/animation")
onready var kill: Timer = get_node("ToKill")

export (int ,"Pixel","Spot Player", "Spot centro", "Corte vertical", "corte horizontal" ) var transition_type
export (float, 2.0) var duration = 1.0;

## Modos da transição
var transitioStatus: Array = ["transition_in", "transition_out"]
var timeToKill = 1.0


func _ready():
	transition.material.set_shader_param("type", transition_type)
	duration = animacao.playback_speed
	kill.start(timeToKill)


# Inexecutável por enquanto
#func playTransition(status, timer):
#	animacao.play(status)
#	kill.start(timer)
#
	


func _on_ToKill_timeout() -> void:
	self.queue_free()
