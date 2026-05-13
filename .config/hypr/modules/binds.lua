local appMenu = "rofi -show drun -run-command 'uwsm app -- {cmd}'"
local emojiMenu = "rofi -show emoji -emoji-format '{emoji}' -config ~/.config/rofi/emoji.rasi"
local clipboardMenu = "rofi -show clipboard -config ~/.config/rofi/clipboard.rasi"

-- Application/cmd binds
hl.bind("SUPER + D", LAUNCHAPP(appMenu))
hl.bind("SUPER + V", LAUNCHAPP(clipboardMenu))
hl.bind("SUPER + period", LAUNCHAPP(emojiMenu))

hl.bind("SUPER + RETURN", LAUNCHAPP(TERMINAL))
hl.bind("SUPER + E", LAUNCHAPP(FILE_BROWSER))
hl.bind("SUPER + B", LAUNCHAPP(BROWSER))
hl.bind("SUPER + C", LAUNCHAPP(EDITOR))
hl.bind("SUPER + T", LAUNCHAPP("ticktick"))
hl.bind("SUPER + Y", LAUNCHAPP("obsidian"))
hl.bind("SUPER + N", LAUNCHAPP("hyprlock"))
hl.bind("SUPER + W", RUNCMD("systemctl --user reload waybar"))

hl.bind("SUPER + S", RUNCMD("grimblast --notify copysave area"))
hl.bind("SUPER + SHIFT + S", RUNCMD("grimblast --notify copysave active"))
hl.bind("SUPER + CTRL + S", RUNCMD("grimblast --notify copysave screen"))

hl.bind("SUPER + X", RUNCMD("hyprpicker -f hex --autocopy"))
hl.bind("SUPER + SHIFT + X", RUNCMD("hyprpicker -f rgb --autocopy"))

-- Workspace binds
for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + bracketleft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + bracketright", hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Window binds
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SPACE", hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + I", hl.dsp.layout("togglesplit"))

hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + J", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + K", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Function key binds
hl.bind("XF86MonBrightnessUp", RUNCMD("swayosd-client --brightness +5"), { repeating = true })
hl.bind("XF86MonBrightnessDown", RUNCMD("swayosd-client --brightness -5"), { repeating = true })

hl.bind("XF86AudioMute", RUNCMD("swayosd-client --output-volume mute-toggle"))
hl.bind("XF86AudioMicMute", RUNCMD("swayosd-client --input-volume mute-toggle"))
hl.bind("XF86AudioRaiseVolume", RUNCMD("swayosd-client --output-volume +5"), { repeating = true })
hl.bind("XF86AudioLowerVolume", RUNCMD("swayosd-client --output-volume -5"), { repeating = true })

-- Used for Lofree Flow keyboard, comment out if not needed
hl.bind("XF86Fn&F10", RUNCMD("swayosd-client --output-volume mute-toggle"))
hl.bind("XF86Fn&Insert", RUNCMD("swayosd-client --input-volume mute-toggle"))
hl.bind("XF86Fn&F11", RUNCMD("swayosd-client --output-volume -5"), { repeating = true })
hl.bind("XF86Fn&F12", RUNCMD("swayosd-client --output-volume +5"), { repeating = true })
