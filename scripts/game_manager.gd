extends Node
@onready var goldstand_label = $Goldstand
@onready var timer = $Timer
@onready var uhr_label = $Uhr

var geldbeutel = 0
var clock : int = 0
signal zeit_vergeht


func _ready():
	zeit_vergeht.connect(_on_time_passed)
	
func _on_timer_timeout():
	# Zähler erhöhen und Ausgabe in der Konsole	
	emit_signal("zeit_vergeht")
	print("Timer count: " + str(clock))
	
func _on_time_passed():
	clock += 15
	if clock == 60:
		clock = 0
