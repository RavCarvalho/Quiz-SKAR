extends Node2D

func _ready() -> void:
	audio.returnSong()

func _on_fechar_pressed() -> void:
	 get_tree().quit()


func _on_iniciar_pressed() -> void:
	get_tree().change_scene("res://Cenas/Information.tscn")


func _on_tutorial_pressed() -> void:
	get_tree().change_scene("res://Cenas/Tutorial.tscn")
