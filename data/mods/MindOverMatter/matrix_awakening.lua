local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local disciplines = require("matrix_awakening_data")
local portal_outcomes = require("portal_awakening_data")
local knack_recipes = require("knack_recipe_data")
local knacks_only = ccb.content.is_mod_active("mom_knacks_only")

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return value(services.mutations.has_id_text(character, trait))
end

local function number(character, key)
    return value(services.variables.get_number(character, key)).value or 0
end

local function set_number(character, key, amount)
    value(services.variables.set(character, key, amount, { include_before = false }))
end

local function awakening_odds(character, count, divisor)
    if knacks_only then
        return 0
    end
    local bonus = value(services.characters.enchantment_value(character, "awakening_odds_traits_mod", 0))
    return 100 * math.exp(1) ^ ((count - math.max(bonus * 0.75, 0)) / -divisor)
end

local function show(character, expand, message, popup)
    if character.subtype ~= "avatar" then
        return
    end
    local text = expand(message)
    if popup then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
    end
    services.messages.add(text)
end

local function add_effect(character, effect, turns)
    local result = services.effects.add(character, id("effect", effect), services.time.duration(turns, "turn"))
    if not result.ok and result.error.code ~= "rejected" then
        error(result.error.message)
    end
end

local function overload(character, stunned_turns)
    add_effect(character, "psionic_overload", 3600)
    add_effect(character, "stunned", stunned_turns)
end

local function show_overload(character, expand, popup)
    show(character, expand, ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  It starts pulsing, first slowly and more rapidly, and your head starts pounding in time with the light.  You tear your gaze away but the pounding in your head remains."), popup)
    overload(character, 10)
end

ccb.runtime.handler("use_drained_matrix", function(use)
    local character = use.character
    if character then
        show(character, function(message)
            return use:expand_text(message)
        end, ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  You become aware of your skin, of every cut and bruise and scrape, of the food sitting in your stomach and the air moving in and out of your lungs.  The sensation grows rapidly until your stomach feels like it will burst and every brush of clothing on your skin is like rasping sandpaper.  As the light fades from the crystal, a searing pains fills your head."), true)
        overload(character, 10)
    end
    return 1
end)

local function spell_level(character, spell)
    return value(services.spells.effective_level(character, spell))
end

local function convert_knacks(character, discipline)
    if not discipline.knacks or not has_trait(character, "PSYCHIC_KNACK") then
        return
    end
    for _, change in ipairs(discipline.knacks) do
        local learned, replacement, forgotten = table.unpack(change)
        local level = spell_level(character, learned)
        if level > 0 then
            value(services.spells.set_level(character, id("spell", replacement), level))
            value(services.spells.set_level(character, id("spell", forgotten or learned), -1))
        end
    end
    if value(services.spells.count(character, id("mutation", "PSYCHIC_KNACK"))) == 0 then
        value(services.mutations.erase(character, id("mutation", "PSYCHIC_KNACK")))
    end
end

local function teach_discipline(character, discipline)
    for _, entry in ipairs(discipline.recipes) do
        local spell, recipe = table.unpack(entry)
        if has_trait(character, discipline.trait) and spell_level(character, spell) >= 0 then
            value(services.recipes.learn(character, id("recipe", recipe or "practice_" .. spell)))
        end
    end
end

local function finalize(character, discipline)
    local count = number(character, "awakening_countup") + 1
    set_number(character, "awakening_countup", count)
    set_number(character, "awakening_reducer", awakening_odds(character, count, 1.7))
    value(services.mutations.erase(character, id("mutation", "ALWAYS_GAIN_PSIONICS")))
    value(services.mutations.replace(character, id("mutation", discipline.trait)))
    value(services.mutations.replace(character, id("mutation", discipline.ability)))
    teach_discipline(character, discipline)
    convert_knacks(character, discipline)
    if character.subtype == "avatar" then
        value(services.achievements.complete(id("achievement", "mom_psi_awakening_" .. discipline.name)))
    end
end

ccb.runtime.handler("teach_existing_psionics_recipes", function(event)
    local character = event.actors.character or services.characters.avatar()
    for _, discipline in ipairs(disciplines) do
        if has_trait(character, discipline.trait) then
            teach_discipline(character, discipline)
        end
    end
    if has_trait(character, "PSYCHIC_KNACK") then
        for _, spell in ipairs(knack_recipes) do
            if spell_level(character, spell) >= 1 then
                value(services.recipes.learn(character, id("recipe", "practice_" .. spell)))
            end
        end
    end
end, 1)
ccb.runtime.on("game:game_begin", "teach_existing_psionics_recipes")

local function meditate(character)
    value(services.activities.assign_timed(character, id("activity", "ACT_CRYSTAL_AWAKENING_MEDITATION"),
        services.time.duration(5, "turn")))
end

local function queue_drain(character, crystal)
    if not knacks_only or crystal == "matrix_crystal_coruscating" then
        ccb.tasks.after_character_turn(character, 1, "drain_matrix_crystal", { crystal = crystal })
    end
end

local drained_crystal = id("item", "matrix_crystal_drained")
ccb.runtime.handler("drain_matrix_crystal", function(task)
    if knacks_only and task.data.crystal ~= "matrix_crystal_coruscating" then
        return
    end
    local character = task.character
    local crystal = id("item", task.data.crystal)
    if value(services.inventory.has_items(character, crystal, 1, 0)) then
        value(services.inventory.consume_by_type(character, crystal, 1, 0))
        value(services.inventory.receive_item(character, drained_crystal, 1))
    end
end)

local function finish(character, discipline, expand, success)
    local crystal = "matrix_crystal_" .. discipline.name
    if success then
        show(character, expand, discipline.success_text(), true)
        finalize(character, discipline)
        for _, effect in ipairs(discipline.effects or {}) do
            add_effect(character, effect[1], effect[2])
        end
        if discipline.after_awakening then
            discipline.after_awakening(character)
        end
    else
        show(character, expand, discipline.failure_text(), true)
        overload(character, discipline.failure_stun)
        if discipline.failure_drains_first then
            queue_drain(character, crystal)
            meditate(character)
            return
        end
    end
    meditate(character)
    queue_drain(character, crystal)
end

local function awaken(character, discipline, expand)
    if (knacks_only and discipline.suppress_in_psychic_scream)
        or has_trait(character, discipline.trait) or has_trait(character, "CANNOT_GAIN_PSIONICS") then
        show_overload(character, expand, false)
        return
    end
    local odds = awakening_odds(character, number(character, "awakening_countup"), 1.7)
    set_number(character, "awakening_reducer", odds)
    finish(character, discipline, expand, services.random.native_probability(odds, 100))
end

for _, discipline in ipairs(disciplines) do
    ccb.runtime.handler("awaken_from_" .. discipline.name .. "_crystal", function(use)
        if not use:require_wielded() then
            return nil
        end
        awaken(use.character, discipline, function(message)
            return use:expand_text(message)
        end)
        return 1
    end)
end

local discipline_weights = { 1, 1, 1, 1, 1, 1, 1, 1, 1 }
ccb.runtime.handler("use_coruscating_matrix", function(use)
    local character = use.character
    if character then
        local function expand(message)
            return use:expand_text(message)
        end
        if has_trait(character, "CANNOT_GAIN_PSIONICS") then
            show_overload(character, expand, true)
        else
            local discipline = disciplines[services.random.weighted_index(discipline_weights)]
            finish(character, discipline, expand, not has_trait(character, discipline.trait))
            meditate(character)
        end
        queue_drain(character, "matrix_crystal_coruscating")
    end
    return 1
end)

ccb.runtime.handler("awaken_from_biokinetic_artifact", function(impact)
    local character = impact.target_creature
    if character and character.subtype ~= "monster" then
        awaken(character, disciplines[1], function(message)
            return value(services.text.expand_for(message, character, impact.caster))
        end)
    end
end)

local function has_effect(character, effect)
    return value(services.effects.has(character, id("effect", effect)))
end

local function strength()
    return value(services.variables.get_global_number("ps_str")).value or 0
end

local function portal_proof(character)
    if value(services.inventory.has_worn_flag(character, id("json_flag", "PORTAL_PROOF"))) then
        return true
    end
    local mods = services.gameplay.mods
    if mods.load_order("xedra_evolved") > mods.load_order("mindovermatter") then
        return value(services.creatures.has_flag_text(character, "MAGICAL_MIND_PROTECTION"))
    end
    if not has_effect(character, "effect_telepathic_psi_armor") then
        return false
    end
    local highest = -1
    for _, discipline in ipairs(disciplines) do
        highest = math.max(highest, value(services.spells.school_level(character, id("mutation", discipline.trait))))
    end
    local shield_level = spell_level(character, "telepathic_shield") + spell_level(character, "telepathic_shield_knack")
    local drain = value(services.needs.get_vitamin(character, id("vitamin", "vitamin_psionic_drain")))
    return shield_level >= drain / 10 + highest / 3 + number(character, "awakening_countup") / 3
end

local function electro_overload(character)
    if not has_effect(character, "effect_electrokin_overload") then
        return
    end
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("Your muscles suddenly seize up!"), "bad")
    end
    add_effect(character, "downed", services.random.native_int(2, 8))
    add_effect(character, "stunned", services.random.native_int(1, 4))
    ccb.tasks.after_character_turn(character, services.random.native_int(60, 2700), "portal_electro_overload_due")
end

ccb.runtime.handler("portal_electro_overload_due", function(task)
    electro_overload(task.character)
end)

local function attempt_portal_awakening(character)
    if not value(services.creatures.snapshot(character)).outside or portal_proof(character)
        or has_effect(character, "sleep") or has_trait(character, "CANNOT_GAIN_PSIONICS") then
        return false
    end

    local divisor = 3
    local odds = awakening_odds(character, number(character, "awakening_countup"), divisor)
    set_number(character, "awakening_reducer", odds)
    local chance = 450 * math.exp(1) ^ (-0.24 * strength()) + 20
    if has_effect(character, "psi_nether_attention") then
        chance = chance * 0.5
    end
    if character.subtype == "avatar" then
        services.messages.add(("Odds of awakening are 1 in %.6g."):format(chance), "debug")
    end
    if services.random.weighted_index({ math.modf(chance), 1 }) ~= 2 then
        return true
    end

    local chosen = services.random.weighted_index(discipline_weights)
    local discipline = disciplines[chosen]
    local outcome = portal_outcomes[discipline.name]
    local function expand(text)
        return value(services.text.expand_for(text, character, nil, nil, nil, true))
    end
    if not has_trait(character, discipline.trait) and not has_effect(character, "psionic_awakened")
        and services.random.native_probability(odds, 100) then
        show(character, expand, outcome.success_text(), true)
        finalize(character, discipline)
        for _, effect in ipairs(outcome.success_effects or {}) do
            add_effect(character, effect[1], effect[2])
        end
        add_effect(character, "psionic_awakened", math.modf(strength() * 7200))
        set_number(character, "awakening_reducer", awakening_odds(character, number(character, "awakening_countup"), divisor))
    else
        show(character, expand, outcome.failure_text(), false)
        add_effect(character, "psionic_overload", math.modf(strength() * 3600))
        for _, effect in ipairs(outcome.failure_effects) do
            add_effect(character, effect[1], math.modf(strength() * effect[2]))
        end
        if outcome.electro_overload then
            electro_overload(character)
        end
        if outcome.heat_field then
            services.gameplay.environment.add_field_area(value(services.creatures.snapshot(character)).position,
                "fd_hot_air3", { radius = 2, outdoor_only = true })
        end
        local stamina = value(services.needs.get(character)).stamina
        value(services.needs.set(character, { stamina = stamina - 4000 }))
    end
    return true
end

if not knacks_only then
    local timers = {
        { key = "portal_awakening_distant", weather = "distant_portal_storm", min = 300, max = 600 },
        { key = "portal_awakening_medium", weather = "portal_storm", min = 60, max = 120 },
        { key = "portal_awakening_close", weather = "close_portal_storm", min = 120, max = 300 },
    }
    local persistent = ccb.state.character
    local tasks = ccb.tasks

    local function schedule(timer)
        tasks.after_avatar_turn(services.random.native_int(timer.min, timer.max), timer.key .. "_due")
        persistent.set(timer.key, "scheduled")
    end

    for _, timer in ipairs(timers) do
        ccb.runtime.handler(timer.key .. "_due", function(payload)
            if services.weather.current().weather.value ~= timer.weather then
                persistent.set(timer.key, "dormant")
                return
            end
            local avatar_activated = attempt_portal_awakening(payload.character)
            for _, npc in ipairs(value(services.npcs.loaded())) do
                if services.weather.current().weather.value == timer.weather then
                    attempt_portal_awakening(npc.handle)
                end
            end
            if avatar_activated or services.weather.current().weather.value == timer.weather then
                schedule(timer)
            else
                persistent.set(timer.key, "dormant")
            end
        end)
    end

    ccb.runtime.handler("portal_awakening_timers_ready", function(event)
        if event.actors.character.subtype ~= "avatar" then
            return
        end
        local current = services.weather.current().weather.value
        for _, timer in ipairs(timers) do
            if tasks.has_avatar_turn(timer.key .. "_due") then
                persistent.set(timer.key, "scheduled")
            else
                local status = persistent.get(timer.key)
                if status == nil or current == timer.weather then
                    schedule(timer)
                end
            end
        end
    end)
    ccb.runtime.on("character_ready", "portal_awakening_timers_ready")

    ccb.runtime.handler("portal_awakening_weather_changed", function()
        local current = services.weather.current().weather.value
        for _, timer in ipairs(timers) do
            if current == timer.weather and persistent.get(timer.key) == "dormant" then
                schedule(timer)
            end
        end
    end)
    ccb.runtime.hook("on_weather_changed", "portal_awakening_weather_changed")
else
    -- Previously queued world tasks can still appear when the add-on is enabled on a save.
    for _, phase in ipairs({ "distant", "medium", "close" }) do
        ccb.runtime.handler("portal_awakening_" .. phase .. "_due", function() end)
    end
end
