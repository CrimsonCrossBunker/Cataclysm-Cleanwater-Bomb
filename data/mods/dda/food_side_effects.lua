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
