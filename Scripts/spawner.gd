extends Node2D

@onready var tilemap: TileMapLayer = $"../TheMainBlocks"
@export var asset_scene: PackedScene
@export var spawn_count := 1

func _ready():
	for i in spawn_count:
		spawn_asset()

func get_random_ground_position() -> Vector2:
	var used_cells := tilemap.get_used_cells()
	used_cells.shuffle()

	for cell in used_cells:
		var above := cell + Vector2i(0, -1)
		if tilemap.get_cell_source_id(cell) != -1 \
		and tilemap.get_cell_source_id(above) == -1:
			return tilemap.map_to_local(above)

	return Vector2.ZERO


func spawn_asset():
	var pos = get_random_ground_position()
	if pos == Vector2.ZERO:
		print("No valid ground found")
		return

	var item = asset_scene.instantiate()
	item.global_position = pos
	add_child(item)

	print("Asset spawned at:", pos)
