local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local effects = services.effects
local mutations = services.mutations
local needs = services.needs
local random = services.random
local variables = services.variables

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function get_var(character, key)
    return checked(variables.get_number(character, key)).value or 0
end

local function set_var(character, key, value)
    checked(variables.set(character, key, value, { include_before = false }))
end

local function vitamin(character, name)
    return checked(needs.get_vitamin(character, id("vitamin", name)))
end

local function has_effect(character, name)
    return checked(effects.has(character, id("effect", name)))
end

local function lose_effect(character, name)
    checked(effects.remove(character, id("effect", name)))
end

local function has_trait(character, name)
    return checked(mutations.has_id_text(character, name))
end

local function add_effect(character, name, turns, opts)
    local result = effects.add(character, id("effect", name), services.time.duration_from_turns(turns), opts)
    if not result.ok and result.error.code ~= "rejected" then
        checked(result)
    end
end

local function can_see(character)
    return checked(services.characters.snapshot(character)).senses.can_see
end

local function show_message(character, text, severity, popup)
    if character.subtype ~= "avatar" or not text or text == "" then
        return
    end
    if popup then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
    end
    if severity then
        services.messages.add(text, severity)
    else
        services.messages.add(text)
    end
end

local function show_snippet(character, category, severity, popup)
    show_message(character, services.snippets.native_random(category), severity, popup)
end

local function show_expanded(character, tag, severity, popup)
    show_message(character, services.snippets.native_expand(tag), severity, popup)
end

local function ensure_limb_progress_timer(character)
    if get_var(character, "limb_progress_timer") == 0 then
        set_var(character, "limb_progress_timer", services.time.now().turn)
    end
end

local function ready_for_progress(character)
    return (services.time.now().turn - get_var(character, "limb_progress_timer")) >= 12 * 3600
end

local function trigger_eye_side_effect(character)
    local pick = random.weighted_index({ 1, 5, 2 })
    if pick == 1 then
        if random.one_in(5) and can_see(character) then
            show_snippet(character, "<eyes_blind>", "bad", false)
            add_effect(character, "blind", random.native_int(2, 5))
        end
    elseif pick == 2 then
        if can_see(character) then
            show_snippet(character, "<eyes_glare>", "bad", false)
            add_effect(character, "glare", random.native_int(60, 300))
        end
    elseif pick == 3 then
        if can_see(character) then
            show_snippet(character, "<eyes_stun>", "bad", true)
            add_effect(character, "stunned", random.native_int(5, 30))
        end
    end
end

local function trigger_arm_pain(character)
    show_snippet(character, "<arm_pain>", nil, false)
    local pain = checked(services.creatures.snapshot(character)).perceived_pain
    checked(needs.modify_pain(character, pain + 5))
end

local function trigger_arm_itch(character)
    show_snippet(character, "<arm_itch>", nil, false)
    add_effect(character, "formication", 3600, { body_part = id("body_part", "arm_l") })
    add_effect(character, "formication", 3600, { body_part = id("body_part", "arm_r") })
end

local function trigger_arm_drop(character)
    if checked(services.creatures.snapshot(character)).has_weapon then
        show_snippet(character, "<arm_drop>", nil, false)
        if character.subtype == "avatar" then
            checked(services.characters.drop_weapon(character))
        end
    end
end

ccb.runtime.handler("process_pre_eyes_insect", function(context)
    local c = context.character
    ensure_limb_progress_timer(c)
    local insect = vitamin(c, "mutagen_insect")
    local mut = vitamin(c, "mutagen")
    local progress = get_var(c, "progress_pre_eyes_insect")
    if insect >= 300 and mut >= 300 and progress >= 3 and has_effect(c, "sleep") and ready_for_progress(c) then
        checked(mutations.mutate_towards(c, id("mutation", "EYES_INSECT"), id("mutation_category", "INSECT"), true))
        if has_trait(c, "EYES_INSECT") then
            show_expanded(c, "<insect_eye_success>", nil, true)
            set_var(c, "progress_pre_eyes_insect", 0)
            lose_effect(c, "sleep")
        else
            show_snippet(c, "<insect_failure>", "bad", false)
        end
    elseif has_effect(c, "sleep") and random.native_probability(insect + mut, 1000) and ready_for_progress(c) then
        show_snippet(c, "<insect_eye_dream>", nil, false)
        lose_effect(c, "sleep")
        set_var(c, "progress_pre_eyes_insect", progress + 1)
        set_var(c, "limb_progress_timer", services.time.now().turn)
    else
        if random.one_in(5) then
            show_snippet(c, "<insect_failure>", "bad", false)
        end
        if random.one_in(10) then
            trigger_eye_side_effect(c)
        end
    end
end)

ccb.runtime.handler("process_eyes_insect", function(context)
    local c = context.character
    local insect = vitamin(c, "mutagen_insect")
    local mut = vitamin(c, "mutagen")
    local progress = get_var(c, "progress_eyes_insect")
    if insect >= 500 and mut >= 500 and progress >= 5 and has_effect(c, "sleep") and ready_for_progress(c) then
        checked(mutations.mutate_towards(c, id("mutation", "EYES_INSECT_2"), id("mutation_category", "INSECT"), true))
        if has_trait(c, "EYES_INSECT_2") then
            show_expanded(c, "<insect_eye_2_success>", nil, true)
            set_var(c, "progress_eyes_insect", 0)
            services.gameplay.environment.add_field_area(
                checked(services.creatures.snapshot(c)).position,
                "fd_blood_insect",
                { radius = 0 })
            lose_effect(c, "sleep")
        else
            show_snippet(c, "<insect_failure>", "bad", false)
        end
    elseif has_effect(c, "sleep") and random.native_probability(insect + mut, 1200) and ready_for_progress(c) then
        show_snippet(c, "<insect_eye_dream>", nil, false)
        lose_effect(c, "sleep")
        set_var(c, "progress_eyes_insect", progress + 1)
        set_var(c, "limb_progress_timer", services.time.now().turn)
    else
        if random.one_in(8) then
            show_snippet(c, "<insect_failure>", "bad", false)
        end
        if random.one_in(15) then
            trigger_eye_side_effect(c)
        end
    end
end)

ccb.runtime.handler("process_pre_arm_feathers", function(context)
    local c = context.character
    ensure_limb_progress_timer(c)
    local bird = vitamin(c, "mutagen_bird")
    local raptor = vitamin(c, "mutagen_raptor")
    local mut = vitamin(c, "mutagen")
    local progress = get_var(c, "progress_pre_arm_feathers")
    if (bird >= 200 or raptor >= 200) and mut >= 300 and progress >= 1
        and has_effect(c, "sleep") and ready_for_progress(c) then
        local cat = (bird >= raptor) and "BIRD" or "RAPTOR"
        checked(mutations.mutate_towards(c, id("mutation", "ARM_FEATHERS"), id("mutation_category", cat), true))
        if has_trait(c, "ARM_FEATHERS") then
            show_expanded(c, "<arm_feathers_success>", nil, true)
            set_var(c, "progress_pre_arm_feathers", 0)
            lose_effect(c, "sleep")
        else
            local fail = (vitamin(c, "mutagen_bird") >= vitamin(c, "mutagen_raptor"))
                and "<bird_failure>" or "<raptor_failure>"
            show_snippet(c, fail, "bad", false)
        end
    elseif has_effect(c, "sleep") and random.native_probability(bird + raptor + mut, 1500)
        and ready_for_progress(c) then
        show_snippet(c, "<arm_feathers_dream>", nil, true)
        lose_effect(c, "sleep")
        set_var(c, "progress_pre_arm_feathers", progress + 1)
        set_var(c, "limb_progress_timer", services.time.now().turn)
    else
        if random.one_in(5) then
            show_snippet(c, (bird >= raptor) and "<bird_failure>" or "<raptor_failure>", "bad", false)
        end
        if random.one_in(10) then
            local pick = random.weighted_index({ 2, 5 })
            if pick == 1 then
                trigger_arm_pain(c)
            elseif pick == 2 then
                trigger_arm_itch(c)
            end
        end
    end
end)

ccb.runtime.handler("process_arm_feathers", function(context)
    local c = context.character
    local bird = vitamin(c, "mutagen_bird")
    local mut = vitamin(c, "mutagen")
    local progress = get_var(c, "progress_wings_bird")
    if bird >= 300 and mut >= 300 and progress >= 3 and has_effect(c, "sleep") and ready_for_progress(c) then
        checked(mutations.mutate_towards(c, id("mutation", "WINGS_BIRD"), id("mutation_category", "BIRD"), true))
        if has_trait(c, "WINGS_BIRD") then
            show_expanded(c, "<wings_bird_success>", nil, true)
            set_var(c, "progress_wings_bird", 0)
            lose_effect(c, "sleep")
        else
            show_snippet(c, "<bird_failure>", "bad", false)
        end
    elseif has_effect(c, "sleep") and random.native_probability(bird, 400) and mut >= 300
        and has_trait(c, "THRESH_BIRD") and ready_for_progress(c) then
        show_snippet(c, "<wings_bird_dream>", nil, false)
        lose_effect(c, "sleep")
        set_var(c, "progress_wings_bird", progress + 1)
        set_var(c, "limb_progress_timer", services.time.now().turn)
    elseif bird > 200
        and (has_trait(c, "THRESH_BIRD") or not checked(services.characters.has_flag(c, id("json_flag", "MUTATION_THRESHOLD")))) then
        if random.one_in(5) then
            show_snippet(c, "<bird_failure>", "bad", false)
        end
        if random.one_in(10) then
            local pick = random.weighted_index({ 1, 2, 5 })
            if pick == 1 then
                trigger_arm_drop(c)
            elseif pick == 2 then
                trigger_arm_pain(c)
            elseif pick == 3 then
                trigger_arm_itch(c)
            end
        end
    end
end)

ccb.runtime.handler("activate_avian_leap", function(context)
    local c = context.character
    if checked(needs.get(c)).stamina > 0 then
        checked(services.characters.adjust(c, { moves = -100 }))
        checked(services.characters.cast_spell(c, id("spell", "spell_avian_leap"), {
            targeted = true,
            message = services.translate("You jump at your target with your talons up front, attempting to deal devastating damage to your target."),
        }))
    elseif c.subtype == "avatar" then
        services.messages.add(services.translate("Your legs are too tired to perform a jump."), "bad")
    end
end)
