{
  inputs,
  ...
}: {
  # home.packages = [ inputs.llm-agents.packages.x86_64-linux.herdr ];
  xdg = {
    configFile."herdr/config.toml".text = ''
      # Show first-run notification setup on startup.
      # Missing also shows onboarding; set false after you've chosen.
      onboarding = false

      [theme]
      # Built-in themes: catppuccin, terminal, tokyo-night, dracula, nord,
      #                  gruvbox, one-dark, solarized, kanagawa, rose-pine,
      #                  vesper
      # name = "catppuccin"

      # Follow host terminal light/dark appearance and switch Herdr UI themes.
      # Existing manual behavior is unchanged unless this is true.
      # auto_switch = false
      # dark_name = "catppuccin"
      # light_name = "catppuccin-latte"

      # Override individual color tokens on top of the base theme.
      # Accepts: hex (#rrggbb), named colors, rgb(r,g,b), or panel_bg = "reset"
      # [theme.custom]
      # sidebar_bg = "#181825"
      # active_row_bg = "#1e1e2e"
      # selection_bg = "#313244"
      # panel_bg = "reset"
      # accent = "#f5c2e7"
      # red = "#ff6188"
      # green = "#a6e3a1"

      [terminal]
      # Executable used for new interactive panes.
      # Empty means $SHELL, then /bin/sh.
      # default_shell = ""

      # Startup mode for new interactive pane shells: "auto", "login", or "non_login".
      # "auto" uses login shells on macOS and keeps the current behavior elsewhere.
      # shell_mode = "auto"

      # CWD policy for new panes, tabs, and workspaces when no explicit --cwd is provided.
      # Use "follow" to inherit the source pane/workspace, "home" for $HOME,
      # "current" for Herdr's process directory, or a fixed path such as "~/Projects".
      # new_cwd = "follow"

      [update]
      # Update channel used by background version checks and `herdr update`.
      # Stable builds default to "stable". Windows preview builds default to "preview"
      # so existing preview installs stay there until explicitly switched.
      # channel = "stable"

      # Check herdr.dev for new Herdr versions in the background.
      version_check = false

      # Check herdr.dev for remote agent-detection manifest updates in the background.
      manifest_check = true

      [keys]
      # Prefix key to enter prefix mode (default: "ctrl+b")
      # Examples: "ctrl+b", "f12", "esc", "-"
      # Action bindings use explicit syntax: "prefix+n" requires the prefix;
      # "ctrl+alt+n" is a direct terminal-mode shortcut.
      # Accepted key syntax: plain keys, ctrl/shift/alt/cmd/super modifiers, and special keys like enter/tab/esc/left/right/up/down.
      # Named punctuation such as minus, comma, ampersand, plus, and backtick is also accepted.
      # Most reliable direct bindings are ctrl+letter, function keys, and explicit modified chords.
      # alt+..., cmd/super, and punctuation-with-modifiers may depend on your terminal/tmux setup.
      # prefix = "ctrl+b"

      # Prefix-mode actions
      # help = "prefix+?"
      # settings = "prefix+s"
      # detach = "prefix+q"
      # reload_config = "prefix+shift+r"
      # open_notification_target = "prefix+o"
      # workspace_picker = "prefix+w"
      # goto = "prefix+g"
      # new_workspace = "prefix+shift+n"
      # new_worktree = "prefix+shift+g"
      # open_worktree = ""    # optional, unset by default
      # remove_worktree = ""  # optional, unset by default; opens confirmation
      # rename_workspace = "prefix+shift+w"
      # close_workspace = "prefix+shift+d"
      # previous_workspace = "" # optional, unset by default
      # next_workspace = ""     # optional, unset by default
      # previous_agent = ""     # optional, unset by default
      # next_agent = ""         # optional, unset by default
      # focus_agent = ""        # optional indexed binding, e.g. "prefix+alt+1..9"
      # remote_image_paste = "ctrl+v" # only active in herdr --remote; empty disables raw-key image paste
      # new_tab = "prefix+c"
      # rename_tab = "prefix+shift+t"
      # previous_tab = "prefix+p"
      # next_tab = "prefix+n"
      # move_tab_previous = ""   # optional, e.g. "alt+shift+left" moves the tab toward the front
      # move_tab_next = ""       # optional, e.g. "alt+shift+right" moves the tab toward the back
      # switch_tab = "prefix+1..9"
      # switch_workspace = ""   # optional indexed binding, e.g. "prefix+shift+1..9"
      # close_tab = "prefix+shift+x"
      # rename_pane = "prefix+shift+p"
      # edit_scrollback = "prefix+e"
      # focus_pane_left = "prefix+h"
      # focus_pane_down = "prefix+j"
      # focus_pane_up = "prefix+k"
      # focus_pane_right = "prefix+l"
      # cycle_pane_next = "prefix+tab"
      # cycle_pane_previous = "prefix+shift+tab"
      # last_pane = ""          # optional, unset by default; bind e.g. "prefix+tab" for global back-and-forth
      # split_vertical = "prefix+v"
      # split_horizontal = "prefix+minus"
      # close_pane = "prefix+x"
      # zoom = "prefix+z"       # legacy alias: fullscreen
      # resize_mode = "prefix+r"
      # resize_pane_left = ""   # optional, e.g. "ctrl+shift+alt+left" resizes without entering resize mode
      # resize_pane_down = ""   # optional, e.g. "ctrl+shift+alt+down"
      # resize_pane_up = ""     # optional, e.g. "ctrl+shift+alt+up"
      # resize_pane_right = ""  # optional, e.g. "ctrl+shift+alt+right"
      # toggle_sidebar = "prefix+b"

      # Navigate-mode movement. These local shortcuts win while navigate mode is open.
      # They are independent from focus_pane_*. Do not include prefix+, esc, enter, tab, or 1..9 here.
      # navigate_workspace_up = "up"
      # navigate_workspace_down = "down"
      # navigate_pane_left = "h"      # left arrow always focuses the pane to the left
      # navigate_pane_down = "j"
      # navigate_pane_up = "k"
      # navigate_pane_right = "l"     # right arrow always focuses the pane to the right

      # Custom commands use the same binding syntax.
      # type = "shell" runs detached in the background.
      # type = "pane" opens a temporary pane and closes it when the command exits.
      # type = "popup" opens a session-modal terminal without changing the tab layout.
      # Popup width and height accept terminal cells or percentages such as "80%".
      # On Windows, command strings run through cmd.exe /d /c.
      # [[keys.command]]
      # key = "prefix+alt+g"
      # type = "popup"
      # command = "lazygit"
      # width = "80%"
      # height = "80%"

      # Legacy indexed shortcut config is still parsed for compatibility.
      # Prefer switch_tab, switch_workspace, and focus_agent for new configs.
      # [keys.indexed]
      # tabs = ""       # e.g. "ctrl" makes ctrl+1..9 switch tabs directly
      # workspaces = "" # e.g. "ctrl+shift" makes ctrl+shift+1..9 switch workspaces directly
      # agents = ""     # e.g. "alt" makes alt+1..9 focus agent rows directly

      # Size of the virtual terminal used when no client is attached.
      # Attached clients always use their own terminal size.
      [server]
      # headless_cols = 120
      # headless_rows = 40

      [worktrees]
      directory = "/projects/herdr/worktrees"

      [ui]
      # Sidebar width (auto-scaled based on workspace names, this sets the default)
      # sidebar_width = 26

      # Minimum sidebar width when expanded (columns)
      # sidebar_min_width = 18

      # Maximum sidebar width when expanded (columns)
      # sidebar_max_width = 36

      # Start with the sidebar collapsed. Changes take effect on the next launch.
      # sidebar_start_collapsed = false

      # Collapsed sidebar presentation: "compact" keeps the narrow status rail, "hidden" uses zero width.
      # sidebar_collapsed_mode = "compact"

      # Terminal width at or below which Herdr uses the mobile single-column layout.
      # Increase this for foldables, tablets, or wide phone terminals.
      # mobile_width_threshold = 64

      # Capture mouse input for Herdr's mouse UI.
      # Set false to let the terminal handle normal clicks, such as Cmd-clicking URLs.
      # Pane apps like lazygit and btop can still receive mouse when they request it.
      # mouse_capture = true

      # Automatically copy text selected with the mouse.
      # Set false to retain drag or double-click word selection until Ctrl+C,
      # or Cmd+C when the host forwards it, copies and clears it.
      # copy_on_select = true

      # Background notification popup delivery
      [ui.toast]
      # off = disable pop-up notifications
      # herdr = show in-app toasts
      # terminal = ask the outer terminal to show a desktop notification
      # system = ask the OS notification service directly
      # delivery = "off"
      # delay_seconds = 1

      [ui.toast.herdr]
      # position = "bottom-right"

      [ui.toast.clipboard]
      enabled = true
      # position = "bottom-center"

      [ui.sound]
      enabled = true

      [ui.sound.agents]
      droid = "on"

      [session]
      # Resume supported AI-agent panes into their native conversation sessions after
      # a Herdr server restart. Requires official integrations that report session refs.
      # resume_agents_on_restore = true

      [experimental]
      allow_nested = false
      kitty_graphics = true
      pane_history = true

      [advanced]
      # scrollback_limit_bytes = 10000000

    '';
  };
}
