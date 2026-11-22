local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local mutations = services.mutations
local spells = services.spells
local shapeshift_armor = require("shapeshift_armor")

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

local function player_message(character, text, tone)
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate(text), tone)
    end
end

local function has_trait(character, trait_name)
    return value(mutations.has_id_text(character, trait_name))
end

local function scale_calories(character, factor)
    local current = value(services.needs.get(character)).stored_kcal
    local delta = math.modf(current * factor - current)
    value(services.needs.modify_calories(character, delta, true))
end

local function assign_shift_activity(character, turns)
    value(services.activities.assign_timed(
        character, id("activity", "ACT_GENERIC_EOC"), services.time.duration_from_turns(turns)))
end

local full_forms = {
    POOKA_SHAPESHIFT_FULL_BAT = {
        traits = { "VAMPIRE_BAT_FORM_TRAITS", "ECHOLOCATION" },
        calorie_scale = 0.25,
        deactivate = "pooka_full_bat_deactivate",
        msg_on = "Your fingers lengthen as flaps of skin grow between them and as your legs shorten, you take to the air.",
        msg_off = "Your body shifts and your fingers separate as you return to your previous form.",
        msg_no_mana = "You don't have enough mana to transform into a bat.",
    },
    POOKA_SHAPESHIFT_FULL_RAVEN = {
        traits = { "TURN_INTO_RAVEN_TRAITS" },
        calorie_scale = 0.25,
        deactivate = "pooka_full_raven_deactivate",
        msg_on = "Your body shifts and warps as your fingers extend into wings and feathers burst from your skin as you take to the air.",
        msg_off = "Your body shifts and your feathers vanish as you return to your previous form.",
        msg_no_mana = "You don't have enough mana to transform into a raven.",
    },
    POOKA_SHAPESHIFT_FULL_BEAR = {
        traits = { "TURN_INTO_BEAR_TRAITS" },
        calorie_scale = 3,
        deactivate = "pooka_full_bear_deactivate",
        msg_on = "Your body shifts and expands as fur sprouts from your skin and your mouth and teeth lengthen.",
        msg_off = "Your body shifts and contracts and you return to your humanoid form.",
        msg_no_mana = "You don't have enough mana to transform into a bear.",
    },
    POOKA_SHAPESHIFT_FULL_DEER = {
        traits = { "TURN_INTO_DEER_TRAITS" },
        deactivate = "pooka_full_deer_deactivate",
        msg_on = "Your body shifts and warps as your fingers and feet fuse into hooves and majestic antlers sprout from your head.",
        msg_off = "Your body shifts and contracts and you return to your humanoid form.",
        msg_no_mana = "You don't have enough mana to transform into a deer.",
    },
    POOKA_SHAPESHIFT_FULL_WOLF = {
        traits = { "VAMPIRE_WOLF_FORM_TRAITS" },
        deactivate = "pooka_full_wolf_deactivate",
        msg_on = "Your nose pushes out into a muzzle as you fall forward on all fours and let out a snarl.",
        msg_off = "Your fur disappears and you walk once again on two legs.",
        msg_no_mana = "You don't have enough mana to transform into a wolf.",
    },
    POOKA_SHAPESHIFT_FULL_COUGAR = {
        traits = { "TURN_INTO_COUGAR_TRAITS", "FELINE_LEAP", "WHISKERS" },
        deactivate = "pooka_full_cougar_deactivate",
        msg_on = "Your nose pushes out into a muzzle and whiskers sprout from it as you fall forward on all fours and let out a growl.",
        msg_off = "Your fur and whiskers disappear and you walk once again on two legs.",
        msg_no_mana = "You don't have enough mana to transform into a cougar.",
    },
}

local all_full_forms = {
    "POOKA_SHAPESHIFT_FULL_BAT",
    "POOKA_SHAPESHIFT_FULL_RAVEN",
    "POOKA_SHAPESHIFT_FULL_BEAR",
    "POOKA_SHAPESHIFT_FULL_DEER",
    "POOKA_SHAPESHIFT_FULL_WOLF",
    "POOKA_SHAPESHIFT_FULL_COUGAR",
}

local function leave_full_form(character, form)
    if not has_trait(character, form.traits[1]) then
        return
    end
    assign_shift_activity(character, 2.5)
    for i = #form.traits, 1, -1 do
        value(mutations.erase(character, id("mutation", form.traits[i])))
    end
    if form.calorie_scale then
        scale_calories(character, 1 / form.calorie_scale)
    end
    player_message(character, form.msg_off, "neutral")
    shapeshift_armor.restore(character)
end

ccb.runtime.handler("pooka_start_full_form", function(context)
    local character = context.character
    local form = full_forms[context.mutation.value]
    if has_trait(character, form.traits[1]) then
        leave_full_form(character, form)
        return
    end

    clear_partial_forms(character)
    local mana = value(spells.mana(character)).current
    if mana >= 2 then
        assign_shift_activity(character, 2.5)
        shapeshift_armor.subsume(character)
        for _, trait_name in ipairs(form.traits) do
            value(mutations.replace(character, id("mutation", trait_name)))
        end
        if form.calorie_scale then
            scale_calories(character, form.calorie_scale)
        end
        player_message(character, form.msg_on, "good")
    else
        player_message(character, form.msg_no_mana, "bad")
        ccb.tasks.after_character_turn(character, 0, form.deactivate)
    end
end)

ccb.runtime.handler("pooka_end_full_form", function(context)
    local form = full_forms[context.mutation.value]
    leave_full_form(context.character, form)
end)

ccb.runtime.handler("pooka_maintain_full_form", function(context)
    local character = context.character
    local mana = value(spells.mana(character)).current
    if mana >= 2 then
        value(spells.set_mana_raw(character, mana - 1))
    else
        for _, mutation in ipairs(all_full_forms) do
            deactivate(character, mutation)
        end
    end
end)

for mutation_id, form in pairs(full_forms) do
    ccb.runtime.handler(form.deactivate, function(context)
        deactivate(context.character, mutation_id)
    end)
end

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
