extends Node2D

const HEX_CELL_SCENE = preload("res://HexCell.tscn")
const GRID_SIZE = Vector2(4, 4)
const HEX_SIZE = Vector2(64, 64)  # Anpassen an die Größe deines Hex-Bildes

func _ready():
	for y in range(GRID_SIZE.y):
		for x in range(GRID_SIZE.x):
			var hex_cell = HEX_CELL_SCENE.instantiate()
			var position = calculate_hex_position(Vector2(x, y))
			hex_cell.position = position
			add_child(hex_cell)

	# Debug-Ausgabe der Position der ersten Hex-Zelle
	var first_hex_position = calculate_hex_position(Vector2(0, 0))
	print("First Hex Position: ", first_hex_position)
	
	# Kamera hinzufügen, um sicherzustellen, dass alles sichtbar ist
	var camera = Camera2D.new()
	add_child(camera)
	camera.make_current()

func calculate_hex_position(grid_pos: Vector2) -> Vector2:
	var x = HEX_SIZE.x * grid_pos.x * 1.86  # Anpassung der horizontalen Position
	var y = HEX_SIZE.y * grid_pos.y * 2.86  # Anpassung der vertikalen Position
	return Vector2(x, y)
