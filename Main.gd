extends Node2D

const HEX_CELL_SCENE = preload("res://HexCell.tscn")
const GRID_SIZE = Vector2(4, 4)  # Beispielgrößen für ein größeres Spielfeld
const HEX_SIZE = Vector2(120, 120)  # Anpassen an die Größe deines Hex-Bildes

var selected_hex = null

func _ready():
	# Fenstergröße festlegen (optional, falls nicht in Projekteinstellungen gesetzt)
	ProjectSettings.set_setting("display/window/size", Vector2(800, 600))
	
	for y in range(GRID_SIZE.y):
		for x in range(GRID_SIZE.x):
			var hex_cell = HEX_CELL_SCENE.instantiate()
			var position = calculate_hex_position(Vector2(x, y))
			hex_cell.position = position
			add_child(hex_cell)
			print("HexCell gebaut")
			hex_cell.connect("hex_selected", Callable(self, "_on_HexCell_selected"))
	
	# Kamera hinzufügen und Viewport anpassen
	var camera = Camera2D.new()
	add_child(camera)
	camera.make_current()
	camera.zoom = Vector2(1, 1)  # Beispiel: Zoom halbiert die Ansicht


func calculate_hex_position(grid_pos: Vector2) -> Vector2:
	var x = HEX_SIZE.x * grid_pos.x  # Anpassung der horizontalen Position
	var y = HEX_SIZE.y * grid_pos.y  # Anpassung der vertikalen Position
	return Vector2(x, y)

func _on_HexCell_selected(hex_pos):
	print("HexCell selected at position:", hex_pos)
	
	# Verhindere mehrfaches Klicken auf die gleiche Hex-Zelle
	if selected_hex and selected_hex.to_global(selected_hex.position) == hex_pos:
		return
	
	print("Processing selection for new HexCell")
	
	# Verstecke den Bahnhof des zuvor ausgewählten Hex
	if selected_hex:
		var house_node = selected_hex.get_node("Bahnhof")
		if house_node:
			print("Hiding previous Bahnhof")
			house_node.visible = false  # Vorheriges Haus ausblenden

	# Aktualisiere das ausgewählte Hex
	selected_hex = get_hex_cell_at_position(hex_pos)
	if selected_hex:
		print("New HexCell found at position:", selected_hex.global_transform.origin)
		var house_node = selected_hex.get_node("Bahnhof")
		if house_node:
			print("Showing Bahnhof at new HexCell")
			house_node.scale = Vector2(0.1, 0.1)  # Skalierung des Bahnhofs auf 0.1
			house_node.visible = true  # Neues Haus anzeigen
			print("Bahnhof gebaut")



func get_hex_cell_at_position(pos):
	print("Searching for HexCell at position:", pos)
	for child in get_children():
		if child is Node2D and child.global_transform.origin == pos:
			print("HexCell found at position:", pos)
			return child
	print("No HexCell found at position:", pos)
	return null
