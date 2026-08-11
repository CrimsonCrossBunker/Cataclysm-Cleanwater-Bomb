local ccb = require("ccb")

local behaviour = {}

function behaviour.activate(context)
    local uses = ccb.state.character.get("token_uses", 0) + 1
    ccb.state.character.set("token_uses", uses)
    context:message("The Lua token answers directly from handler #" .. uses .. ".")
    return 0
end

function behaviour.world_ready(event)
    local dimension = ccb.services.gameplay.environment.dimension()
    assert(ccb.services.gameplay.strings.all_equal({ dimension, dimension }))
    assert(ccb.services.random.int(1, 1) == 1)
    if not ccb.state.world.get("first_load_seen", false) then
        ccb.state.world.set("first_load_seen", true)
        ccb.tasks.after(10, "remind", { text = "Named Lua task resumed." }, 1, "world")
    end
    if event.new_game then
        ccb.services.message(
            "Lua-first example initialized dimension '" .. dimension .. "'.")
    end
end

function behaviour.remind(task)
    ccb.services.message(task.payload.text)
end

return behaviour
