local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "vicinae toggle"

hl.config({
	input = {
		kb_layout = "pl",
		repeat_rate = 75,
		repeat_delay = 300,
		follow_mouse = 1,
		sensitivity = 0,
	},

	general = {
		border_size = 1,
		gaps_in = 4,
		gaps_out = 0,
		col = {
			inactive_border = "0xff444444",
			active_border = "0xffcad3f5",
			nogroup_border = "0xffffaaff",
			nogroup_border_active = "0xffff00ff",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "master",
	},

	decoration = {
		rounding = 0,
		rounding_power = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		dim_inactive = false,
		dim_strength = 0.0,
		shadow = {
			enabled = false,
			range = 3,
			render_power = 2,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = false,
			size = 8,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	debug = {
		disable_logs = false,
	},
})

hl.monitor({ output = "DP-1", mode = "2560x1440@120", position = "0x0", scale = "1" })
hl.monitor({ output = "DP-2", mode = "3440x1440@120", position = "2560x0", scale = "1" })

hl.env("XCURSOR_SIZE", "12")
hl.env("HYPRCURSOR_SIZE", "12")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.on("hyprland.start", function()
	hl.exec_cmd("xrandr --output DP-2 --primary")
	hl.exec_cmd("/usr/lib/pam_kwallet_init")
	hl.exec_cmd("[workspace 1] ghostty")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("mako")
	hl.exec_cmd("waybar")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("xwaylandvideobridge")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("syncthing")
	hl.exec_cmd("USE_LAYER_SHELL=0 vicinae server")
end)

local function apply_reload_exec()
	hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
	hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"')
end

hl.on("hyprland.start", apply_reload_exec)
hl.on("config.reloaded", apply_reload_exec)

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + CTRL + SHIFT + P", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("killall -9 waybar && waybar &"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(
	mainMod .. " + O",
	hl.dsp.exec_cmd(
		[[bash -c 'FILE=~/Pictures/screenshot_$(date +%F_%H-%M-%S).png; grim -g "$(slurp -d)" "$FILE" && wl-copy < "$FILE" && notify-send "Screenshot taken"']]
	)
)
hl.bind(
	mainMod .. " + SHIFT + O",
	hl.dsp.exec_cmd(
		[[bash -c 'eval $(hyprctl activewindow -j | jq -r " \"x=\(.at[0]) y=\(.at[1]) w=\(.size[0]) h=\(.size[1])\" "); FILE=~/Pictures/window_$(date +%F_%H-%M-%S).png; grim -g "${x},${y} ${w}x${h}" "$FILE" && wl-copy < "$FILE" && notify-send "Window screenshot saved and copied!"']]
	)
)
hl.bind(
	mainMod .. " + CTRL + SHIFT + O",
	hl.dsp.exec_cmd(
		[[bash -c 'FILE=~/Pictures/monitor_$(date +%F_%H-%M-%S).png; grim -o "$(hyprctl activeworkspace -j | jq -r .monitor)" "$FILE" && wl-copy < "$FILE" && notify-send "Monitor screenshot saved and copied!"']]
	)
)
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("hyprctl dismissnotify"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.workspace_rule({ workspace = "1", monitor = "DP-2" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({ workspace = "4", monitor = "DP-2" })
hl.workspace_rule({ workspace = "5", monitor = "DP-2" })
hl.workspace_rule({ workspace = "6", monitor = "DP-2" })
hl.workspace_rule({ workspace = "7", monitor = "DP-2" })
hl.workspace_rule({ workspace = "8", monitor = "DP-2" })
hl.workspace_rule({ workspace = "9", monitor = "DP-1" })
hl.workspace_rule({ workspace = "10", monitor = "DP-1" })

hl.window_rule({ name = "dbeaver-workspace", match = { class = "^(DBeaver)$" }, workspace = "3" })
hl.window_rule({ name = "steam-workspace", match = { class = "^(steam)$" }, workspace = "5" })
hl.window_rule({ name = "discord-workspace", match = { class = "^(discord)$" }, workspace = "6" })
hl.window_rule({ name = "thunderbird-workspace", match = { class = "^(org.mozilla.Thunderbird)$" }, workspace = "7" })
hl.window_rule({ name = "spotify-workspace", match = { class = "^(spotify)$" }, workspace = "8" })

hl.window_rule({
	name = "jetbrains-splash-tag",
	match = { class = "^(jetbrains-.*)$", title = "^(splash)$" },
	tag = "+jetbrains-splash",
	float = true,
})
hl.window_rule({ name = "jetbrains-splash-center", match = { tag = "jetbrains-splash" }, center = true })
hl.window_rule({ name = "jetbrains-splash-nofocus", match = { tag = "jetbrains-splash" }, no_focus = true })
hl.window_rule({ name = "jetbrains-splash-noborder", match = { tag = "jetbrains-splash" }, border_size = 0 })

hl.window_rule({
	name = "jetbrains-popup-tag",
	match = { class = "^(jetbrains-.*)$", title = "^$" },
	tag = "+jetbrains",
	float = true,
})
hl.window_rule({ name = "jetbrains-popup-center", match = { tag = "jetbrains" }, center = true })
hl.window_rule({ name = "jetbrains-popup-stayfocused", match = { tag = "jetbrains" }, stay_focused = true })
hl.window_rule({ name = "jetbrains-popup-noborder", match = { tag = "jetbrains" }, border_size = 0 })
hl.window_rule({
	name = "jetbrains-popup-size",
	match = { class = "^(jetbrains-.*)$", title = "^$" },
	float = true,
	size = ">50% >50%",
})

hl.window_rule({
	name = "jetbrains-tooltips-noinitialfocus",
	match = { class = "^(jetbrains-.*)$", title = "^(win.*)$" },
	float = true,
	no_initial_focus = true,
})

hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({
	name = "xwayland-drag-fix",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

hl.window_rule({
	name = "xwayland-videobridge",
	match = { class = "^(xwaylandvideobridge)$" },
	opacity = "0.0 override",
	no_anim = true,
	no_initial_focus = true,
	max_size = "1 1",
	no_blur = true,
	no_focus = true,
})

hl.window_rule({
	name = "wails-dev-apps",
	match = { class = "^(.+-dev-linux-amd64)$" },
	workspace = "9 silent",
	size = "1024 768",
	float = true,
})
