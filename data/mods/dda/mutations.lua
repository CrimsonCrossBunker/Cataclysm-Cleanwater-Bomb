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

local amputee_reset_removed_traits = {
    "NO_LEFT_ARM",
    "LEFT_PROSTHETIC_ARM",
    "LEFT_NEUROPROSTHETIC_ARM",
    "LEFT_COSMETIC_PROSTHETIC_ARM",
    "NO_RIGHT_ARM",
    "RIGHT_PROSTHETIC_ARM",
    "RIGHT_NEUROPROSTHETIC_ARM",
    "RIGHT_COSMETIC_PROSTHETIC_ARM",
    "NO_LEFT_LEG",
    "LEFT_PROSTHETIC_LEG",
    "LEFT_PEG_LEG",
    "NO_RIGHT_LEG",
    "RIGHT_PROSTHETIC_LEG",
    "RIGHT_PEG_LEG",
}

local amputee_reset_restored_traits = {
    "HAS_LEFT_ARM",
    "HAS_RIGHT_ARM",
    "HAS_LEFT_LEG",
    "HAS_RIGHT_LEG",
}

local amputee_reset_cleared_vars = {
    "traits_limbs_missing_left_arm",
    "traits_limbs_missing_left_leg",
    "traits_limbs_missing_right_arm",
    "traits_limbs_missing_right_leg",
}

ccb.runtime.handler("amputee_reset", function(context)
    local character = context.character
    if checked(services.variables.get_string(character, "traits_limbs_amputee_reset")).value == "yes" then
        return
    end
    if character.subtype == "avatar" then
        local text = services.translate("Resetting character to non-amputated state.  To continue this game unaltered with the WIP limb system exit the game without saving and add WIP Limb Stuff to this world before reloading.")
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text)
    end
    for _, trait_id in ipairs(amputee_reset_removed_traits) do
        checked(services.mutations.erase(character, id("mutation", trait_id)))
    end
    for _, trait_id in ipairs(amputee_reset_restored_traits) do
        checked(services.mutations.replace(character, id("mutation", trait_id)))
    end
    for _, key in ipairs(amputee_reset_cleared_vars) do
        checked(services.variables.remove(character, key, { include_before = false }))
    end
    checked(services.variables.set(character, "traits_limbs_amputee_reset", "yes", { include_before = false }))
end)
