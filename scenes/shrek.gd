extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var animation_sequence = [
	"Thriller_idle",
	"Thriller_part_1",
	"Thriller_part_2",
	"Thriller_part_3",
	"Thriller_part_4"
]
var current_animation_index = 0

func _ready():
	play_next_animation()

func play_next_animation():
	if current_animation_index < animation_sequence.size():
		var anim_name = animation_sequence[current_animation_index]
		if animation_player.has_animation(anim_name):
			# Get the animation length
			var anim_length = animation_player.get_animation(anim_name).length
			# Stop any current animation and play the new one
			animation_player.stop()
			animation_player.play(anim_name)
			# Set up a timer for the next animation
			get_tree().create_timer(anim_length).timeout.connect(
				func():
					current_animation_index += 1
					play_next_animation()
			)
		else:
			current_animation_index += 1
			play_next_animation()
	else:
		# Reset to beginning when all animations are done
		current_animation_index = 0
		play_next_animation()

# Optional: Function to restart the sequence from the beginning
func restart_sequence():
	current_animation_index = 0
	animation_player.stop()
	play_next_animation()

# Optional: Function to stop the sequence
func stop_sequence():
	animation_player.stop()
	current_animation_index = 0
