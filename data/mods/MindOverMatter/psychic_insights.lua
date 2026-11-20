local ccb = require("ccb")
local services = ccb.services
local tasks = ccb.tasks
local state = ccb.state.character
local id = services.types.id
local knacks_only = ccb.content.is_mod_active("mom_knacks_only")

local schools = {
    { "biokinesis", "BIOKINETIC" },
    { "clairsentience", "CLAIRSENTIENT" },
    { "electrokinesis", "ELECTROKINETIC" },
    { "photokinesis", "PHOTOKINETIC" },
    { "pyrokinesis", "PYROKINETIC" },
    { "telekinesis", "TELEKINETIC" },
    { "telepathy", "TELEPATH" },
    { "teleportation", "TELEPORTER" },
    { "vitakinesis", "VITAKINETIC" },
}

local blocking_effects = {
    "sleep", "effect_psi_learning_new_power", "effect_vitakin_wakeful_resting", "infected",
    "spores", "taint", "visuals", "hallu", "motor_seizure", "frostbite", "blisters", "formication",
    "pre_common_cold", "common_cold", "pre_flu", "flu", "pre_conjunctivitis_viral",
    "conjunctivitis_viral", "pre_conjunctivitis_bacterial", "conjunctivitis_bacterial", "asthma",
    "brainworms", "bloodworms", "grabbed", "lack_sleep", "sleep_deprived", "under_operation", "zapped",
    "electrocuted", "anemia", "redcells_anemia", "scurvy", "toxin_buildup", "bad_food_ennui",
    "hypovolemia", "disabled", "foodpoison", "venom_pain", "venom_dmg", "badpoison", "onfire",
    "dazed", "stunned",
}

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function psionic(character)
    for _, school in ipairs(schools) do
        if has_trait(character, school[2]) then return true end
    end
    return false
end

local function can_study(character)
    local whole_body = id("body_part", "bp_null")
    for _, effect in ipairs(blocking_effects) do
        if checked(services.effects.has(character, id("effect", effect), whole_body, -1)) then
            return false
        end
    end
    return true
end

local function counter(character)
    return checked(services.needs.get_vitamin(character, id("vitamin", "vitamin_psi_learning_counter")))
end

local function set_counter(character, amount)
    checked(services.needs.set_vitamin(character, id("vitamin", "vitamin_psi_learning_counter"), amount))
end

local function scalar(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function try_insight(character, rule)
    local function level(spell)
        return checked(services.spells.effective_level(character, spell))
    end
    if not rule.roll_before_counter and counter(character) ~= 1 then return false end

    local random_insight = rule.chance and services.random.native_probability(1, rule.chance)
    if not random_insight and not (rule.meets and rule.meets(level)) then return false end
    if rule.roll_before_counter and counter(character) ~= 1 then return false end

    if not can_study(character) or level(rule.spell) > 0 then return false end
    local recipe = id("recipe", rule.recipe or ("practice_" .. rule.spell))
    -- The original knowledge gate checks the avatar even when an NPC earns the recipe.
    if checked(services.recipes.knows(services.characters.avatar(), recipe)) then return false end
    set_counter(character, 0)
    checked(services.recipes.learn(character, recipe))
    if character.subtype == "avatar" then
        local text = rule.message()
        services.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text, "neutral")
    end
    return true
end

-- A character-ready pass can seed every timer at once. Share the interval
-- inputs within that pass only; stats, proficiencies and world settings can change between turns.
local function learning_delay(character, tier, school, cache)
    if not cache.intelligence then
        local intelligence = checked(services.characters.snapshot(character, 1)).stats.intelligence
        cache.intelligence = math.max(1 - (intelligence + 23.33) / 33.33 + 1, 0.4)
    end
    local modifier = cache[school]
    if not modifier then
        if school == "insight" then
            local skill = math.modf(checked(services.skills.level(character, "metaphysics")))
            modifier = math.max(0.75, math.min(1, 1 - ((skill - 4) + 20) / 21 + 1))
        else
            modifier = checked(services.proficiencies.has_id_text(character, "prof_contemplation_" .. school))
                and 0.8 or 1
        end
        cache[school] = modifier
    end
    local prefix = "global_" .. tier .. "_power_learning_time_"
    local function turns(bound)
        local key = prefix .. bound
        if cache[key] == nil then
            cache[key] = checked(services.variables.get_global_number(key)).value or 0
        end
        return math.modf(cache[key] * cache.intelligence * modifier)
    end
    local lo, hi = turns("low"), turns("high")
    return services.random.native_int(math.min(lo, hi), math.max(lo, hi))
end

local awakening = "initial_psychic_awakening_odds"
local counter_due = "refresh_psychic_insight_counter"
local initialized = "has_initial_awakening_countup_set"

local function queue(character, handler, delay)
    tasks.after_character_turn(character, delay, handler)
    -- The saved queue already records active timers; only dormant timers need a separate key.
    state.set(handler, nil)
end

local function queue_awakening(character)
    queue(character, awakening, services.random.native_int(60, 60))
end

local function queue_counter(character, cache)
    queue(character, counter_due, learning_delay(character, "insight", "insight", cache))
end

ccb.runtime.handler(awakening, function(event)
    if knacks_only then return end
    local character = event.character
    if scalar(character, initialized) == 1 then
        state.set(awakening, "dormant")
        return
    end
    local attuned = psionic(character)
    if (not attuned and not has_trait(character, "ALWAYS_GAIN_PSIONICS"))
        or (attuned and has_trait(character, "LIMITED_PSIONICS")) then
        local count = scalar(character, "awakening_countup") + services.random.native_int(0, 8) + 1
        checked(services.variables.set(character, "awakening_countup", count, { include_before = false }))
    end
    checked(services.variables.set(character, initialized, 1, { include_before = false }))
    queue_awakening(character)
end)

ccb.runtime.handler(counter_due, function(event)
    if knacks_only then return end
    local character = event.character
    if not psionic(character) then
        state.set(counter_due, "dormant")
        return
    end
    if can_study(character) and counter(character) == 0 then set_counter(character, 1) end
    queue_counter(character, {})
end)

if not knacks_only then
    ccb.runtime.handler("count_psychic_knacks", function()
        local character = services.characters.avatar()
        if has_trait(character, "PSYCHIC_KNACK") then
            local known = checked(services.spells.count(character, id("mutation", "PSYCHIC_KNACK")))
            checked(services.variables.set(character, "awakening_countup",
                scalar(character, "awakening_countup") + known / 2, { include_before = false }))
        end
    end)
    ccb.runtime.on("game:game_start", "count_psychic_knacks")
end

local function queue_insight(character, school, rule, cache)
    local hours = rule.fixed_hours
    local delay = hours and services.random.native_int(hours[1] * 3600, hours[2] * 3600)
        or learning_delay(character, rule.tier, school[1], cache)
    queue(character, rule.handler, delay)
end

for _, school in ipairs(schools) do
    school.rules = {}
    for _, rule in ipairs(require("powers.learning_eocs." .. school[1])) do
        rule.handler = "insight_" .. rule.spell
        local enabled = not knacks_only or rule.allow_knacks_only
        if enabled then table.insert(school.rules, rule) end
        ccb.runtime.handler(rule.handler, function(event)
            if not enabled then return end
            local character = event.character
            if has_trait(character, school[2]) and (try_insight(character, rule)
                or checked(services.spells.effective_level(character, rule.spell)) < 1) then
                queue_insight(character, school, rule, {})
            else
                state.set(rule.handler, "dormant")
            end
        end)
    end
end

local function needs_timer(character, handler)
    return state.get(handler) ~= "dormant" and not tasks.has_character_turn(character, handler)
end

ccb.runtime.handler("initialize_psychic_insights", function(event)
    local character, cache = event.actors.character, {}
    if not knacks_only then
        if needs_timer(character, awakening) then queue_awakening(character) end
        if needs_timer(character, counter_due) then queue_counter(character, cache) end
    end
    for _, school in ipairs(schools) do
        for _, rule in ipairs(school.rules) do
            if needs_timer(character, rule.handler) then queue_insight(character, school, rule, cache) end
        end
    end
end)
ccb.runtime.on("character_ready", "initialize_psychic_insights")

ccb.runtime.handler("resume_psychic_insights", function(event)
    local character, cache = event.actors.character, {}
    if not knacks_only then
        if state.get(awakening) == "dormant" and scalar(character, initialized) ~= 1 then
            queue_awakening(character)
        end
        if state.get(counter_due) == "dormant" and psionic(character) then
            queue_counter(character, cache)
        end
    end
    for _, school in ipairs(schools) do
        if #school.rules > 0 and has_trait(character, school[2]) then
            for _, rule in ipairs(school.rules) do
                if state.get(rule.handler) == "dormant"
                    and checked(services.spells.effective_level(character, rule.spell)) < 1 then
                    queue_insight(character, school, rule, cache)
                end
            end
        end
    end
end)
ccb.runtime.on("character_conditions_changed", "resume_psychic_insights")
