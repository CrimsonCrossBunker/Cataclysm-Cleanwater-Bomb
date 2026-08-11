local ccb = require("ccb")

local behaviour = {}

function behaviour.use_charm(context)
    local uses = ccb.state.character.get("cleanwater_charm_uses", 0) + 1
    ccb.state.character.set("cleanwater_charm_uses", uses)
    context:message("The charm hums.  Lua use count: " .. uses .. ".")
    return 0
end

function behaviour.world_ready(event)
    if event.new_game then
        ccb.services.message("Lua-first bundled example is active.")
    end
end

return behaviour
