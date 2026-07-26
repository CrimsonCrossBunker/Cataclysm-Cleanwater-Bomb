-- Lua UI API v3 example.  This file is documentation and is not loaded by the
-- built-in runtime.  Copy the body into a Mod's lua/main.lua.
ui.page("adaptive_example", {
    title = "Adaptive example",
    category = "examples",
    order = 100,
    slots = { "main.extensions", "ingame.extensions" },
}, function(ctx)
    local env = ctx:environment()
    ctx:heading("One page, separate platform presentation")
    ctx:text("Profile: " .. env.profile .. " / " .. env.breakpoint)
    ctx:text_tone(
        env.touch and "Tap controls on Android" or "Use normal PC navigation",
        "info"
    )

    ctx:item_width("normal")
    local name = game.state_get("example.name", "")
    name = ctx:input_text_id("example_name", "Name", name)
    game.state_set("example.name", name)

    ctx:grid("example_stats", 1, 2, 3, function()
        ctx:table_next_row()
        ctx:table_next_column()
        ctx:text("Player")
        ctx:table_next_column()
        ctx:text(game.player_name())
    end)

    if ctx:button_id("example_apply", "Apply") then
        game.add_msg("Adaptive example activated")
    end
end)
