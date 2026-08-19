local mainMod = "SUPER + "
local ipc = "noctalia msg "

local launchApp = function(app)
	return hl.dsp.exec_cmd("uwsm app -- " .. app)
end

local exec = function(cmd)
	return hl.dsp.exec_cmd(cmd)
end

-- Application/cmd binds
hl.bind(mainMod .. "D", exec(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "V", exec(ipc .. "panel-toggle clipboard"))
hl.bind(mainMod .. "M", exec(ipc .. "panel-toggle session"))
hl.bind(mainMod .. "N", exec(ipc .. "session lock"))
hl.bind(mainMod .. "comma", exec(ipc .. "settings-toggle"))

hl.bind(mainMod .. "RETURN", launchApp(TERMINAL))
hl.bind(mainMod .. "E", launchApp(FILE_BROWSER))
hl.bind(mainMod .. "B", launchApp(BROWSER))
hl.bind(mainMod .. "C", launchApp(EDITOR))
hl.bind(mainMod .. "T", launchApp("ticktick"))
hl.bind(mainMod .. "Y", launchApp("obsidian"))

hl.bind(mainMod .. "S", exec(ipc .. "screenshot-region"))
hl.bind(mainMod .. "SHIFT + S", exec(ipc .. "screenshot-fullscreen"))

hl.bind(mainMod .. "X", exec("hyprpicker -f hex --autocopy"))
hl.bind(mainMod .. "SHIFT + X", exec("hyprpicker -f rgb --autocopy"))

-- Workspace binds
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. "SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. "bracketleft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. "bracketright", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Window binds
hl.bind(mainMod .. "Q", hl.dsp.window.close())
hl.bind(mainMod .. "F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. "SPACE", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. "I", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. "H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. "J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. "K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. "L", hl.dsp.focus({ direction = "r" }))

hl.bind(mainMod .. "SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. "SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. "SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. "SHIFT + L", hl.dsp.window.move({ direction = "r" }))

hl.bind(mainMod .. "CTRL + H", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. "CTRL + J", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })
hl.bind(mainMod .. "CTRL + K", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
hl.bind(mainMod .. "CTRL + L", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })

hl.bind(mainMod .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Function key binds
hl.bind("XF86MonBrightnessUp", exec(ipc .. "brightness-up"), { locked = true })
hl.bind("XF86MonBrightnessDown", exec(ipc .. "brightness-down"), { locked = true })

hl.bind("XF86AudioMicMute", exec(ipc .. "mic-mute"), { locked = true })
hl.bind("XF86AudioMute", exec(ipc .. "volume-mute"), { locked = true })
hl.bind("XF86AudioLowerVolume", exec(ipc .. "volume-down"), { locked = true })
hl.bind("XF86AudioRaiseVolume", exec(ipc .. "volume-up"), { locked = true })

-- Used for Lofree Flow keyboard, comment out if not needed
-- hl.bind("XF86Fn&Insert", exec(ipc .. "volume-mute"), { locked = true })
-- hl.bind("XF86Fn&F10", exec(ipc .. "mic-mute"), { locked = true })
-- hl.bind("XF86Fn&F11", exec(ipc .. "volume-down"), { locked = true })
-- hl.bind("XF86Fn&F12", exec(ipc .. "volume-up"), { locked = true })
