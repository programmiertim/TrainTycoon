extends "res://Units/Gebäude/gebäude.gd"

func _ready():
	set_bezeichnung("Schiene")
	set_life(5)
	set_baukosten(2)

func _connect(create_instance):
	# Verbinde das Signal "zeit_vergeht" von der create_instance mit der Funktion "_on_timer_timeout"
	create_instance.connect("zeit_vergeht", Callable(self, "_on_timer_timeout"))

# Funktion, die aufgerufen wird, wenn das Timer-Timeout-Signal empfangen wird
func _on_timer_timeout():
	# Generiere eine Zufallszahl zwischen 0 und 50
	var random_number = randi() % 51
	print(random_number)
	
	# Wenn die Zufallszahl zwischen 0 und 10 liegt, ziehe 1 vom Leben ab
	if random_number <= 10:
		var current_life = get_life()
		if current_life > 0:
			set_life(current_life - 1)
			print("Leben abgezogen. Neues Leben:", get_life())
		else:
			print("Das Gebäude hat kein Leben mehr und kann nicht weiter reduziert werden.")
