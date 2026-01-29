@tool
extends Node2D

const ScoreItem = preload("ScoreItem.tscn")
const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")
var cached_scores: Array = []
var list_index = 0
var ld_name = "main"
var max_scores = 5
var player_name = "hi"
var score = GameManager.score
var ldboard_name = "main"

func _ready():
	pass

func render_board(scores: Array, local_scores: Array) -> void:
	var all_scores: Array = scores

	if ld_name in SilentWolf.Scores.ldboard_config \
	and is_default_leaderboard(SilentWolf.Scores.ldboard_config[ld_name]):
		all_scores = merge_scores_with_local_scores(scores, local_scores, max_scores)

	if all_scores.is_empty():
		add_no_scores_message()
		return

	var count := 0
	for score in all_scores:
		if count >= max_scores:
			break

		add_item(score.player_name, str(int(score.score)))
		count += 1

func is_default_leaderboard(ld_config: Dictionary) -> bool:
	var default_insert_opt = (ld_config.insert_opt == "keep")
	var not_time_based = !("time_based" in ld_config)
	return default_insert_opt and not_time_based

func merge_scores_with_local_scores(scores: Array, local_scores: Array, max_scores: int = 5) -> Array:
	var merged := scores.duplicate(true)

	if local_scores:
		for score in local_scores:
			if !score_in_score_array(merged, score):
				merged.append(score)

	merged.sort_custom(sort_by_score)

	if merged.size() > max_scores:
		merged = merged.slice(0, max_scores)

	return merged



func sort_by_score(a: Dictionary, b: Dictionary) -> bool:
	if a.score > b.score:
		return true;
	else:
		if a.score < b.score:
			return false;
		else:
			return true;


func score_in_score_array(scores: Array, new_score: Dictionary) -> bool:
	var in_score_array =  false
	if !new_score.is_empty() and !scores.is_empty():
		for score in scores:
			if score.score_id == new_score.score_id: 
				in_score_array = true
	return in_score_array


func add_item(player_name: String, score_value: String) -> void:
	var item = ScoreItem.instantiate()
	list_index += 1

	item.get_node("PlayerName").text = str(list_index) + ". " + player_name
	item.get_node("Score").text = score_value
	item.custom_minimum_size = Vector2(500, 0)

	$"Board/HighScores/ScoreItemContainer".add_child(item)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(item, "custom_minimum_size:y", 50, 0.25)


func add_no_scores_message() -> void:
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "No scores yet!"
	$"Board/MessageContainer".show()
	item.offset_top = 135


func add_loading_scores_message() -> void:
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "Loading scores..."
	$"Board/MessageContainer".show()
	item.offset_top = 135


func hide_message() -> void:
	$"Board/MessageContainer".hide()


func clear_leaderboard() -> void:
	var score_item_container = $"Board/HighScores/ScoreItemContainer"
	if score_item_container.get_child_count() > 0:
		var children = score_item_container.get_children()
		for c in children:
			score_item_container.remove_child(c)
			c.queue_free()


func _on_CloseButton_pressed() -> void:
	hide()
	
func refresh():
	clear_leaderboard()
	list_index = 0

	if not cached_scores.is_empty():
		render_board(cached_scores, SilentWolf.Scores.local_scores)
		return

	add_loading_scores_message()
	var sw_result = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	hide_message()

	cached_scores = sw_result.scores
	render_board(cached_scores, SilentWolf.Scores.local_scores)
