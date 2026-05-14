local launchApp = function(app)
	hl.exec_cmd("uwsm app -- " .. app)
end

local exec = function(cmd)
	hl.exec_cmd(cmd)
end

hl.on("hyprland.start", function()
	launchApp("batsignal")
	launchApp("discord")
	launchApp("kanshi")
	launchApp("mako")
	launchApp("netbird-ui -daemon-addr 'unix:///var/run/netbird/main.sock'")
	launchApp("tidal-hifi")
	launchApp("swayosd-server")
	launchApp("awww-daemon")
	launchApp("udiskie")
	launchApp("wl-paste --type text --watch cliphist store")
	launchApp("wl-paste --type image --watch cliphist store")
	launchApp("wlsunset -t 4000 -S 7:00 -s 22:00")

	exec("cliphist wipe")
	exec("systemctl --user start hyprpolkitagent.service")
	exec("systemctl --user start syncthing.service")
	exec("systemctl --user start waybar.service")
	exec("brightnessctl -sd platform::kbd_backlight set 1")
	exec("gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-Dark'") -- for GTK3 apps
	exec("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'") -- for GTK4 apps
end)

hl.on("config.reloaded", function()
	exec("awww img ${wallpaper} && wal --theme base16-monokai-pro")
end)
