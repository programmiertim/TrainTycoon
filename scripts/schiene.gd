extends Node2D

# Referenz zur TileMap (muss beim Hinzufügen gesetzt werden)
var tile_map : TileMap
const MAIN = preload("res://scenes/Main.tscn")
const SCHIENE = preload("res://scenes/Schiene.tscn")
# Die Position des Tiles in der TileMap
var tile_position : Vector2i

func _ready():
	pass


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
			# Wenn das Leben 0 erreicht, entferne den Layer
			if get_life() == 0:
				remove_schiene()
		else:
			print("Das Gebäude hat kein Leben mehr und kann nicht weiter reduziert werden.")

# Funktion zum Entfernen der Schiene
func remove_schiene():
	print("Leben ist 0. Schiene wird entfernt.")
	if tile_map:
		tile_map.set_cell(1, tile_position, -1)  # Entfernt das Tile
	queue_free()  # Entfernt die Schiene-Instanz
