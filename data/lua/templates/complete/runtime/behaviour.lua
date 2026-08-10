local ccb = require("ccb")

local behaviour = {}

function behaviour.activate(context)
    local uses = ccb.state.character.get("token_uses", 0) + 1
    ccb.state.character.set("token_uses", uses)
    context:message("The Lua token answers directly from handler #" .. uses .. ".")
    return 0
end

function behaviour.world_ready(event)
    if not ccb.state.world.get("first_load_seen", false) then
        ccb.state.world.set("first_load_seen", true)
        ccb.tasks.after(10, "remind", { text = "Named Lua task resumed." }, 1, "world")
    end
    if event.new_game then
        ccb.services.message("Lua-first example initialized a new world.")
    end
end

function behaviour.remind(task)
    ccb.services.message(task.payload.text)
end

return behaviour
