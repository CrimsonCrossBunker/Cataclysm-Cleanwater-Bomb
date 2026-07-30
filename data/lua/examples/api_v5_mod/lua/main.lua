local model = require("lib.model")
local source_id = modules.source_id()

services.provide("settings", {
    version = 1,
    methods = {
        get = function()
            return {
                query = state.character.get("query", ""),
                enabled = state.character.get("enabled", true),
            }
        end,
        update = function(arguments)
            local query = model.clamp_query(arguments.query)
            local enabled = arguments.enabled == true
            state.character.set("query", query)
            state.character.set("enabled", enabled)
            events.emit("settings_changed", {
                query = query,
                enabled = enabled,
            })
            return {
                query = query,
                enabled = enabled,
            }
        end,
    },
})

events.on("settings_changed", function(event)
    game.add_msg(
        i18n.gettext("Lua example query changed") ..
        ": " .. tostring(event.data.query)
    )
end)

events.on("ccb.lifecycle.reload", { once = true }, function()
    state.character.set("last_reload_turn", scheduler.now())
end)

scheduler.after(1, function()
    state.character.set("runtime_ready", true)
end)

local page_id = "ccb_lua_v5_example.settings"

ui.page(page_id, {
    title = i18n.gettext("Lua API v5 example"),
    category = "examples",
    order = 100,
    slots = {
        "main.extensions",
        "ingame.extensions",
        "settings.mods",
    },
}, function(ctx)
    local settings = services.call(source_id, "settings", "get")

    ctx:heading(i18n.gettext("Portable Mod page"))
    local environment = ctx:environment()
    ctx:text(
        environment.profile .. " / " ..
        environment.input .. " / " ..
        environment.breakpoint
    )

    local query = state.page.get("draft_query", settings.query)
    query = ctx:input_text_id(
        "registry_query",
        i18n.gettext("Item search"),
        query
    )
    state.page.set("draft_query", query)

    local enabled = ctx:checkbox_id(
        "feature_enabled",
        i18n.gettext("Enabled"),
        settings.enabled
    )
    if ctx:button_id("save", i18n.gettext("Save")) then
        settings = services.call(source_id, "settings", "update", {
            query = query,
            enabled = enabled,
        })
    end

    ctx:separator()
    ctx:heading(i18n.gettext("Definition registry"))
    local page = registry.list("item", {
        query = model.clamp_query(query),
        limit = 8,
    })
    for _, entry in ipairs(page.entries) do
        ctx:bullet_text(entry.name .. " [" .. entry.id .. "]")
    end

    ctx:separator()
    ctx:heading(i18n.gettext("Current-screen actions"))
    local context = game.actions.context_snapshot()
    local options = model.safe_action_options(context, 6)
    if #options > 0 then
        local selected = state.character.get(
            "selected_action",
            options[1].id
        )
        selected = ctx:action_slot_id(
            "example_action",
            selected,
            context.revision,
            options
        )
        state.character.set("selected_action", selected)
    else
        ctx:disabled_text(i18n.gettext("No safe action is available here."))
    end
end)

game.action_menu.register({
    id = "open_example",
    name = i18n.gettext("Lua API v5 example"),
    category = "info",
}, function()
    ui.open(page_id)
end)

sidebar.register_widget({
    id = "example_status",
    name = i18n.gettext("Lua example"),
    height = 2,
    order = 500,
    draw = function()
        return {
            {
                text = i18n.gettext("Lua API v5 active"),
                color = "light_green",
            },
            game.time.now():display(),
        }
    end,
})

game.hooks.on("on_game_save", function()
    state.character.set("last_save_turn", scheduler.now())
end)
