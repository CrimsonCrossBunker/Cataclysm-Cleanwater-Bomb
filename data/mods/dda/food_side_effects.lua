local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

ccb.runtime.handler("eat_butter", function(context)
    local character = context.character
    local count = services.characters.consumption_count(character, id("item", "butter"),
        services.time.duration(6, "hour"))
    if not count.ok then error(count.error.message) end
    if count.value < 3 then return end

    local nausea = services.effects.add(character, id("effect", "nausea"),
        services.time.duration(10, "minute"))
    if not nausea.ok and nausea.error.code ~= "rejected" then error(nausea.error.message) end
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("Ugh, you've been eating too much butter…"), "bad")
    end
end)

local alien_berries_due = "alien_berries_poisoning_due"

ccb.runtime.handler("eat_alien_meadow_berries", function(context)
    ccb.tasks.after_character_turn(context.character, services.random.native_int(5 * 60, 20 * 60),
        alien_berries_due)
end)

ccb.runtime.handler(alien_berries_due, function(task)
    local character = task.character
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("Your stomach is seized with cramps!"), "bad")
    end
    local duration = services.time.duration_from_turns(3600 + services.random.native_int(0, 16200))
    local poison = services.effects.add(character, id("effect", "alienfoodpoison"), duration)
    if not poison.ok and poison.error.code ~= "rejected" then error(poison.error.message) end
end)
