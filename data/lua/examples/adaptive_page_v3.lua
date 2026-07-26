-- Lua UI API v3 example.  This file is documentation and is not loaded by the
-- built-in runtime.  Copy the body into a Mod's lua/main.lua.
local function tr(message)
    return i18n.gettext(message)
end

ui.page("adaptive_example_result", {
    title = tr("Adaptive example result"),
    category = "examples",
    order = 101,
    slots = { "main.extensions", "ingame.extensions" },
}, function(ctx, params)
    ctx:heading(tr("Saved value"))
    ctx:text(params.name or tr("Unnamed"))
    if ctx:button_id("example_back", tr("Back")) then
        ui.back()
    end
end)

ui.page("adaptive_example", {
    title = tr("Adaptive example"),
    category = "examples",
    order = 100,
    slots = { "main.extensions", "ingame.extensions" },
}, function(ctx, params)
    local env = ctx:environment()
    ctx:heading(tr("One page, separate platform presentation"))
    ctx:text(tr("Profile") .. ": " .. env.profile .. " / " .. env.breakpoint)
    ctx:text_tone(
        env.touch and tr("Tap controls on Android")
        or tr("Use normal PC navigation"),
        "info"
    )

    ctx:item_width("normal")
    local saved_name = state.character.get("name", "")
    local name = state.page.get("draft_name", saved_name)
    name = ctx:input_text_id("example_name", tr("Name"), name)
    state.page.set("draft_name", name)

    ctx:grid("example_stats", 1, 2, 3, function()
        ctx:table_next_row()
        ctx:table_next_column()
        ctx:text(tr("Player"))
        ctx:table_next_column()
        ctx:text(game.player_name())
    end)

    if ctx:button_id("example_apply", tr("Apply")) then
        state.character.set("name", name)
        game.add_msg(tr("Adaptive example activated"))
        ui.open("adaptive_example_result", { name = name })
    end
end)
