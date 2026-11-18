local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function show_message(character, message, severity)
    if character.subtype ~= "npc" then
        services.messages.add(message, severity)
    end
end

local function register_training(recipe, progress_key, target, completed, ongoing, old_trait, new_trait)
    ccb.runtime.handler("finish_" .. recipe, function(payload)
        local character = payload.character
        for _ = 1, payload.batch do
            local progress = checked(services.variables.get_number(character, progress_key)).value or 0
            if progress >= target then
                if old_trait then
                    checked(services.mutations.erase(character, id("mutation", old_trait)))
                    checked(services.mutations.replace(character, id("mutation", new_trait)))
                end
                show_message(character, completed())
                checked(services.recipes.forget(character, id("recipe", recipe)))
            else
                checked(services.variables.set(character, progress_key, progress + 1, { include_before = false }))
                show_message(character, ongoing())
            end
        end
    end, 1)
end

register_training("prac_dextrous_paws", "progress_dextrous_paws_usage", 10,
    function()
        return services.translate("You tie the last knot and look at it with satisfaction.  You've got it all figured out now.")
    end,
    function()
        return services.translate("The thumb goes *there* and your fingers go like *this*.  You won't do any delicate work but you're getting there.")
    end
)

register_training("prac_unmute_bird", "progress_unmute_bird", 7,
    function()
        return services.translate("What's that made of?  Glass.  That will have to do.")
    end,
    function()
        return services.translate("Restricting your range to the apes' feels demeaning, and you decide to take a break before you start plucking out your feathers in frustration.")
    end,
    "MUTE_BIRD", "MUTE_BIRD_OK"
)

register_training("prac_unmute_ceph", "progress_unmute_ceph", 7,
    function()
        return services.translate("Your sentences are short, and you can't quite control your beak's clicking as you tire.  Still, they will understand, if they want to.")
    end,
    function()
        return services.translate("Draw air into your mantle, close your throat, rehearse your sentence, exhale and contort your beak just so.")
    end,
    "MUTE_CEPH", "MUTE_CEPH_OK"
)

register_training("prac_unmute_gastropod", "progress_unmute_gastropod", 10,
    function()
        return services.translate("As your tongues files down from use the pitch of the different sounds changes, but you have managed to get a few short, raspy sentences out.")
    end,
    function()
        return services.translate("If you rub your tongue against your palate like this is makes a `th` - or at least, a `thrksrkkk`, but it's a start.  Ignore the taste of blood, there's work to be done.")
    end,
    "MUTE_GASTROPOD", "MUTE_GASTROPOD_OK"
)

register_training("prac_unmute_insect", "progress_unmute_insect", 7,
    function()
        return services.translate("You decide on the next few words, cramp your maxillae, and inhale deeply.  With some imagination you can understand the words in the whistling, before your mouthparts fall limp and you need a pause.  Larva steps.")
    end,
    function()
        return services.translate("You have all these new moving parts in your not-mouth, but they are struggling under the strain you put them under.")
    end,
    "MUTE_INSECT", "MUTE_INSECT_OK"
)

register_training("prac_unmute_slime", "progress_unmute_slime", 15,
    function()
        return services.translate("You realize you don't need to grow anything nearly as complicated as your old insides - one vesicle per word will suffice, but you needed a long time to learn the right rhythm.")
    end,
    function()
        return services.translate("Do you need teeth, lungs?  You fall back into your resting shape in exasperation.  This will take long.")
    end,
    "MUTE_SLIME", "MUTE_SLIME_OK"
)

ccb.runtime.handler("finish_prac_knitting", function(payload)
    local character = payload.character
    local one_hour = services.time.duration(60, "minute")
    for _ = 1, payload.batch do
        if checked(services.skills.level(character, "tailor")) >= 3 then
            show_message(character, services.translate(
                "You admire your designs and find happiness in your advancements in the field of knitting."
            ), "good")
            checked(services.morale.add(character, id("morale", "morale_feeling_good"), 10, 20, {
                duration = one_hour,
                decay_start = one_hour,
            }))
        else
            show_message(character, services.translate(
                "You contemplate your designs but fail to see any artistic value in them.  At least you learnt something."
            ), "mixed")
        end
    end
end, 1)
