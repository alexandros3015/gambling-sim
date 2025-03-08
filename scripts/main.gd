extends Panel

var balance: int = 100
var streak: int = 0

enum {
	HEADS,
	TAILS
}

var choice = HEADS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$betting.hide()
	$confirm.hide()


func proceed() -> void:
	
	$heads.hide()
	$tails.hide()
	
	$betting.show()
	$confirm.show()
	
	$info.text = "How much to bet?"
	

func disable() -> void:
	$heads.disabled = true
	$tails.disabled = true
	$confirm.disabled = true
	
func enable() -> void:
	$heads.disabled = false
	$tails.disabled = false
	$confirm.disabled = false

func reset() -> void:
	$heads.show()
	$tails.show()
	
	$betting.hide()
	$confirm.hide()
	
	$info.text = "Hello! Heads or tails?"
	streak += 1
	
	$money.text = "Balance: $" + str(balance)
	$streak.text = "Streak: " + str(streak)

	enable()
	
	if balance <= 0:
		$info.text = "You lose"
		disable()

func _on_heads_pressed() -> void:
	choice = HEADS
	proceed()


func _on_tails_pressed() -> void:
	choice = TAILS
	proceed()


func _on_confirm_pressed() -> void:
	disable()
	var number = $betting.value
	
	if number > balance:
		$info.text = "Can't bet more than you have"
		return
		
	var random_number = randi_range(0, 1)
	
	if choice == random_number:
		$info.text = "Congratulations!"
		balance += number
	else:
		$info.text = "You lost"
		balance -= number
	
	await get_tree().create_timer(2, false).timeout
	
	reset()
