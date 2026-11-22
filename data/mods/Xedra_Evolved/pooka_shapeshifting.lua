local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local mutations = services.mutations
local spells = services.spells

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function deactivate(character, mutation)
    value(mutations.invoke_activation(character, id("mutation", mutation), false))
end

local forms = {
    POOKA_ANTLERS = { trait = "ANTLERS", conflicts = { "POOKA_HORNS" } },
    POOKA_HORNS = { trait = "HORNS_CURLED", conflicts = { "POOKA_ANTLERS" } },
    POOKA_FANGS = { trait = "FANGS" },
    POOKA_SABER_TEETH = { trait = "SABER_TEETH" },
    POOKA_WOLF_EARS = { trait = "LUPINE_EARS", conflicts = { "POOKA_FELINE_EARS" }, restores_elfa_ears = true },
    POOKA_FELINE_EARS = { trait = "FELINE_EARS", conflicts = { "POOKA_WOLF_EARS" }, restores_elfa_ears = true },
    POOKA_CLAWS = { trait = "CLAWS" },
    POOKA_STAINLESS_CLAWS = { trait = "CLAWS_ST" },
    POOKA_BIRD_WINGS = { trait = "WINGS_BIRD" },
    POOKA_URSINE_FUR = { trait = "URSINE_FUR", conflicts = { "POOKA_CHITIN" } },
    POOKA_CHITIN = { trait = "CHITIN2", conflicts = { "POOKA_URSINE_FUR" } },
    POOKA_QUADRUPED = { trait = "POOKA_QUADRUPED_TRAITS", conflicts = { "POOKA_LEAPING_LEGS" } },
    POOKA_LEAPING_LEGS = { trait = "LEAPING_LEGS", conflicts = { "POOKA_QUADRUPED_TRAITS" } },
    POOKA_SKUNK_TAIL = { trait = "TAIL_SKUNK", conflicts = { "POOKA_TAIL_LONG", "POOKA_TAIL_STING", "POOKA_WOLF_TAIL" } },
    POOKA_WOLF_TAIL = { trait = "TAIL_FLUFFY", conflicts = { "POOKA_TAIL_LONG", "POOKA_TAIL_STING", "POOKA_SKUNK_TAIL" } },
    POOKA_TAIL_LONG = { trait = "TAIL_LONG", conflicts = { "POOKA_WOLF_TAIL", "POOKA_TAIL_STING", "POOKA_SKUNK_TAIL" } },
    POOKA_TAIL_STING = { trait = "TAIL_STING", conflicts = { "POOKA_WOLF_TAIL", "POOKA_TAIL_LONG", "POOKA_SKUNK_TAIL" } },
}

-- The original cleanup sequence is also used by the whole-animal forms.
local cleanup_order = {
    "POOKA_ANTLERS", "POOKA_HORNS", "POOKA_FANGS", "POOKA_SABER_TEETH",
    "POOKA_WOLF_EARS", "POOKA_FELINE_EARS", "POOKA_CLAWS", "POOKA_STAINLESS_CLAWS",
    "POOKA_URSINE_FUR", "POOKA_CHITIN", "POOKA_QUADRUPED", "POOKA_LEAPING_LEGS",
    "POOKA_WOLF_TAIL", "POOKA_TAIL_LONG", "POOKA_TAIL_STING",
}

local function clear_partial_forms(character)
    for _, mutation in ipairs(cleanup_order) do
        deactivate(character, mutation)
    end
end

ccb.runtime.handler("pooka_clear_partial_forms", function(context)
    clear_partial_forms(context.character)
end)

ccb.runtime.handler("pooka_start_partial_form", function(context)
    local character = context.character
    if value(services.characters.has_flag(character, id("json_flag", "TEMPORARY_SHAPESHIFT"))) then
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You are in the form of an animal.  You must turn back before shapeshifting individual parts of your body."), "bad")
        end
        clear_partial_forms(character)
        return
    end

    local form = forms[context.mutation.value]
    if form.restores_elfa_ears then
        value(mutations.erase(character, id("mutation", "ELFA_EARS")))
    end
    if form.conflicts then
        for _, mutation in ipairs(form.conflicts) do
            deactivate(character, mutation)
        end
    end
    value(mutations.replace(character, id("mutation", form.trait)))
end)

ccb.runtime.handler("pooka_end_partial_form", function(context)
    local character = context.character
    local form = forms[context.mutation.value]
    value(mutations.erase(character, id("mutation", form.trait)))
    if form.restores_elfa_ears then
        value(mutations.replace(character, id("mutation", "ELFA_EARS")))
    end
end)

local counted_traits = {
    "ANTLERS", "HORNS_CURLED", "LUPINE_EARS", "FELINE_EARS", "CLAWS", "CLAWS_ST",
    "WINGS_BIRD", "URSINE_FUR", "CHITIN2", "POOKA_QUADRUPED_TRAITS",
    "LEAPING_LEGS", "TAIL_FLUFFY", "TAIL_LONG",
}

ccb.runtime.handler("pooka_maintain_partial_form", function(context)
    local character = context.character
    local mana = value(spells.mana(character)).current
    if mana < 1 then
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You do not have enough mana to maintain all of your shapeshifts!"), "bad")
        end
        services.tasks.after_character_turn(character, 0, "pooka_clear_partial_forms")
        return
    end

    local count = 0
    for _, mutation in ipairs(counted_traits) do
        if value(mutations.has(character, id("mutation", mutation))) then
            count = count + 1
        end
    end
    local free_forms = 1
    if value(mutations.has(character, id("mutation", "POOKA_SHAPESHIFT_GOOD"))) then
        free_forms = free_forms + 1
    end
    if value(mutations.has(character, id("mutation", "POOKA_SHAPESHIFT_GOOD2"))) then
        free_forms = free_forms + 2
    end
    if value(mutations.has(character, id("mutation", "POOKA_SHAPESHIFT_GOOD3"))) then
        free_forms = free_forms + 4
    end
    local category = id("mutation_category", "FAIR_FOLK_COMMONER_POOKA")
    free_forms = free_forms + value(mutations.category_count(character, category, "ALL", true)) / 50
    if count >= free_forms then
        value(spells.set_mana_raw(character, mana - 1))
    end
end)

ccb.runtime.handler("reflex_pooka_quadruped", function(context)
    if not context.has_speaker or not context.speaker then
        return false
    end
    local actor = context.speaker
    return value(services.movement_modes_snapshot(actor)).current_id == "crouch"
        and not value(services.inventory.weapon_state(actor)).can_drop
end)

content.add(content.Mutation {
    id = "POOKA_QUADRUPED_TRAITS",
    name = content.text("Quadruped"),
    points = 2,
    purifiable = false,
    visibility = 8,
    ugliness = 6,
    description = content.text("Your arms, hands, and legs are animal-like, allowing you to move quickly when running on all fours, but preventing you from wearing shoes or gloves."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
}
    :relationship("restricts_gear", "foot_l")
    :relationship("restricts_gear", "foot_r")
    :relationship("restricts_gear", "hand_l")
    :relationship("restricts_gear", "hand_r")
    :relationship("enchantment", "INLINE_ENCH_POOKA_QUADRUPED_TRAITS_0")
    :reflex({
        {
            handler = "reflex_pooka_quadruped",
            message_on = content.text("You drop down on all fours."),
            message_off = content.text("You come out of your quadrupedal posture."),
        },
    }))
