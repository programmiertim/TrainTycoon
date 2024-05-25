extends Node

var bezeichnung : String = ""
var life : int = 0 

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

# Getter für tank
func get_life():
	return life

func _ready():
	# Initialisieren oder andere Setup-Operationen durchführen
	set_bezeichnung("Initiale Bezeichnung")
	set_life(100)
	
	print("Bezeichnung: ", get_bezeichnung())
	print("Lebenspunkte: ", get_life())
