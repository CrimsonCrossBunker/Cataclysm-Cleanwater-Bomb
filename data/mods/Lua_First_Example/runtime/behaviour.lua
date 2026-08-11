local ccb = require("ccb")

local behaviour = {}

function behaviour.use_charm(context)
    local uses = ccb.state.character.get("cleanwater_charm_uses", 0) + 1
    ccb.state.character.set("cleanwater_charm_uses", uses)
    context:message("The charm hums.  Lua use count: " .. uses .. ".")
    return 0
end

function behaviour.world_ready(event)
    local dimension = ccb.services.gameplay.environment.dimension()
    assert(ccb.services.gameplay.strings.all_equal({ dimension, dimension }))
    assert(ccb.services.random.int(1, 1) == 1)
    if not ccb.state.world.get("cleanwater_example_initialized", false) then
        ccb.state.world.set("cleanwater_example_initialized", true)
        ccb.tasks.after(10, "lua_first_example_reminder", {
            text = "The clean-water charm remembers this world after loading.",
        }, 1, "world")
    end
    if event.new_game then
        ccb.services.message(
            "Lua-first bundled example is active in dimension '" .. dimension .. "'.")
    end
end

function behaviour.remind(task)
    local reminders = ccb.state.world.get("cleanwater_example_reminders", 0) + 1
    ccb.state.world.set("cleanwater_example_reminders", reminders)
    ccb.services.message(task.payload.text)
end

return behaviour
