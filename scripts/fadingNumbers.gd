extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_number(value: int, position: Vector2, not_enough: bool = false, is_positiv: bool = true):
	var number = Label.new()
	number.global_position = position
	if is_positiv:
		number.text = str(value)
	else:
		number.text = "-"+str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	if not_enough:
		color = "#B22"
	if value == 0:
		color = "#FFF8"
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 18
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	call_deferred("add_child", number)
	
	await  number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25
		).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
		).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
		).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
	
func display_text(value: String, position: Vector2, is_warning: bool = false):
	var number = Label.new()
	number.text = value
	number.global_position = position - Vector2(len(value)*5, 0)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	if is_warning:
		color = "#B22"
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 18
	if !is_warning:
		number.label_settings.outline_color = "#000"
	else:
		number.label_settings.outline_color = "#FFF"
	number.label_settings.outline_size = 1
	
	call_deferred("add_child", number)
	
	await  number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 50, 0.25
		).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
		).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
		).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
	
