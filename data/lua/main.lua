-- Bundled smoke-test and API example for the first Lua UI runtime.
-- Put overrides and additional pages in config/lua/main.lua.  Opening the
-- debug-menu Lua UI action reloads both files without rebuilding the game.

local enabled = true
local amount = 50
local label = "editable from Lua"

ui.page("lua_ui_example", "Lua UI example", function(ctx)
    ctx:text("Hello, " .. game.player_name() .. "!")
    ctx:text("This page came from data/lua/main.lua (API " .. game.api_version .. ").")
    ctx:separator()

    enabled = ctx:checkbox("Enabled", enabled)
    amount = ctx:slider_int("Amount", amount, 0, 100)
    label = ctx:input_text("Label", label)

    if ctx:button("Send game message") then
        game.add_msg(label .. ": " .. amount .. (enabled and " (on)" or " (off)"))
    end
end)
