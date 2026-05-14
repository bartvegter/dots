LAUNCHAPP = function(app)
	return hl.dsp.exec_cmd("uwsm app -- " .. app)
end

RUNCMD = function(cmd)
	return hl.dsp.exec_cmd(cmd)
end

require("modules.animations")
require("modules.autostart")
require("modules.binds")
require("modules.general")
require("modules.input")
require("modules.monitors")
require("modules.styling")
require("modules.windowrules")
require("modules.workspaces")
