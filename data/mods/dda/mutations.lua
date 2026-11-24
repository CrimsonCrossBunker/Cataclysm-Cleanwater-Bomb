local ccb = require("ccb")
local content = ccb.content
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

ccb.runtime.handler("debug_mutate", function(context)
    checked(services.mutations.mutate(context.character, 0, true))
end)

local random_npc_missions = {
    { id = "MISSION_GET_RELIC", move_only = false },
    { id = "MISSION_GET_RECORD_ACCOUNTING", move_only = true },
    { id = "MISSION_GET_INHALER", move_only = false },
    { id = "MISSION_GET_ANTIBIOTICS", move_only = false },
    { id = "MISSION_GET_FLAG", move_only = false },
    { id = "MISSION_GET_RECORD_WEATHER", move_only = false },
    { id = "MISSION_GET_SOFTWARE", move_only = false },
    { id = "MISSION_GET_RECORD_PATIENT", move_only = true },
    { id = "MISSION_KILL_JABBERWOCK", move_only = false },
    { id = "MISSION_KILL_ZOMBIE_MOM", move_only = false },
    { id = "MISSION_RESCUE_DOG", move_only = false },
    { id = "MISSION_PROVE_YOU_ARE_A_SURVIVOR", move_only = true },
    { id = "MISSION_LEARN_ABOUT_CATTAIL_JELLY", move_only = false },
    { id = "MISSION_PYROMANIAC", move_only = true },
}

local random_npc_mission_weights = {}
for i = 1, #random_npc_missions do
    random_npc_mission_weights[i] = 1
end

ccb.runtime.handler("give_random_mission", function(context)
    local c = context.character
    local has_move = checked(services.mutations.has_id_text(c, "GETS_RANDOM_MISSION"))
    local has_nomove = checked(services.mutations.has_id_text(c, "GETS_RANDOM_MISSION_NOMOVE"))
    if not (has_move or has_nomove) then
        return
    end
    local idx = services.random.weighted_index(random_npc_mission_weights)
    local entry = idx and random_npc_missions[idx]
    if entry and (has_move or not entry.move_only) and c.subtype == "npc" then
        checked(services.npcs.missions.offer(c, id("mission", entry.id)))
    end
    checked(services.mutations.erase(c, id("mutation", "GETS_RANDOM_MISSION")))
    checked(services.mutations.erase(c, id("mutation", "GETS_RANDOM_MISSION_NOMOVE")))
end)

local quadruped_thresholds = {
    "THRESH_BEAST",
    "THRESH_LUPINE",
    "THRESH_RABBIT",
    "THRESH_FELINE",
}

local function has_any_trait(character, traits)
    for _, trait in ipairs(traits) do
        if checked(services.mutations.has_id_text(character, trait)) then
            return true
        end
    end
    return false
end

local function move_mode(character)
    return checked(services.movement_modes_snapshot(character)).current_id
end

local function can_drop_weapon(character)
    return checked(services.inventory.weapon_state(character)).can_drop
end

local function has_flag(character, flag)
    return checked(services.characters.has_flag(character, id("json_flag", flag)))
end

ccb.runtime.handler("reflex_quadruped_paws", function(context)
    if not context.has_speaker or not context.speaker then
        return false
    end
    local actor = context.speaker
    return move_mode(actor) == "crouch"
        and has_any_trait(actor, quadruped_thresholds)
        and not can_drop_weapon(actor)
        and not has_flag(actor, "QUADRUPED_RUN")
end)

ccb.runtime.handler("reflex_legs_bat", function(context)
    if not context.has_speaker or not context.speaker then
        return false
    end
    local actor = context.speaker
    local mode = move_mode(actor)
    return (mode == "run" or mode == "crouch")
        and not can_drop_weapon(actor)
        and checked(services.mutations.has_id_text(actor, "WINGS_BAT"))
end)

ccb.runtime.handler("reflex_animal_feet", function(context)
    if not context.has_speaker or not context.speaker then
        return false
    end
    local actor = context.speaker
    local mode = move_mode(actor)
    return (mode == "run" or mode == "crouch")
        and not can_drop_weapon(actor)
        and has_any_trait(actor, quadruped_thresholds)
        and has_flag(actor, "QUADRUPED_CROUCH")
end)

ccb.runtime.handler("reflex_jekyll_morale", function(context)
    if not context.has_speaker or not context.speaker then
        return false
    end
    return checked(services.needs.morale(context.speaker)).total < -50
end)

ccb.runtime.handler("reflex_jekyll_night", function(context)
    if not context.has_speaker or not context.speaker then
        return false
    end
    local now = services.time.now()
    local turns = now:hour_of_day() * 3600 + now:minute_of_hour() * 60 + now:second_of_minute()
    return turns < 6 * 3600 or turns > 21 * 3600
end)

content.add(content.Mutation {
    id = "PAWS",
    name = content.text("Paws"),
    description = content.text("Your hands have fused into quasi-paws.  Fine manipulation is a challenge: permanent hand encumbrance of 10, difficulty with delicate craftwork, and your gloves don't fit.  But they handle water better and bear weight well, allowing you to move on all fours when crouching and unarmed."),
    categories = { "LUPINE", "FELINE", "BEAST", "URSINE" },
    types = { "HANDS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 2,
    flags = { "QUADRUPED_CROUCH" },
}
    :relationship("prereq", "NAILS")
    :relationship("prereq", "CLAWS")
    :relationship("prereq", "CLAWS_RETRACT")
    :relationship("prereq", "CLAWS_RAT")
    :relationship("prereq2", "SHORTER_FINGERS")
    :relationship("replace_with", "PAWS_LARGE")
    :relationship("cancel", "TALONS")
    :integer_value("craft_skill_bonus", "electronics", -2)
    :integer_value("craft_skill_bonus", "tailor", -2)
    :integer_value("craft_skill_bonus", "mechanics", -2)
    :relationship("restricts_gear", "hand_l")
    :relationship("restricts_gear", "hand_r")
    :relationship("enchantment", "ench_quadruped_movement_half")
    :relationship("enchantment", "INLINE_ENCH_PAWS_1")
    :reflex({
        {
            handler = "reflex_quadruped_paws",
            message_on = content.text("You drop down on all fours."),
            message_off = content.text("You come out of your quadrupedal posture."),
        },
    }))

content.add(content.Mutation {
    id = "PAWS_LARGE",
    name = content.text("Broad Paws"),
    description = content.text("Your paws are much larger now.  Manual dexterity is difficult: you have a penalty to your grip and manipulation scores, serious problems crafting, and can't wear gloves.  In return, though, you can swim better and move on all fours when crouching and unarmed."),
    categories = { "BEAST", "URSINE" },
    types = { "HANDS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = 3,
    flags = { "QUADRUPED_CROUCH" },
}
    :relationship("prereq", "PAWS")
    :relationship("cancel", "TALONS")
    :relationship("restricts_gear", "hand_l")
    :relationship("restricts_gear", "hand_r")
    :integer_value("craft_skill_bonus", "electronics", -4)
    :integer_value("craft_skill_bonus", "tailor", -4)
    :integer_value("craft_skill_bonus", "mechanics", -4)
    :integer_value("craft_skill_bonus", "firstaid", -2)
    :integer_value("craft_skill_bonus", "computer", -2)
    :integer_value("craft_skill_bonus", "traps", -2)
    :integer_value("craft_skill_bonus", "fabrication", -2)
    :integer_value("craft_skill_bonus", "cooking", -2)
    :integer_value("craft_skill_bonus", "survival", -2)
    :relationship("enchantment", "ench_quadruped_movement_half")
    :relationship("enchantment", "INLINE_ENCH_PAWS_LARGE_1")
    :reflex({
        {
            handler = "reflex_quadruped_paws",
            message_on = content.text("You drop down on all fours."),
            message_off = content.text("You come out of your quadrupedal posture."),
        },
    }))

content.add(content.Mutation {
    id = "PAWS_LITTLE",
    name = content.text("Little Paws"),
    description = content.text("Your hands have elongated and look a bit more like paws.  It makes fine manipulation a little more difficult, and you'll have a harder time with firearms, but you can still probably manage.  Plus, they allow you to move on all fours when crouching and unarmed."),
    categories = { "RABBIT" },
    types = { "HANDS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 1,
    flags = { "QUADRUPED_CROUCH" },
}
    :relationship("prereq", "NAILS")
    :relationship("prereq2", "LONGER_FINGERS")
    :relationship("cancel", "TALONS")
    :integer_value("craft_skill_bonus", "electronics", -1)
    :integer_value("craft_skill_bonus", "tailor", -1)
    :integer_value("craft_skill_bonus", "mechanics", -1)
    :relationship("enchantment", "ench_quadruped_movement_half")
    :relationship("enchantment", "ench_dextrous_paws_need_practice")
    :relationship("enchantment", "INLINE_ENCH_PAWS_LITTLE_2")
    :reflex({
        {
            handler = "reflex_quadruped_paws",
            message_on = content.text("You drop down on all fours."),
            message_off = content.text("You come out of your quadrupedal posture."),
        },
    }))

content.add(content.Mutation {
    id = "LEGS_BAT",
    name = content.text("Bow-legged"),
    description = content.text("Your lower limbs have shortened and splayed, slowing your bipedal movement.  As long as you're not wielding anything and you've got both wings, you're able to crawl quickly and quietly when you run or crouch."),
    categories = { "CHIROPTERAN" },
    types = { "LEGS" },
    points = -3,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 2,
}
    :relationship("prereq", "PADDED_FEET")
    :relationship("prereq", "WINGS_BAT")
    :relationship("threshold_requirement", "THRESH_CHIROPTERAN")
    :relationship("enchantment", "INLINE_ENCH_LEGS_BAT_0")
    :relationship("enchantment", "INLINE_ENCH_LEGS_BAT_1")
    :relationship("enchantment", "INLINE_ENCH_LEGS_BAT_2")
    :wet_protection("foot_l", 0, 10, 0)
    :wet_protection("foot_r", 0, 10, 0)
    :reflex({
        {
            handler = "reflex_legs_bat",
            message_on = content.text("You hunch forward to crawl quickly on folded wings."),
            message_off = content.text("You rise up to walk like a human."),
        },
    }))

content.add(content.Mutation {
    id = "ANIMAL_FEET",
    name = content.text("Digitigrade Legs"),
    description = content.text("The heels of your feet have shifted up off the ground in a rather animalistic fashion, reducing your carry weight limit and preventing you from wearing shoes.  These hind feet are a bad match for human arms, but could pair well with matching forepaws."),
    categories = { "LUPINE", "FELINE", "BEAST", "RABBIT" },
    types = { "FEET" },
    points = -3,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 2,
    flags = { "QUADRUPED_RUN" },
    destroys_gear = true,
}
    :relationship("prereq", "PADDED_FEET")
    :relationship("replace_with", "RABBIT_FEET")
    :relationship("restricts_gear", "foot_l")
    :relationship("restricts_gear", "foot_r")
    :relationship("enchantment", "ench_quadruped_movement_full")
    :relationship("enchantment", "INLINE_ENCH_ANIMAL_FEET_1")
    :relationship("enchantment", "INLINE_ENCH_ANIMAL_FEET_2")
    :relationship("enchantment", "INLINE_ENCH_ANIMAL_FEET_3")
    :relationship("enchantment", "INLINE_ENCH_ANIMAL_FEET_4")
    :wet_protection("foot_l", 0, 10, 0)
    :wet_protection("foot_r", 0, 10, 0)
    :reflex({
        {
            handler = "reflex_animal_feet",
            message_on = content.text("You drop down on all fours."),
            message_off = content.text("You assume a less bestial posture."),
        },
    }))

content.add(content.Mutation {
    id = "JEKYLL",
    name = content.text("Normal Human"),
    description = content.text("You're a normal human; there's nothing wrong with you.  No need to worry."),
    categories = { "MEDICAL" },
    points = 0,
    vitamin_cost = 60,
    purifiable = false,
    transform = {
        target = "HYDE",
        message = content.text("The anger overtakes you!"),
        active = false,
        moves = 10,
    },
}
    :reflex({
        {
            handler = "reflex_jekyll_morale",
            message_on = content.text("Everything is terrible and this makes you so ANGRY!"),
            message_on_type = "mixed",
        },
    })
    :reflex({
        {
            handler = "reflex_jekyll_night",
            message_on = content.text("Everything is terrible and this makes you so ANGRY!"),
            message_on_type = "mixed",
        },
    }))

-- WAVE16B_START
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_reflex_amog_1_1", function(context)
    if not context or not context.has_speaker or not context.speaker then
        return false
    end
    local ctx = H.ctx_new(context.speaker, nil, {})
    return (((H.char_val_extra(H.u(ctx), "morale") < (-75)) or (H.char_val_extra(H.u(ctx), "morale") > 75) or (H.char_val_extra(H.u(ctx), "stim") < (-50)) or (H.char_val_extra(H.u(ctx), "stim") > 50))) == true
end)

content.add(content.Mutation {
    id = "AMOG",
    name = "Alpha Member of the Group",
    description = "You are the natural leader of any group.  It's just part of who you are, groups naturally form around you and you need these groups to energize you.  Sometimes however, you give in to your worst impulses and this trait will flip.",
    categories = { "ALPHA" },
    types = { "SOCIAL" },
    prerequisites = { "INT_ALPHA", "PER_ALPHA", "STR_ALPHA", "DEX_ALPHA" },
    threshold_requirements = { "THRESH_ALPHA" },
    cancels = { "ASOCIAL1", "ASOCIAL2", "SOCIAL1", "SOCIAL2" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    social_modifiers = { intimidate = 5, persuade = 15, lie = 10 },
    transform = {
        target = "DARK_TRIAD",
        active = false,
        moves = 10,
        message = "You give in to your worst instincts.",
    },
}
    :relationship("flag", "SOCIAL2")
    :reflex({
        { handler = "w16b_reflex_amog_1_1" },
    }))

ccb.runtime.handler("w16b_reflex_dark_triad_1_1", function(context)
    if not context or not context.has_speaker or not context.speaker then
        return false
    end
    local ctx = H.ctx_new(context.speaker, nil, {})
    return ((H.time_since(H.var_num_opt(H.u(ctx), "transform_time"), 1) > 129600)) == true
end)

content.add(content.Mutation {
    id = "DARK_TRIAD",
    name = "Dark Triad",
    description = "You are a god among mortals and they are all so very disappointing.  Why should you even bother to hide your disappointment in their failures?",
    categories = { "ALPHA" },
    types = { "SOCIAL" },
    cancels = { "ASOCIAL1", "ASOCIAL2", "SOCIAL1", "SOCIAL2" },
    points = -1,
    valid = false,
    social_modifiers = { intimidate = -10, persuade = -25, lie = -15 },
    transform = {
        target = "AMOG",
        active = false,
        moves = 10,
        message = "Maybe you can make better decisions this time.",
    },
}
    :relationship("flag", "ASOCIAL2")
    :reflex({
        { handler = "w16b_reflex_dark_triad_1_1" },
    }))

ccb.runtime.handler("w16b_reflex_hyde_1_1", function(context)
    if not context or not context.has_speaker or not context.speaker then
        return false
    end
    local ctx = H.ctx_new(context.speaker, nil, {})
    return (((((services.turn() % 86400) / 3600) > 6) and (((services.turn() % 86400) / 3600) < 21))) == true
end)

content.add(content.Mutation {
    id = "HYDE",
    name = "Violent Monster",
    description = "Anger clouds your mind; you can't think straight, but you feel strong.",
    categories = { "MEDICAL" },
    points = -1,
    mixed_effect = true,
    valid = false,
    visibility = 8,
    ugliness = 8,
    purifiable = false,
    social_modifiers = { intimidate = 4 },
    transform = { target = "JEKYLL", active = false, moves = 10, message = "The anger subsides." },
}
    :relationship("enchantment", "INLINE_ENCH_HYDE_0")
    :reflex({
        {
            handler = "w16b_reflex_hyde_1_1",
            message_on = "As the morning comes, you return back to normal.",
            message_on_type = "good",
        },
    }))
-- WAVE16B_END
