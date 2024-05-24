#extends Node2D

#signal hex_selected(hex_pos)

#func _ready():
	#if $Bahnhof:
		$Bahnhof.texture = preload("res://Bahnhof.png")
		$Bahnhof.visible = false

#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Mouse button left pressed in HexCell!")
		# Überprüfen, ob der Klick innerhalb des Hintergrund-Sprites ist
		var local_mouse_pos = self.to_local(event.position)
		print("Local mouse position:", local_mouse_pos)
		var sprite_rect = Rect2(Vector2.ZERO, $Hintergrund.texture.get_size())
		print("Sprite rect:", sprite_rect)
		if sprite_rect.has_point(local_mouse_pos):
			print("Mouse click inside HexCell!")
			var hex_pos = global_transform.origin
			emit_signal("hex_selected", hex_pos)
		else:
			print("Mouse click outside HexCell!")
