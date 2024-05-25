extends Node

# Variablen für Timer und Zähler
var timer : Timer
var count : int = 0

func _ready():
	# Timer erstellen und konfigurieren
	timer = Timer.new()
	timer.wait_time = 3.0
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	
	# Timer starten
	timer.start()

func _on_Timer_timeout():
	# Zähler erhöhen und Ausgabe in der Konsole
	count += 1
	print("Timer count: ", count)
