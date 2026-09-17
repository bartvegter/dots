local function setup_monitors()
	local monitors = {}
	for _, m in ipairs(hl.get_monitors()) do
		monitors[m.name] = true
	end

	-- defaults for unknown monitors
	hl.monitor({
		output = "",
		mode = "preferred",
		position = "auto",
		scale = "auto",
	})

	-- laptop internal display
	hl.monitor({
		output = "eDP-1",
		mode = "2560x1600@90",
		position = "0x0",
		scale = 1.333333,
	})

	-- office monitors
	hl.monitor({
		output = "desc: LG Electronics BK550Y 012NTBK8G957",
		mode = "1920x1080@60",
		position = "-960x-1080",
	})
	hl.monitor({
		output = "desc: Samsung Electric Company LF24T450F HK7X400732",
		mode = "1920x1080@75",
		position = "960x-1080",
	})

	-- home office monitor setup based on connected laptop
	if monitors["eDP-1"] then
		-- home office second monitor mode (laptop)
		hl.monitor({
			output = "desc: Microstep MSI MAG274QRF CA8A201200443",
			mode = "2560x1440@120",
			position = "auto-center-up",
		})
	else
		-- home office single monitor mode (desktop)
		hl.monitor({
			output = "desc: Microstep MSI MAG274QRF CA8A201200443",
			mode = "2560x1440@165",
			position = "0x0",
			scale = 1,
			vrr = 2,
		})
	end
end

setup_monitors()
hl.on("monitor.added", setup_monitors)
hl.on("monitor.removed", setup_monitors)
hl.on("config.reloaded", setup_monitors)
