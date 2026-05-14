hl.window_rule({
	name = "Hyprland polkit agent",
	match = {
		title = "^Hyprland Polkit Agent$",
	},
	stay_focused = true,
})

hl.window_rule({
	name = "XDG desktop portal",
	match = {
		class = "^xdg-desktop-portal-gtk$",
	},
	float = true,
	stay_focused = true,
})

hl.window_rule({
	name = "Pavucontrol",
	match = {
		class = "^org.pulseaudio.pavucontrol$",
	},
	float = true,
	move = { "(monitor_w-710)", 60 },
	pin = true,
	size = { 700, 500 },
})

hl.window_rule({
	name = "Gnome sushi",
	match = {
		class = "^org.gnome.NautilusPreviewer$",
	},
	float = true,
})

hl.window_rule({
	name = "File roller",
	match = {
		class = "^file-roller$",
		title = "^File Operation Progress$",
	},
	float = true,
})

hl.window_rule({
	name = "Viewnior",
	match = {
		class = "^Viewnior$",
	},
	float = true,
})

hl.window_rule({
	name = "IntelliJ IDEA",
	match = {
		class = "^jetbrains-idea$",
		title = "^Welcome to IntelliJ IDEA$",
	},
	float = false,
	tile = true,
})

hl.window_rule({
	name = "Zen",
	match = {
		class = "^zen$",
	},
	workspace = 1,
})

hl.window_rule({
	name = "Zed editor",
	match = {
		class = "^dev.zed.Zed$",
	},
	workspace = 3,
})

hl.window_rule({
	name = "Steam",
	match = {
		class = "^steam$",
	},
	workspace = "4 silent",
})

hl.window_rule({
	name = "Steam - Floating pop-up windows (needs window rule below)",
	match = {
		class = "^steam$",
	},
	float = true,
})

hl.window_rule({
	name = "Steam - Non-floating main window",
	match = {
		class = "^steam$",
		title = "^Steam$",
	},
	float = false,
	tile = true,
})

hl.window_rule({
	name = "Steam - Context menu compatibility",
	match = {
		class = "^steam$",
		title = "^$",
	},
	no_focus = true,
})

hl.window_rule({
	name = "Steam - Friends list",
	match = {
		class = "^steam$",
		title = "^Friends List$",
	},
	move = { "(monitor_w-310)", "(monitor_h-610)" },
	size = { 300, 600 },
})

hl.window_rule({
	name = "Discord",
	match = {
		class = "^discord$",
	},
	workspace = 4,
})

hl.window_rule({
	name = "Discord - Popout view",
	match = {
		class = "^discord$",
		title = "^Discord Popout$",
	},
	float = true,
	keep_aspect_ratio = true,
	move = { "(monitor_w-650)", "(monitor_h-370)" },
	no_initial_focus = true,
	pin = true,
	size = { 640, 360 },
})

hl.window_rule({
	name = "Tidal",
	match = {
		initial_class = "^tidal-hifi$",
	},
	workspace = "5 silent",
})

hl.window_rule({
	name = "Game - Steam proton",
	match = {
		class = "^steam_app.*$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Game - Total War Warhammer 3",
	match = {
		class = "^TotalWarhammer3$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Game - Gamescope",
	match = {
		class = "^gamescope$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Game - CS2",
	match = {
		class = "^cs2$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Game - World of Tanks",
	match = {
		class = "^wgc.exe$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Game - Oxygen Not Included",
	match = {
		class = "^OxygenNotIncluded$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Game - Slay the Spire",
	match = {
		class = "^Slay the Spire$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Game - Slay the Spire 2",
	match = {
		class = "^Slay the Spire 2$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Game - Stardew Valley",
	match = {
		class = "^Stardew Valley$",
	},
	workspace = 9,
})

hl.window_rule({
	name = "Firefox PiP",
	match = {
		title = "^Picture-in-Picture$",
	},
	float = true,
	keep_aspect_ratio = true,
	no_initial_focus = true,
	move = { "(monitor_w-650)", "(monitor_h-370)" },
	pin = true,
	size = { 640, 360 },
})
