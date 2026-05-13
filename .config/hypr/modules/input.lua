hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "altgr-intl",
		sensitivity = 0.0,
		accel_profile = "flat",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.4,
		},
	},
	cursor = {
		no_hardware_cursors = 2, -- disable when tearing
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "06cbce44:00-06cb:cf00-touchpad",
	sensitivity = 1,
})
