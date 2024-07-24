extends Node2D

@export var bezeichnung : String = ""
@export var life : int = 0 
@export var baukosten : int = 0

# Setter für bezeichnung
func set_bezeichnung(value):
	bezeichnung = value
	# Hier kannst du zusätzliche Logik hinzufügen

# Getter für bezeichnung
func get_bezeichnung():
	return bezeichnung


# Setter für life
func set_life(value):
	life = value
	# Hier kannst du zusätzliche Logik hinzufügen

# Getter für baukosten
func get_baukosten():
	return baukosten
	
	# Setter für baukosten
func set_baukosten(value):
	baukosten = value
	# Hier kannst du zusätzliche Logik hinzufügen

# Getter für life
func get_life():
	return life

func _ready():
	pass
