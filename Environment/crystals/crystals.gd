extends Spatial

# Define the crystal mesh
onready var crystal_mesh = $crystals

# Variables for color and luminosity animation
var hue_value = 0.0
var hue_speed = 0.1  # Adjust this value to control the speed of color change
var luminosity_value = 0.5
var luminosity_speed = 0.1  # Adjust this value to control the speed of luminosity change
var delta = 0.07

func _on_Timer_timeout():
	# Update the hue value
	hue_value += hue_speed * delta

	# Ensure the hue value stays within the valid range (0.0 to 1.0)
	if hue_value > 1.0:
		hue_value -= 1.0

	# Update the luminosity value
	luminosity_value += luminosity_speed * delta

	# Ensure the luminosity value stays within the valid range (0.0 to 1.0)
	luminosity_value = clamp(luminosity_value, 0.0, 1.0)

	# Calculate the RGB color based on the current hue and luminosity values
	var color = Color.from_hsv(hue_value, 1.0, luminosity_value)

	# Apply the color to the crystal mesh
	crystal_mesh.material_override.albedo_color = color
	
