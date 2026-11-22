local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local mutations = services.mutations
local effects = services.effects
local spells = services.spells
local needs = services.needs
local variables = services.variables
local shapeshift_armor = require("shapeshift_armor")
local blood_vitamin = id("vitamin", "human_blood_vitamin")

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function player_message(character, text, tone)
    if character.subtype == "avatar" then
        services.messages.add(services.translate(text), tone)
    end
end

local function has_trait(character, trait_name)
    return value(mutations.has_id_text(character, trait_name))
end

local function has_effect(character, effect_name)
    return value(effects.has(character, id("effect", effect_name)))
end

local function add_permanent_effect(character, effect_name)
    value(effects.add(character, id("effect", effect_name),
        services.time.duration_from_turns(1), { permanent = true }))
end

local function remove_effect(character, effect_name)
    value(effects.remove(character, id("effect", effect_name)))
end

local function deactivate_trait(character, trait_name)
    value(mutations.invoke_activation(character, id("mutation", trait_name), false))
end

local function effect_intensity(character, effect_name)
    local res = effects.get(character, id("effect", effect_name))
    if res.ok then
        return res.value.intensity
    end
    if res.error.code == "not_found" then
        return -1
    end
    error(res.error.message)
end

local function blood_amount(character)
    return value(needs.get_vitamin(character, blood_vitamin))
end

local function modify_blood(character, delta)
    value(needs.modify_vitamin(character, blood_vitamin, delta))
end

local function read_number(character, key)
    return value(variables.get_number(character, key)).value or 0
end

local function set_number(character, key, amount)
    value(variables.set(character, key, amount, { include_before = false }))
end

local function next_token(character, key)
    local token = read_number(character, key) + 1
    set_number(character, key, token)
    return token
end

local function is_current_token(context, key)
    local token = context.data and context.data.token
    return token ~= nil and read_number(context.character, key) == token
end

local function assign_activity(character, turns)
    value(services.activities.assign_timed(
        character, id("activity", "ACT_GENERIC_EOC"), services.time.duration_from_turns(turns)))
end

local function sleeping_or_torpor(character)
    return has_effect(character, "sleep")
        or has_effect(character, "narcosis")
        or has_effect(character, "effect_vampire_torpor")
end

local tier_one_traits = {
    "EYEGLEAM",
    "BLOOD_FUN",
    "STAMINAFORBLOOD",
    "COMMUNE_NIGHT",
    "VAMPIRIC_STRENGTH",
    "VAMPIRIC_RESILIENCE",
    "VAMPIRE_HEIGHTENED_SENSES",
    "VAMPIRE_HEALTH_BONUS",
    "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT",
    "VAMPIRE_SILENT_MOVE",
    "DHAMPIR_REDUCED_COLD_TEMPS",
}

local tier_two_traits = {
    "BLOODHEAL",
    "COAGULANTWEAVE",
    "VAMPIRIC_DODGE",
    "VAMPIRE_FEAR_GAZE",
    "VAMPIRE_WALK_ON_WALLS",
    "VAMPIRE_BEAST_CLAWS",
    "VAMPIRIC_STEALTH_BONUS",
    "VAMPIRE_SEE_HEAT",
    "VAMPIRE_FEIGN_DEATH",
    "VAMPIRE_BLOOD_TEMPORARY_BOOST",
    "EYEGLEAM_UPGRADE",
    "VAMPIRE_SEE_THROUGH_NIGHT_EYES",
    "BLOOD_FUN_UPGRADE",
    "VAMPIRE_SILENT_MOVE_UPGRADE",
    "DHAMPIR_FANGS",
    "DHAMPIR_SLOWFALL",
    "DHAMPIR_RESIST_DISEASE_POISON_INFECTION",
    "DHAMPIR_BLACKEN_SOUL_ARION",
}

local tier_three_traits = {
    "BLOODHASTE",
    "HYPNOTIC_GAZE",
    "MAGICFORBLOOD",
    "VAMPIRE_COMMAND_BEAST",
    "VAMPIRE_EARTH_SLUMBER",
    "VAMPIRE_CARDIO_BONUS",
    "VAMPIRE_MOTION_ALARM",
    "VAMPIRE_BONUS_HP",
    "VAMPIRE_STORE_MORE_BLOOD",
    "VAMPIRE_INSTANT_BLEED",
    "VAMPIRE_BIG_STOMACH",
    "VAMPIRE_DETECT_VAMPIRES",
    "DHAMPIR_REDUCED_PAIN",
    "DHAMPIR_MEND_WOUNDS_FASTER",
    "DHAMPIR_AVOID_EAT_SLEEP_DRINK",
}

local tier_four_traits = {
    "TRUE_VAMPIRE_POWER",
    "VAMPIRE_TORPOR",
    "VAMPIRE_DOMINATE",
    "VAMPIRE_NO_BREATHE",
    "VAMPIRE_NO_ILLNESS",
    "VAMPIRE_BAT_FORM",
    "VAMPIRE_WOLF_FORM",
    "VAMPIRE_MIST_FORM",
    "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
    "VAMPIRE_INVISIBLE_IN_DARK",
    "VAMPIRE_NO_ILLNESS_UPGRADE",
    "VAMPIRE_FORM_UPGRADE",
    "VAMPIRE_BLOOD_FOR_POTENCY",
}

local tier_five_traits = {
    "VAMPIRE_MASTER_MORTAL_MIND",
    "VAMPIRE_DISTILLATE_INNER_BLOOD",
    "VAMPIRE_SHADOW_FORM",
    "VAMPIRE_LAST_BREATH_MIST",
    "VAMPIRE_IRON_MIND",
    "VAMPIRE_BLIND_THE_SUN",
    "VAMPIRE_HEAL_IN_DARK",
    "VAMPIRE_DRINK_VAMPIRE_BLOOD",
    "VAMPIRE_GAIN_BLOOD_GIFTS",
    "VAMPIRE_LAST_BREATH_MIST_UPGRADE",
    "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE",
}

local function count_traits(character, list)
    local total = 0
    for _, trait_name in ipairs(list) do
        if has_trait(character, trait_name) then
            total = total + 1
        end
    end
    return total
end

local function maintenance_delay(character, weights, sun_burn_divisor)
    local t1 = count_traits(character, tier_one_traits)
        + effect_intensity(character, "effect_player_anathema_potency_boost")
    local t2 = count_traits(character, tier_two_traits)
    local t3 = count_traits(character, tier_three_traits)
    local t4 = count_traits(character, tier_four_traits)
        + (has_trait(character, "TRUE_VAMPIRE_POWER") and 5 or 0)
    local t5 = count_traits(character, tier_five_traits)
        + (has_trait(character, "VAMPIRE_BLOOD_FOR_POTENCY_REAL") and 10 or 0)
    local turns = services.random.native_float(0.75, 1.25) * (
        weights[1] + t1 * weights[2] + t2 * weights[3] + t3 * weights[4] + t4 * weights[5] + t5 * weights[6]
    )
    if sun_burn_divisor and has_trait(character, "ANATHEMA_WEAKNESS_SUN_BURN") then
        turns = turns / sun_burn_divisor
    end
    return math.max(1, math.modf(turns))
end

-- Dhampir need suspension
ccb.runtime.handler("dhampir_avoid_needs_on", function(context)
    local character = context.character
    if blood_amount(character) > 0 then
        set_number(character, "dhampir_avoid_eat_sleep_drink_counter", 0)
        set_number(character, "dhampir_avoid_eat_sleep_drink_long_counter", 0)
    else
        player_message(character, "You have not enough power in your blood to sustain yourself.", "bad")
        ccb.tasks.after_character_turn(character, 0, "dhampir_avoid_needs_deactivate")
    end
end)

ccb.runtime.handler("dhampir_avoid_needs_process", function(context)
    local character = context.character
    local counter = read_number(character, "dhampir_avoid_eat_sleep_drink_counter") + 1
    local long_counter = read_number(character, "dhampir_avoid_eat_sleep_drink_long_counter") + 1
    set_number(character, "dhampir_avoid_eat_sleep_drink_long_counter", long_counter)

    if value(services.creatures.snapshot(character)).outside and services.time.now():is_day() then
        local weather_id = services.weather.current().weather.value
        if (weather_id == "sunny" or weather_id == "clear")
            and (counter == 15 or counter == 30 or counter == 45)
        then
            modify_blood(character, -1)
        end
    end

    if counter >= 60 then
        modify_blood(character, -1)
        counter = 0
        if value(needs.get(character)).stored_kcal < 118000 then
            value(needs.modify_calories(character, 2, false))
        end
        value(needs.set(character, { sleep_deprivation = 0 }))
    end
    set_number(character, "dhampir_avoid_eat_sleep_drink_counter", counter)

    if blood_amount(character) <= 0 then
        ccb.tasks.after_character_turn(character, 0, "dhampir_avoid_needs_deactivate")
    end
end)

ccb.runtime.handler("dhampir_avoid_needs_off", function(context)
    local character = context.character
    player_message(character,
        "You feel a wave of tiredness as you allow mortal needs to assert their will once again.", "bad")
    local long_counter = read_number(character, "dhampir_avoid_eat_sleep_drink_long_counter")
    local sleep_add = math.modf(math.min(long_counter / 200, 700))
    if sleep_add > 0 then
        local cur_sleepiness = value(needs.get(character)).sleepiness
        value(needs.set(character, { sleepiness = cur_sleepiness + sleep_add }))
    end
    local kcal_weariness = math.modf(math.min(long_counter * 0.06, 10000))
    if kcal_weariness > 0 then
        value(needs.modify_calories(character, -kcal_weariness, false))
        value(needs.modify_calories(character, kcal_weariness, true))
    end
end)

ccb.runtime.handler("dhampir_avoid_needs_deactivate", function(context)
    deactivate_trait(context.character, "DHAMPIR_AVOID_EAT_SLEEP_DRINK")
end)

-- Sustained vampire blood powers
local function is_power_active(character, spec)
    if spec.effect then
        return has_effect(character, spec.effect)
    end
    return has_trait(character, spec.active_trait)
end

local function clear_power_state(character, spec)
    if spec.effect then
        remove_effect(character, spec.effect)
    end
    if spec.extra_effects then
        for _, extra in ipairs(spec.extra_effects) do
            remove_effect(character, extra)
        end
    end
    if spec.active_trait then
        value(mutations.erase(character, id("mutation", spec.active_trait)))
    end
end

local function stop_power(character, spec)
    next_token(character, spec.prefix .. "_token")
    if is_power_active(character, spec) then
        if spec.msg_off then
            player_message(character, spec.msg_off, "neutral")
        end
        clear_power_state(character, spec)
    elseif spec.extra_effects then
        for _, extra in ipairs(spec.extra_effects) do
            remove_effect(character, extra)
        end
    end
end

local function start_power(character, spec)
    if is_power_active(character, spec) then
        stop_power(character, spec)
        return
    end
    if blood_amount(character) < spec.min_blood then
        player_message(character, spec.msg_no_blood, "bad")
        ccb.tasks.after_character_turn(character, 0, spec.prefix .. "_deactivate")
        return
    end
    assign_activity(character, spec.act)
    modify_blood(character, -spec.init_cost)
    if spec.effect then
        add_permanent_effect(character, spec.effect)
    end
    if spec.active_trait then
        value(mutations.replace(character, id("mutation", spec.active_trait)))
    end
    if spec.on_start then
        spec.on_start(character)
    end
    if spec.msg_on then
        player_message(character, spec.msg_on, "good")
    end
    local token = next_token(character, spec.prefix .. "_token")
    local delay = maintenance_delay(character, spec.weights, spec.sun_burn_divisor)
    ccb.tasks.after_character_turn(character, delay, spec.prefix .. "_maintain", { token = token })
end

local function register_blood_power(spec)
    local token_key = spec.prefix .. "_token"

    ccb.runtime.handler(spec.prefix .. "_on", function(context)
        start_power(context.character, spec)
    end)

    ccb.runtime.handler(spec.prefix .. "_off", function(context)
        stop_power(context.character, spec)
    end)

    ccb.runtime.handler(spec.prefix .. "_deactivate", function(context)
        deactivate_trait(context.character, spec.mutation)
    end)

    ccb.runtime.handler(spec.prefix .. "_maintain", function(context)
        if not is_current_token(context, token_key) then
            return
        end
        local character = context.character
        if not is_power_active(character, spec) then
            return
        end
        if spec.skip_maint_trait and has_trait(character, spec.skip_maint_trait) then
            return
        end
        if blood_amount(character) >= spec.min_blood and not sleeping_or_torpor(character) then
            modify_blood(character, -spec.maint_cost)
            player_message(character, spec.msg_maint, "mixed")
            local delay = maintenance_delay(character, spec.weights, spec.sun_burn_divisor)
            ccb.tasks.after_character_turn(character, delay, spec.prefix .. "_maintain",
                { token = context.data.token })
        else
            if blood_amount(character) < spec.min_blood then
                player_message(character, spec.msg_maint_fail, "bad")
            end
            next_token(character, token_key)
            clear_power_state(character, spec)
            deactivate_trait(character, spec.mutation)
        end
    end)
end

local bloodhaste_spec = {
    mutation = "BLOODHASTE",
    prefix = "vampire_bloodhaste",
    min_blood = -500,
    act = 2,
    init_cost = 750,
    maint_cost = 375,
    weights = { 60, 5, 12, 20, 30, 40 },
    effect = "haste_vampire",
    extra_effects = { "haste_vampire_water_running" },
    on_start = function(character)
        if has_trait(character, "BLOODHASTE_REFINEMENT_WATER_RUN")
            and not has_trait(character, "VAMPIRE_WEAKNESS_VAST_WATER_BURN")
        then
            add_permanent_effect(character, "haste_vampire_water_running")
        end
    end,
    msg_no_blood = "You don't have enough blood to activate blood-driven speed.",
    msg_maint = "You feel a momentary warmth as you maintain your superhuman speed.",
    msg_maint_fail = "You don't have enough blood to maintain your blood-driven speed.",
}

local blood_power_specs = {
    {
        mutation = "EYEGLEAM",
        prefix = "vampire_eyegleam",
        min_blood = -500,
        act = 0.25,
        init_cost = 100,
        maint_cost = 50,
        weights = { 1000, 100, 225, 350, 500, 750 },
        effect = "eyegleam",
        extra_effects = { "eyegleam_craft_in_darkness" },
        skip_maint_trait = "EYEGLEAM_UPGRADE",
        on_start = function(character)
            if effect_intensity(character, "vampire_virus_ascendant") == 1
                or effect_intensity(character, "vampire_virus_post_mortal") == 1
            then
                add_permanent_effect(character, "eyegleam_craft_in_darkness")
            end
        end,
        msg_on = "Your eyes gleam red momentarily as they drink in all available light.",
        msg_no_blood = "You don't have enough blood to activate your gleaming eyes.",
        msg_off = "Your eyes lose their reddish glint as the darkness rolls back in.",
        msg_maint = "You feel a momentary warmth as you channel stolen blood into your eyes.",
        msg_maint_fail = "You don't have enough blood to maintain your gleaming eyes.",
    },
    {
        mutation = "VAMPIRIC_STRENGTH",
        prefix = "vampire_strength",
        min_blood = -500,
        act = 0.25,
        init_cost = 150,
        maint_cost = 75,
        weights = { 750, 100, 200, 300, 400, 500 },
        effect = "effect_vampiric_strength",
        msg_no_blood = "You don't have enough blood to activate vigor mortis.",
        msg_off = "Your muscles weaken as the stolen blood leaves them.",
        msg_maint = "You feel a momentary warmth as you channel stolen blood into your muscles.",
        msg_maint_fail = "You don't have enough blood to maintain your vigor mortis.",
    },
    {
        mutation = "VAMPIRIC_RESILIENCE",
        prefix = "vampire_resilience",
        min_blood = -500,
        act = 0.25,
        init_cost = 150,
        maint_cost = 75,
        weights = { 750, 100, 200, 300, 400, 500 },
        effect = "effect_vampiric_resilience",
        extra_effects = { "effect_vampire_resilience_flesh_of_marble" },
        on_start = function(character)
            if has_trait(character, "VAMPIRIC_RESILIENCE_REFINEMENT_INVINCIBILITY") then
                add_permanent_effect(character, "effect_vampire_resilience_flesh_of_marble")
            end
        end,
        msg_on = "You feel a surge of power as blood fortifies your flesh.",
        msg_no_blood = "You don't have enough blood to activate sanguine resilience.",
        msg_off = "Your flesh loses its resilience as the stolen blood leaves it.",
        msg_maint = "You feel a momentary warmth as you channel stolen blood into your flesh.",
        msg_maint_fail = "You don't have enough blood to maintain your sanguine resilience.",
    },
    {
        mutation = "COAGULANTWEAVE",
        prefix = "vampire_coagulantweave",
        min_blood = -500,
        act = 0.75,
        init_cost = 500,
        maint_cost = 250,
        weights = { 300, 33, 75, 125, 200, 275 },
        effect = "blood_weave",
        on_start = function(character)
            remove_effect(character, "bleed")
        end,
        msg_no_blood = "You don't have enough blood to activate coagulant weave.",
        msg_off = "Your blood flows more freely as your grip on it relaxes.",
        msg_maint = "You feel a momentary warmth as you maintain your grip on your stolen blood.",
        msg_maint_fail = "You don't have enough blood to maintain your coagulant weave.",
    },
    {
        mutation = "VAMPIRIC_DODGE",
        prefix = "vampire_dodge",
        min_blood = -500,
        act = 0.75,
        init_cost = 250,
        maint_cost = 125,
        weights = { 60, 5, 12, 20, 30, 40 },
        effect = "effect_vampiric_dodge",
        msg_no_blood = "You don't have enough blood to activate flow like blood.",
        msg_off = "Your movements slow as your lose your preternatural avoidance.",
        msg_maint = "You feel a momentary warmth as you maintain your preternatural dodging.",
        msg_maint_fail = "You don't have enough blood to maintain your flow like blood.",
    },
    {
        mutation = "VAMPIRIC_STEALTH_BONUS",
        prefix = "vampire_stealth",
        min_blood = -500,
        act = 0.75,
        init_cost = 100,
        maint_cost = 50,
        weights = { 300, 15, 20, 35, 55, 80 },
        effect = "effect_vampiric_stealth_bonus",
        msg_no_blood = "You don't have enough blood to activate your cloak of shadows.",
        msg_off = "As your cloak of shadows fades, your presence becomes more obvious.",
        msg_maint = "You feel a momentary warmth as you maintain your cloak of shadows.",
        msg_maint_fail = "You don't have enough blood to maintain your cloak of shadows.",
    },
    {
        mutation = "VAMPIRE_BEAST_CLAWS",
        prefix = "vampire_beast_claws",
        min_blood = -500,
        act = 0.75,
        init_cost = 125,
        maint_cost = 62,
        weights = { 800, 60, 100, 150, 225, 300 },
        active_trait = "VAMPIRE_BEAST_CLAWS_active",
        msg_no_blood = "You don't have enough blood to activate your claws of the beast.",
        msg_off = "Your fingers warp and twist as your claws vanish.",
        msg_maint = "You feel a momentary warmth as you maintain your sharp claws.",
        msg_maint_fail = "You don't have enough blood to maintain your claws of the beast.",
    },
    bloodhaste_spec,
    {
        mutation = "VAMPIRE_RENDING_TEETH",
        prefix = "vampire_rending_teeth",
        min_blood = -500,
        act = 0.75,
        init_cost = 200,
        maint_cost = 100,
        weights = { 800, 60, 100, 150, 225, 300 },
        active_trait = "VAMPIRE_RENDING_TEETH_active",
        msg_no_blood = "You don't have enough blood to activate your rending jaws.",
        msg_off = "Your teeth and jaw recede back to a normal human size.",
        msg_maint = "You feel a momentary warmth as you maintain your rending jaws.",
        msg_maint_fail = "You don't have enough blood to maintain your rending jaws.",
    },
    {
        mutation = "VAMPIRE_BLIND_THE_SUN",
        prefix = "vampire_blind_the_sun",
        min_blood = 0,
        act = 1.25,
        init_cost = 1000,
        maint_cost = 700,
        weights = { 20, 2, 5, 8, 12, 15 },
        sun_burn_divisor = 100,
        effect = "vampire_blind_the_sun",
        on_start = function(character)
            if has_trait(character, "ANATHEMA_WEAKNESS_SUN_BURN") then
                player_message(character,
                    "Using your mastery over the Shadowed Path, you form a sun-proof shield of darkness around you.  But you can already see the hateful sun burning through the darkness; you had better find shelter immediately.",
                    "mixed")
            else
                player_message(character,
                    "Using your mastery over the Shadowed Path, you form a sun-proof shield of darkness around you.",
                    "good")
            end
        end,
        msg_no_blood = "You don't have enough blood to shroud yourself from the sun.",
        msg_off = "The darkness shielding you fades.",
        msg_maint = "You feel a momentary warmth as you maintain your shrouding shadows.",
        msg_maint_fail = "You don't have enough blood to maintain your shrouding shadows.",
    },
}

for _, spec in ipairs(blood_power_specs) do
    register_blood_power(spec)
end

-- Obsolete spell fallback kept for legacy saves.
ccb.runtime.handler("vampire_bloodhaste_spell", function(payload)
    start_power(payload.caster, bloodhaste_spec)
end)

ccb.content.add(content.Spell {
    id = "spell_blood_haste",
    name = content.text("Blood-Driven Speed"),
    description = content.text("Stolen blood allows you to move as quick as lightning, scything through your enemies or outrunning a car."),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    flags = { "NO_HANDS", "SILENT", "NO_FAIL", "NO_PROJECTILE" },
    skill = "deduction",
    spell_class = "VAMPIRE",
    shape = "blast",
    base_casting_time = 200,
}:lua_impact("vampire_bloodhaste_spell"))

local function scale_calories(character, factor)
    local current = value(needs.get(character)).stored_kcal
    local delta = math.modf(current * factor - current)
    value(needs.modify_calories(character, delta, true))
end

-- Feign death
ccb.runtime.handler("vampire_feign_death_off", function(context)
    local character = context.character
    local seen = false
    local offset = 0
    while true do
        local page = services.creatures.nearby(character, { radius = 45, limit = 256, offset = offset })
        for _, entry in ipairs(page.items) do
            if value(services.creatures.can_see(entry.handle, character)) then
                seen = true
                break
            end
        end
        if seen or page.returned == 0 then
            break
        end
        offset = offset + page.returned
        if offset >= page.total then
            break
        end
    end
    if seen then
        value(effects.add(character, id("effect", "effect_vampire_feign_death_ended"),
            services.time.duration_from_turns(services.random.native_int(180, 360))))
    end
end)

-- Shapeshift forms
local form_entries = {
    { key = "bat", mutation = "VAMPIRE_BAT_FORM", active_trait = "VAMPIRE_BAT_FORM_TRAITS" },
    { key = "wolf", mutation = "VAMPIRE_WOLF_FORM", active_trait = "VAMPIRE_WOLF_FORM_TRAITS" },
    { key = "mist", mutation = "VAMPIRE_MIST_FORM", active_trait = "VAMPIRE_MIST_FORM_TRAITS" },
    { key = "shadow", mutation = "VAMPIRE_SHADOW_FORM", active_trait = "VAMPIRE_SHADOW_FORM_TRAITS" },
}

local function cancel_other_forms(character, keep_key)
    for _, entry in ipairs(form_entries) do
        if entry.key ~= keep_key and has_trait(character, entry.active_trait) then
            deactivate_trait(character, entry.mutation)
        end
    end
end

local function leave_shadow_form(character)
    if not has_trait(character, "VAMPIRE_SHADOW_FORM_TRAITS") then
        return
    end
    player_message(character, "Your eyes stop glowing and the shadows surrounding you dissipate.", "neutral")
    value(mutations.erase(character, id("mutation", "VAMPIRE_SHADOW_FORM_TRAITS")))
end

local function leave_bat_form(character)
    if not has_trait(character, "VAMPIRE_BAT_FORM_TRAITS") then
        return
    end
    leave_shadow_form(character)
    ccb.tasks.after_character_turn(character, 0, "vampire_shadow_form_deactivate")
    player_message(character, "Your wings recede and you land on now-humanoid legs.", "neutral")
    value(mutations.erase(character, id("mutation", "VAMPIRE_BAT_FORM_TRAITS")))
    value(mutations.erase(character, id("mutation", "ECHOLOCATION")))
    scale_calories(character, 4)
    value(spells.set_level(character, id("spell", "vampire_bat_form_fly_upward"), -1))
    shapeshift_armor.restore(character)
end

ccb.runtime.handler("vampire_bat_form_on", function(context)
    local character = context.character
    if has_trait(character, "VAMPIRE_BAT_FORM_TRAITS") then
        leave_bat_form(character)
        return
    end
    if blood_amount(character) < -500 then
        player_message(character, "You don't have enough blood to transform into a bat.", "bad")
        ccb.tasks.after_character_turn(character, 0, "vampire_bat_form_deactivate")
        return
    end
    cancel_other_forms(character, "bat")
    assign_activity(character, 1.5)
    modify_blood(character, has_trait(character, "VAMPIRE_FORM_UPGRADE") and -300 or -600)
    shapeshift_armor.subsume(character)
    value(mutations.replace(character, id("mutation", "VAMPIRE_BAT_FORM_TRAITS")))
    value(mutations.replace(character, id("mutation", "ECHOLOCATION")))
    scale_calories(character, 0.25)
    if has_trait(character, "VAMPIRE_BAT_FORM_REFINEMENT_SWARM") then
        player_message(character,
            "Your body splits into a multitude of bats and as your transformation completes, you take to the air on many wings.",
            "good")
    else
        player_message(character,
            "Your fingers lengthen as flaps of skin grow between them and as your legs shorten, you take to the air.",
            "good")
    end
end)

ccb.runtime.handler("vampire_bat_form_off", function(context)
    leave_bat_form(context.character)
end)

ccb.runtime.handler("vampire_bat_form_deactivate", function(context)
    deactivate_trait(context.character, "VAMPIRE_BAT_FORM")
end)

local function leave_wolf_form(character)
    if not has_trait(character, "VAMPIRE_WOLF_FORM_TRAITS") then
        return
    end
    player_message(character, "Your fur disappears and you walk once again on two legs.", "neutral")
    value(mutations.erase(character, id("mutation", "VAMPIRE_WOLF_FORM_TRAITS")))
    shapeshift_armor.restore(character)
end

ccb.runtime.handler("vampire_wolf_form_on", function(context)
    local character = context.character
    if has_trait(character, "VAMPIRE_WOLF_FORM_TRAITS") then
        leave_wolf_form(character)
        return
    end
    if blood_amount(character) < -500 then
        player_message(character, "You don't have enough blood to transform into a wolf.", "bad")
        ccb.tasks.after_character_turn(character, 0, "vampire_wolf_form_deactivate")
        return
    end
    cancel_other_forms(character, "wolf")
    assign_activity(character, 1.5)
    shapeshift_armor.subsume(character)
    modify_blood(character, has_trait(character, "VAMPIRE_FORM_UPGRADE") and -300 or -600)
    value(mutations.replace(character, id("mutation", "VAMPIRE_WOLF_FORM_TRAITS")))
    player_message(character,
        "Your nose pushes out into a muzzle as you fall forward on all fours and let out a snarl.", "good")
end)

ccb.runtime.handler("vampire_wolf_form_off", function(context)
    leave_wolf_form(context.character)
end)

ccb.runtime.handler("vampire_wolf_form_deactivate", function(context)
    deactivate_trait(context.character, "VAMPIRE_WOLF_FORM")
end)

local function leave_mist_form(character)
    if not has_trait(character, "VAMPIRE_MIST_FORM_TRAITS") then
        return
    end
    player_message(character, "You reconstitute yourself from the billowing mists.", "neutral")
    remove_effect(character, "effect_vampire_mist_form")
    remove_effect(character, "incorporeal")
    value(mutations.erase(character, id("mutation", "VAMPIRE_MIST_FORM_TRAITS")))
    value(spells.set_level(character, id("spell", "vampire_mist_form_pass_through_doors_and_windows"), -1))
end

ccb.runtime.handler("vampire_mist_form_on", function(context)
    local character = context.character
    if has_trait(character, "VAMPIRE_MIST_FORM_TRAITS") then
        leave_mist_form(character)
        return
    end
    if blood_amount(character) < -500 then
        player_message(character, "You don't have enough blood to transform into mist.", "bad")
        ccb.tasks.after_character_turn(character, 0, "vampire_mist_form_deactivate")
        return
    end
    cancel_other_forms(character, "mist")
    assign_activity(character, 1.5)
    modify_blood(character, has_trait(character, "VAMPIRE_FORM_UPGRADE") and -300 or -600)
    value(mutations.replace(character, id("mutation", "VAMPIRE_MIST_FORM_TRAITS")))
    add_permanent_effect(character, "effect_vampire_mist_form")
    add_permanent_effect(character, "incorporeal")
    value(spells.set_level(character, id("spell", "vampire_mist_form_pass_through_doors_and_windows"), 0))
    player_message(character, "Your body falls apart into billowing mist.", "good")
end)

ccb.runtime.handler("vampire_mist_form_off", function(context)
    leave_mist_form(context.character)
end)

ccb.runtime.handler("vampire_mist_form_deactivate", function(context)
    deactivate_trait(context.character, "VAMPIRE_MIST_FORM")
end)

ccb.runtime.handler("vampire_mist_form_move_cost", function()
    local character = services.creatures.avatar()
    if not has_trait(character, "VAMPIRE_MIST_FORM_TRAITS") then
        return
    end
    if blood_amount(character) >= -500 then
        modify_blood(character, -2)
    else
        player_message(character, "You don't have enough blood to maintain your mist form.", "bad")
        leave_mist_form(character)
        ccb.tasks.after_character_turn(character, 0, "vampire_mist_form_deactivate")
    end
end)
ccb.runtime.on("game:avatar_moves", "vampire_mist_form_move_cost")

ccb.runtime.handler("vampire_shadow_form_on", function(context)
    local character = context.character
    if has_trait(character, "VAMPIRE_SHADOW_FORM_TRAITS") then
        leave_shadow_form(character)
        return
    end
    if blood_amount(character) < 500 then
        player_message(character, "You don't have enough blood to shroud yourself in shadow.", "bad")
        ccb.tasks.after_character_turn(character, 0, "vampire_shadow_form_deactivate")
        return
    end
    cancel_other_forms(character, "shadow")
    assign_activity(character, 1.5)
    modify_blood(character, has_trait(character, "VAMPIRE_FORM_UPGRADE") and -400 or -800)
    value(mutations.replace(character, id("mutation", "VAMPIRE_SHADOW_FORM_TRAITS")))
    player_message(character, "Shadows surround you until only your now-glowing eyes remain visible.", "good")
end)

ccb.runtime.handler("vampire_shadow_form_off", function(context)
    leave_shadow_form(context.character)
end)

ccb.runtime.handler("vampire_shadow_form_deactivate", function(context)
    deactivate_trait(context.character, "VAMPIRE_SHADOW_FORM")
end)

ccb.runtime.handler("vampire_shadow_form_process", function(context)
    local character = context.character
    if not has_trait(character, "VAMPIRE_SHADOW_FORM_TRAITS") then
        return
    end
    if blood_amount(character) >= -500 and not sleeping_or_torpor(character) then
        modify_blood(character, -5)
    else
        if blood_amount(character) < -500 then
            player_message(character, "You don't have enough blood to maintain the shadows surrounding you.", "bad")
        end
        leave_shadow_form(character)
        ccb.tasks.after_character_turn(character, 0, "vampire_shadow_form_deactivate")
    end
end)
