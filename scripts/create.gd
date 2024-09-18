extends Node2D

@onready var tile_map = $TileMap
@onready var game_manager = %GameManager

var ground_layer = 0
var schienen_layer = 1
var bahnhof_layer = 2



signal zeit_vergeht

# Referenz zur Schiene-Szene
var Schiene_scene : PackedScene = preload("res://scenes/Schiene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.geldbeutel = 100
	print("Spielstart mit 100 Geld")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_manager.goldstand_label.text = "Gold: " + str(game_manager.geldbeutel)
	game_manager.uhr_label.text = "Uhrzeit: " + str(game_manager.clock)

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
		# Fügt eine Instanz der Schiene-Szene hinzu und zieht die Baukosten ab
		if add_schiene_at_position(tile_mouse_pos, tile_map.map_to_local(tile_mouse_pos)):
			tile_map.set_cell(schienen_layer, tile_mouse_pos, source_id, atlas_coord)
	if Input.is_action_just_pressed("right_click"):
		# Liest Mausposition aus
		var mouse_pos : Vector2 = get_global_mouse_position()
		# Minimiert die Position auf das Tile
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		tile_map.erase_cell(schienen_layer, tile_mouse_pos)

func add_schiene_at_position(tile_position: Vector2i, position: Vector2) -> bool:
	# Instanzieren der Schiene-Szene
	var schiene_instance = Schiene_scene.instantiate()
	# Sicherstellen, dass _ready() aufgerufen wurde
	schiene_instance.call("_ready")	
	# Baukosten der Schiene abrufen
	var baukosten = schiene_instance.get_baukosten()
	
	# Prüfen, ob genügend Geld vorhanden ist
	if game_manager.geldbeutel >= baukosten:
		# Baukosten abziehen
		game_manager.geldbeutel -= baukosten
		FadingNumbers.display_number(baukosten, position, false, false)
		FadingNumbers.display_text(str("Schiene gebaut für ", baukosten, " Geld. Verbleibend: ", game_manager.geldbeutel), position, false)
		
		# Setzen der Position der Instanz
		schiene_instance.position = position
		schiene_instance.tile_map = tile_map  # TileMap-Referenz setzen
		schiene_instance.tile_position = tile_position  # Tile-Position setzen
		# Hinzufügen der Instanz zur Szene
		add_child(schiene_instance)
		return true
	else:
		FadingNumbers.display_text(str("Nicht genügend Geld für Schiene. Benötigt: ", baukosten, ", Verfügbar: ", game_manager.geldbeutel),position, true)
		FadingNumbers.display_number(baukosten, position, true, false)
		return false



	
