extends Node2D

@onready var tile_map = $TileMap

var ground_layer = 0
var schienen_layer = 1
var bahnhof_layer = 2

var timer : Timer
var count : int = 0

var geldbeutel : int = 0

signal zeit_vergeht

# Referenz zur Schiene-Szene
var Schiene_scene : PackedScene = preload("res://Szenen/Schiene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_Timer()
	geldbeutel = 100
	print("Spielstart mit 100 Geld")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("click"):
		# Liest Mausposition aus
		var mouse_pos : Vector2 = get_global_mouse_position()
		# Minimiert die Position auf das Tile
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		# Liest das TileFile mit der ID
		var source_id : int = 2
		# Pickt das Tile in Position aus
		var atlas_coord : Vector2i = Vector2i(19, 1)
		
		tile_map.set_cell(schienen_layer, tile_mouse_pos, source_id, atlas_coord)
		
		# Fügt eine Instanz der Schiene-Szene hinzu und zieht die Baukosten ab
		add_schiene_at_position(tile_map.map_to_local(tile_mouse_pos))
	
	if Input.is_action_just_pressed("right_click"):
		# Liest Mausposition aus
		var mouse_pos : Vector2 = get_global_mouse_position()
		# Minimiert die Position auf das Tile
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		
		tile_map.erase_cell(schienen_layer, tile_mouse_pos)

func add_schiene_at_position(position: Vector2):
	# Instanzieren der Schiene-Szene
	var schiene_instance = Schiene_scene.instantiate()
	
	# Sicherstellen, dass _ready() aufgerufen wurde
	schiene_instance.call("_ready")
	
	# Baukosten der Schiene abrufen
	var baukosten = schiene_instance.get_baukosten()
	
	# Prüfen, ob genügend Geld vorhanden ist
	if geldbeutel >= baukosten:
		# Baukosten abziehen
		geldbeutel -= baukosten
		print("Schiene gebaut für ", baukosten, " Geld. Verbleibend: ", geldbeutel)
		
		# Setzen der Position der Instanz
		schiene_instance.position = position
		# Hinzufügen der Instanz zur Szene
		add_child(schiene_instance)
		# Verbindung zum Signal herstellen und die create-Instanz übergeben
		schiene_instance._connect(self)
	else:
		print("Nicht genügend Geld für Schiene. Benötigt: ", baukosten, ", Verfügbar: ", geldbeutel)

func _on_Timer_timeout():
	# Zähler erhöhen und Ausgabe in der Konsole
	count += 1
	print("Timer count: ", count)
	emit_signal("zeit_vergeht")
	
func _init_Timer():
	# Timer erstellen und konfigurieren
	timer = Timer.new()
	timer.wait_time = 3.0
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	
	# Timer starten
	timer.start()
