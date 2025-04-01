extends ItemContainer

func hit():
	$LidSprite.hide()
	var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
	for i in range(5):
		open.emit(pos, current_direction)
