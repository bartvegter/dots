local function apply_workspace_rules()
	local monitors = {}
	for _, m in ipairs(hl.get_monitors()) do
		monitors[m.name] = true
	end

	if monitors["DP-3"] then
		-- Desktop: all workspaces on DP-3
		hl.workspace_rule({ workspace = "1", persistent = true, default_name = "web", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "2", persistent = true, default_name = "code", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "3", persistent = true, default_name = "terminal", monitor = "DP-3" })
		hl.workspace_rule({
			workspace = "4",
			persistent = true,
			default_name = "chat",
			monitor = "DP-3",
			default = true,
		})
		hl.workspace_rule({ workspace = "5", persistent = true, default_name = "music", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "6", default_name = "productivity", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "7", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "8", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "9", default_name = "gaming", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "10", monitor = "DP-3" })
	else
		local internal = "eDP-1"

		if monitors["HDMI-A-1"] and monitors["DP-1"] then
			local hdmiOpt = monitors["HDMI-A-1"] and "HDMI-A-1" or internal
			local dpOpt = monitors["DP-1"] and "DP-1" or internal

			hl.workspace_rule({
				workspace = "1",
				persistent = true,
				default_name = "web",
				monitor = dpOpt,
				default = true,
			})
			hl.workspace_rule({
				workspace = "2",
				persistent = true,
				default_name = "code",
				monitor = hdmiOpt,
				default = true,
			})
			hl.workspace_rule({
				workspace = "3",
				persistent = true,
				default_name = "terminal",
				monitor = internal,
				default = true,
			})
			hl.workspace_rule({ workspace = "4", persistent = true, default_name = "chat", monitor = internal })
			hl.workspace_rule({ workspace = "5", persistent = true, default_name = "music", monitor = internal })
			hl.workspace_rule({ workspace = "6", default_name = "productivity", monitor = internal })
			hl.workspace_rule({ workspace = "7", monitor = internal })
			hl.workspace_rule({ workspace = "8", monitor = internal })
			hl.workspace_rule({ workspace = "9", default_name = "gaming", monitor = internal })
			hl.workspace_rule({ workspace = "10", monitor = internal })
		else
			-- Laptop: workspaces 2 & 3 on external display, rest on eDP-1
			local extOpt = monitors["DP-2"] and "DP-2" or monitors["HDMI-A-1"] and "HDMI-A-1" or internal

			hl.workspace_rule({ workspace = "1", persistent = true, default_name = "web", monitor = internal })
			hl.workspace_rule({ workspace = "2", persistent = true, default_name = "code", monitor = extOpt })
			hl.workspace_rule({ workspace = "3", persistent = true, default_name = "terminal", monitor = extOpt })
			hl.workspace_rule({
				workspace = "4",
				persistent = true,
				default_name = "chat",
				default = true,
				monitor = internal,
			})
			hl.workspace_rule({ workspace = "5", persistent = true, default_name = "music", monitor = internal })
			hl.workspace_rule({ workspace = "6", default_name = "productivity", monitor = internal })
			hl.workspace_rule({ workspace = "7", monitor = internal })
			hl.workspace_rule({ workspace = "8", monitor = internal })
			hl.workspace_rule({ workspace = "9", default_name = "gaming", monitor = internal })
			hl.workspace_rule({ workspace = "10", monitor = internal })
		end
	end
end

apply_workspace_rules()
hl.on("monitor.added", apply_workspace_rules)
hl.on("monitor.removed", apply_workspace_rules)
