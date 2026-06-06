local HOME = os.getenv("HOME")
local PUBLIC = "/projects/nix/hosts/frankie/hyprland/lua"

local function read_hostname()
    local f = io.open("/etc/hostname", "r")
    if not f then return nil end
    local h = f:read("*l")
    f:close()
    return h
end

local XDG = os.getenv("XDG_CONFIG_HOME") or (HOME .. "/.config")

local DEVICE = HOME .. "/code/infra/devices/nixos/"
    .. (read_hostname() or "unknown") .. "/hyprland"

package.path = package.path
    .. ";" .. PUBLIC .. "/?.lua"
    .. ";" .. DEVICE .. "/?.lua"
    .. ";" .. XDG .. "/hypr" .. "/?.lua"



---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use





-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
    ecosystem = {
        enforce_permissions = false,
    },
})

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
require("hy3")
require("env")
require("input")
require("appearance")
require("monitors")
require("keybinds")
require("rules")
require("layout")
require("autostart")
