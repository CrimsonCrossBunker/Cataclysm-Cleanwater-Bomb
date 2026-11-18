local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local disciplines = require("matrix_awakening_data")
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

local function matrix_odds(character, count)
    local bonus = value(services.characters.enchantment_value(character, "awakening_odds_traits_mod", 0))
    return 100 * math.exp(1) ^ ((count - math.max(bonus * 0.75, 0)) / -1.7)
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

local function finalize(character, discipline)
    local count = number(character, "awakening_countup") + 1
    set_number(character, "awakening_countup", count)
    set_number(character, "awakening_reducer", matrix_odds(character, count))
    value(services.mutations.erase(character, id("mutation", "ALWAYS_GAIN_PSIONICS")))
    value(services.mutations.replace(character, id("mutation", discipline.trait)))
    value(services.mutations.replace(character, id("mutation", discipline.ability)))
    for _, entry in ipairs(discipline.recipes) do
        local spell, recipe = table.unpack(entry)
        if has_trait(character, discipline.trait) and spell_level(character, spell) >= 0 then
            value(services.recipes.learn(character, id("recipe", recipe or "practice_" .. spell)))
        end
    end
    convert_knacks(character, discipline)
    if character.subtype == "avatar" then
        value(services.achievements.complete(id("achievement", "mom_psi_awakening_" .. discipline.name)))
    end
end

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
    local odds = matrix_odds(character, number(character, "awakening_countup"))
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
