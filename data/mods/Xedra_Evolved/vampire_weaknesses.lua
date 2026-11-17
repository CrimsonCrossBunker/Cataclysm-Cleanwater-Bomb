local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

-- Preserve this order for the shared game RNG.
local candidates = {
    "VAMPIRE_WEAKNESS_MORE_BLOOD",
    "VAMPIRE_WEAKNESS_GROTESQUE",
    "VAMPIRE_WEAKNESS_EARTH_SLEEP",
    "VAMPIRE_WEAKNESS_HOLY_BURN",
    "VAMPIRE_WEAKNESS_VAST_WATER_BURN",
    "VAMPIRE_WEAKNESS_ANIMAL_HATE",
    "VAMPIRE_WEAKNESS_FIRE_VULNERABLE",
    "VAMPIRE_WEAKNESS_COLD_BLOODED",
    "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD",
    "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD",
    "VAMPIRE_WEAKNESS_BLOOD_CRAVING",
    "VAMPIRE_WEAKNESS_NO_FUN",
}

local function clear(character)
    for _, weakness in ipairs(candidates) do
        local result = services.mutations.erase(character, id("mutation", weakness))
        if not result.ok then
            error(result.error.message)
        end
    end
end

local function grant(character, count)
    local ids = {}
    for index, weakness in ipairs(candidates) do
        ids[index] = id("mutation", weakness)
    end
    for _ = 1, count do
        local result = services.progression.grant_random_missing(character, "mutation", ids)
        if not result.ok then
            error(result.error.message)
        end
        if character.subtype == "avatar" then
            if result.value.granted then
                services.messages.add(ccb.services.translate("You gain a new vampiric weakness."), "bad")
            else
                ccb.presentation.notice(ccb.services.translate("The EOC failed to give you a weakness.  Please report this on GitHub."))
                services.activities.offer_interruption("")
            end
        end
    end
end

return { clear = clear, grant = grant }
