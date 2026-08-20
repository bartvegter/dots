local launchApp = function(app)
	hl.exec_cmd("uwsm app -- " .. app)
end

local exec = function(cmd)
	hl.exec_cmd(cmd)
end

hl.on("hyprland.start", function()
	launchApp("vesktop")
	launchApp("which kanshi && kanshi")
	launchApp("which netbird-ui && netbird-ui -daemon-addr 'unix:///var/run/netbird/main.sock'")
	launchApp("noctalia")
	launchApp("sone")
	launchApp("udiskie")

	exec("systemctl --user start hyprpolkitagent.service")
	exec("systemctl --user start syncthing.service")
	exec("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'") -- for GTK3 apps
	exec("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'") -- for GTK4 apps
end)
