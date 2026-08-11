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
    if event.new_game then
        ccb.services.message(
            "Lua-first bundled example is active in dimension '" .. dimension .. "'.")
    end
end

return behaviour
