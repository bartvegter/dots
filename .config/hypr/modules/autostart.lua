local launchApp = function(app)
	hl.exec_cmd("uwsm app -- " .. app)
end

local launchAppDelayed = function(app)
	hl.exec_cmd("while ! pgrep -x noctalia > /dev/null; do sleep 2; done; " .. "uwsm app -- " .. app)
end

local exec = function(cmd)
	hl.exec_cmd(cmd)
end

hl.on("hyprland.start", function()
	launchApp("which kanshi && kanshi")
	launchApp("noctalia")
	launchApp("syncthingtray-qt6 --wait")
	launchApp("udiskie")

	launchAppDelayed("sone")
	launchAppDelayed("vesktop")
	launchAppDelayed("which netbird-ui && netbird-ui -daemon-addr 'unix:///var/run/netbird/main.sock'")

	exec("systemctl --user start hyprpolkitagent.service")
	exec("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'")
	exec("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end)
