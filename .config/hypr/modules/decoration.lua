hl.config({
	decoration = {
		rounding = 14,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		fullscreen_opacity = 1.0,

		blur = {
			enabled = false,
			size = 6,
			passes = 1,
			ignore_opacity = true,
			new_optimizations = true,
			xray = false,
			noise = 0.04,
		},

		shadow = {
			enabled = true,
			range = 14,
			render_power = 2,
			color = "0x8c1a1a1a"
		},
	},
})
