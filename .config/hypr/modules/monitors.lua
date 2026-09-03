-- defaults
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- home desktop
hl.monitor({ output = "DP-3", mode = "2560x1440@165", position = "0x0", scale = 1, vrr = 2 })

-- laptop internal display
hl.monitor({ output = "eDP-1", mode = "2560x1600@90", position = "0x0", scale = 1.333333 })

-- home office monitor
-- hl.monitor({ output = "DP-2", mode = "2560x1440@165", position = "auto-center-up", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@120", position = "auto-center-up", scale = 1 })

-- office monitors
hl.monitor({ output = "desc: LG Electronics BK550Y 012NTBK8G957", mode = "1920x1080@60", position = "-960x-1080" })
hl.monitor({
	output = "desc: Samsung Electric Company LF24T450F HK7X400732",
	mode = "1920x1080@75",
	position = "960x-1080",
})
