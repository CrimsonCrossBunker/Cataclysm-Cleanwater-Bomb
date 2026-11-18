local ccb = require("ccb")
local saved = ccb.state.character

return function(name, enabled, interval, tick)
    local timer = name .. "_timer"
    local due = name .. "_due"

    local function schedule(character)
        ccb.tasks.after_character_turn(character, interval(), due)
        saved.set(timer, "scheduled")
    end

    local function wake(character)
        if saved.get(timer) == "dormant" and enabled(character) then
            schedule(character)
        end
    end

    ccb.runtime.handler(due, function(payload)
        local character = payload.character
        if not enabled(character) then
            saved.set(timer, "dormant")
            return
        end
        tick(character)
        schedule(character)
    end)

    local ready = name .. "_ready"
    ccb.runtime.handler(ready, function(event)
        local character = event.actors.character
        if ccb.tasks.has_character_turn(character, due) then
            saved.set(timer, "scheduled")
        elseif saved.get(timer) == "dormant" then
            wake(character)
        else
            schedule(character)
        end
    end)
    ccb.runtime.on("character_ready", ready)

    local conditions = name .. "_conditions"
    ccb.runtime.handler(conditions, function(event)
        wake(event.actors.character)
    end)
    ccb.runtime.on("character_conditions_changed", conditions)
end
