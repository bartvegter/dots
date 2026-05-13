LAUNCHAPP = function(app)
	return hl.dsp.exec_cmd("uwsm app -- " .. app)
end

RUNCMD = function(cmd)
	return hl.dsp.exec_cmd(cmd)
end

require("animations")
require("autostart")
require("binds")
require("general")
require("input")
require("monitors")
require("styling")
require("windowrules")
require("workspaces")
