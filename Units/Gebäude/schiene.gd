extends "res://Units/Gebäude/gebäude.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_bezeichnung("Schiene")
	set_life(5)
	print("Ich bin eine Schiene!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
