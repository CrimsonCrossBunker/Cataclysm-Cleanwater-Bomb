local ccb = require("ccb")

local messages = {
    VAMPIRE_WEAKNESS_MORE_BLOOD = function()
        return ccb.services.translate("Your thirst for blood intensifies.")
    end,
    VAMPIRE_WEAKNESS_EARTH_SLEEP = function()
        return ccb.services.translate("You long for a good day of sleep surrounded by the earth.")
    end,
    VAMPIRE_WEAKNESS_HOLY_BURN = function()
        return ccb.services.translate("You feel unholy, as if your presence wouldn't be tolerated by holy ground.")
    end,
    VAMPIRE_WEAKNESS_VAST_WATER_BURN = function()
        return ccb.services.translate("You think about crossing a river, but visions of your flesh melting disturb you.")
    end,
    VAMPIRE_WEAKNESS_ANIMAL_HATE = function()
        return ccb.services.translate("Nearby animals start looking at you with eyes filled with hate.")
    end,
    VAMPIRE_WEAKNESS_FIRE_VULNERABLE = function()
        return ccb.services.translate("Your body feels much more vulnerable to fire.")
    end,
    VAMPIRE_WEAKNESS_COLD_BLOODED = function()
        return ccb.services.translate("Your body grows cold.")
    end,
    VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD = function()
        return ccb.services.translate("You daydream of drinking blood directly from the veins of the living for a moment.")
    end,
    VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD = function()
        return ccb.services.translate("All bloods, except the blood of regular humans, suddenly feel far less appealing.")
    end,
    VAMPIRE_WEAKNESS_BLOOD_CRAVING = function()
        return ccb.services.translate("You feel a painful craving for blood for a second, then it passes.")
    end,
    VAMPIRE_WEAKNESS_NO_FUN = function()
        return ccb.services.translate("Everything grows dull and boring.  Your only memories still making you happy are those about drinking blood.")
    end,
    ANATHEMA_WEAKNESS_SUN_BURN = function()
        return ccb.services.translate("You know with certainty that standing under the sun will slay you in moments.")
    end,
    ANATHEMA_WEAKNESS_MIND_CHAOS = function()
        return ccb.services.translate("Your mind reels at the thought of drinking more vampire blood.")
    end,
    ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD = function()
        return ccb.services.translate("You feel a growing thirst for the blood of vampires.")
    end,
}

ccb.runtime.handler("describe_vampire_weakness", function(event)
    local character = event.actors.character
    if character and character.subtype ~= "avatar" then
        return
    end
    local describe = messages[event.data.trait]
    if describe then
        ccb.services.messages.add(describe(), "bad")
    end
end, 1)
ccb.runtime.on("game:gains_mutation", "describe_vampire_weakness")
