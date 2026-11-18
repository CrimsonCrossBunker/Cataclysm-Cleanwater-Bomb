local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function check(result)
    if not result.ok then
        error(result.error.message)
    end
end

local overload = id("effect", "psionic_overload")
local stunned = id("effect", "stunned")
ccb.runtime.handler("use_drained_matrix", function(use)
    local character = use.character
    if character then
        if character.subtype == "avatar" then
            local text = use:expand_text(ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  You become aware of your skin, of every cut and bruise and scrape, of the food sitting in your stomach and the air moving in and out of your lungs.  The sensation grows rapidly until your stomach feels like it will burst and every brush of clothing on your skin is like rasping sandpaper.  As the light fades from the crystal, a searing pains fills your head."))
            ccb.presentation.notice(text)
            services.activities.offer_interruption("")
            use:message(text)
        end
        check(services.effects.add(character, overload, services.time.duration(1, "hour")))
        check(services.effects.add(character, stunned, services.time.duration(10, "turn")))
    end
    return 1
end)
