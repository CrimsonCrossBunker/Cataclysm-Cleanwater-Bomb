local ccb = require("ccb")
local state = ccb.state.character

local function register(key, handler, interval, eligible, effect)
    local function schedule(character)
        ccb.tasks.after_character_turn(character, interval(), handler)
        if state.get(key) ~= "scheduled" then
            state.set(key, "scheduled")
        end
    end

    ccb.runtime.handler(handler, function(event)
        if eligible(event.character) then
            effect(event.character)
            schedule(event.character)
        else
            state.set(key, "dormant")
        end
    end, 1)

    local ready = handler .. "_ready"
    ccb.runtime.handler(ready, function(event)
        if state.get(key) == nil then
            schedule(event.actors.character)
        end
    end, 1)
    ccb.runtime.on("character_ready", ready)

    local wake = handler .. "_wake"
    ccb.runtime.handler(wake, function(event)
        local character = event.actors.character
        if state.get(key) == "dormant" and eligible(character) then
            schedule(character)
        end
    end, 1)
    ccb.runtime.on("character_conditions_changed", wake)
end

return { register = register }
