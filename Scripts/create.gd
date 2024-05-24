extends Node2D

@onready var tile_map = $TileMap

var ground_layer = 0
var schienen_layer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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

