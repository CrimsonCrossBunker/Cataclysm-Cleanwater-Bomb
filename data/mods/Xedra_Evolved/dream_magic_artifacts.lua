local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables
local research = require("dreamsmith_research")

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function use_artifact(character, key, learned, debug_message)
    if not character then
        return 0
    end
    local progress = checked(variables.get_number(character, key)).value or 0
    if progress == 0 then
        checked(variables.set(character, key, 1, { include_before = false }))
        local potential = checked(variables.get_global_number("magic_potential")).value or 0
        checked(variables.set_global("magic_potential", potential + 1, { include_before = false }))
        if character.subtype == "avatar" then
            services.messages.add(learned, "neutral")
            local debug_text = checked(services.text.expand_for(debug_message, character, nil, nil, nil, true))
            services.messages.add(debug_text, "debug")
        end
    elseif not checked(services.mutations.has_id_text(character, "VAMPIRE")) and progress == 1 then
        research.try_dream_training(character)
    elseif character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("You've learned as much as you can from this item."), "neutral")
    end
    return 0
end

ccb.runtime.handler("play_with_magicians_hat", function(use)
    return use_artifact(use.character, "magicians_hat_xp",
        ccb.services.translate("You do some extemperaneous magic tricks with the hat and somehow feel as though something inside of you has changed."),
        ccb.services.translate("Got magic potential from Frosty's hat, magic_potential: <global_val:magic_potential>"))
end, 1)

ccb.runtime.handler("play_with_warm_ball", function(use)
    return use_artifact(use.character, "fire_ball_xp",
        ccb.services.translate("Did you know how to do contact juggling before the cataclysm or only just now this moment?"),
        ccb.services.translate("Got magic potential from the dragonball, magic_potential: <global_val:magic_potential>"))
end, 1)

content.add(content.Item {
    id = "magicians_hat",
    category = "artifacts",
    looks_like = "tophat",
    name = ccb.content.plural_text("magician's hat", "magician's hats"),
    description = ccb.content.text("An old-school cylinder hat, used by illusionists around the world.  Maybe it still remembers some cool tricks?"),
    mass_grams = 150,
    volume_ml = 600,
    price_cents = 2000,
    price_postapoc_cents = 10,
    symbol = "0",
    color = "green",
}:material("forged_dreamstuff", 1):on_use("play_with_magicians_hat",
    ccb.content.text("Activate"), ccb.content.text("You play with your %s.")))

content.add(content.Item {
    id = "fire_ball",
    category = "artifacts",
    looks_like = "cannonball_4lb",
    name = ccb.content.plural_text("warm ball", "warm balls"),
    description = ccb.content.text("A small and light ball of glass with flickering flames inside.  The surface feels scalding hot, yet the temperature does not change."),
    mass_grams = 40,
    volume_ml = 150,
    price_cents = 1000,
    price_postapoc_cents = 10,
    symbol = "o",
    color = "red",
}:material("forged_dreamstuff", 1):on_use("play_with_warm_ball",
    ccb.content.text("Activate"), ccb.content.text("You play with your %s.")))
