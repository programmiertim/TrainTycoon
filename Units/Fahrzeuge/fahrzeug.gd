extends Node

var bezeichnung : String = ""
var tank : int = 0 
var life : int = 0 

# Setter für bezeichnung
func set_bezeichnung(value):
	bezeichnung = value
	# Hier kannst du zusätzliche Logik hinzufügen

# Getter für bezeichnung
func get_bezeichnung():
	return bezeichnung

# Setter für tank
func set_tank(value):
	tank = value
	# Hier kannst du zusätzliche Logik hinzufügen

# Getter für tank
func get_tank():
	return tank

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
	set_tank(100)
	set_life(100)
	
	print("Bezeichnung: ", get_bezeichnung())
	print("Tank: ", get_tank())
	print("Lebenspunkte: ", get_life())
