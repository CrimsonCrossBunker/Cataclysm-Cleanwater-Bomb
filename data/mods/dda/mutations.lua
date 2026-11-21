local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function cast_spell_mutation(character, spell_id, prep_moves, success_text, fail_text)
    if checked(services.needs.get(character)).stamina > 0 then
        if prep_moves > 0 then
            checked(services.characters.adjust(character, { moves = -prep_moves }))
        end
        checked(services.characters.cast_spell(character, id("spell", spell_id), {
            targeted = true,
            message = services.translate(success_text),
        }))
    elseif character.subtype == "avatar" then
        services.messages.add(services.translate(fail_text), "bad")
    end
end

ccb.runtime.handler("activate_biolum3", function(context)
    cast_spell_mutation(context.character, "spell_spit_flare", 300,
        "You launch a glob of bioluminescent material!",
        "Your body is too starved to activate your bioluminescent flare.")
end)

ccb.runtime.handler("activate_slime_spray", function(context)
    cast_spell_mutation(context.character, "spell_slime_spray", 100,
        "You spit out some goo onto your enemies!",
        "Your body is too starved to activate your slime spray.")
end)

ccb.runtime.handler("activate_feline_leap", function(context)
    cast_spell_mutation(context.character, "spell_feline_leap", 100,
        "You squat down, build up tension in your legs, waggling your tail, then release, launching yourself quite a distance.",
        "Your legs are too tired to perform a jump.")
end)

ccb.runtime.handler("activate_short_leap", function(context)
    cast_spell_mutation(context.character, "spell_short_leap", 200,
        "You squat down, build up tension in your legs and release, launching yourself quite a distance.",
        "Your legs are too tired to perform a jump.")
end)

ccb.runtime.handler("activate_crushing_leap", function(context)
    cast_spell_mutation(context.character, "spell_crushing_leap", 300,
        "You squat down, build up tension in your legs and release.  Death from above.",
        "Your legs are too tired to perform a jump.")
end)

ccb.runtime.handler("activate_avian_leap", function(context)
    cast_spell_mutation(context.character, "spell_avian_leap", 100,
        "You jump at your target with your talons up front, attempting to deal devastating damage to your target.",
        "Your legs are too tired to perform a jump.")
end)
