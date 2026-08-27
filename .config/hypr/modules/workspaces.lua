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
			default = true,
			monitor = "DP-3",
		})
		hl.workspace_rule({ workspace = "5", persistent = true, default_name = "music", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "6", default_name = "productivity", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "7", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "8", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "9", default_name = "gaming", monitor = "DP-3" })
		hl.workspace_rule({ workspace = "10", monitor = "DP-3" })
	else
		-- Laptop: workspaces 2 & 3 on external display, rest on eDP-1
		local extOpt = monitors["DP-2"] and "DP-2" or monitors["HDMI-A-1"] and "HDMI-A-1" or "eDP-1"

		hl.workspace_rule({ workspace = "1", persistent = true, default_name = "web", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "2", persistent = true, default_name = "code", monitor = extOpt })
		hl.workspace_rule({ workspace = "3", persistent = true, default_name = "terminal", monitor = extOpt })
		hl.workspace_rule({
			workspace = "4",
			persistent = true,
			default_name = "chat",
			default = true,
			monitor = "eDP-1",
		})
		hl.workspace_rule({ workspace = "5", persistent = true, default_name = "music", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "6", default_name = "productivity", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "8", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "9", default_name = "gaming", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })
	end
end

apply_workspace_rules()
hl.on("monitor.added", apply_workspace_rules)
hl.on("monitor.removed", apply_workspace_rules)
