local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local effects = services.effects
local mutations = services.mutations
local variables = services.variables
local tasks = ccb.tasks
local state = ccb.state.character

local boost = "effect_matrix_potion_nether_boost"
local electro_comedown = "effect_electrokin_potion_comedown"
local teleport_comedown = "effect_teleport_potion_comedown"
local jitter_key = "preexisting_jittery_trait"
local blink_state = "teleport_elixir_blink_state"
local blink_handler = "blink_during_teleport_elixir_comedown"

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has_effect(character, effect)
    return checked(effects.has(character, id("effect", effect)))
end

local function add_effect(character, effect, turns)
    local result = effects.add(character, id("effect", effect), services.time.duration_from_turns(turns))
    if not result.ok and result.error.code ~= "rejected" then checked(result) end
end

local function remove_effect(character, effect)
    checked(effects.remove(character, id("effect", effect)))
end

local function has_trait(character, trait)
    return checked(mutations.has_id_text(character, trait))
end

local function set_trait(character, trait)
    checked(mutations.replace(character, id("mutation", trait)))
end

local function remove_temporary_form(character, trait)
    checked(mutations.erase(character, id("mutation", trait)))
    checked(mutations.erase(character, id("mutation", trait .. "_active")))
end

local function had_jittery(character)
    return checked(variables.get_number(character, jitter_key)).value == 1
end

local function random_hours(lo, hi)
    return services.random.native_int(lo * 3600, hi * 3600)
end

local disciplines = {
    "biokin", "clair", "electrokin", "photokin", "pyrokin", "telekin", "telepath", "teleport", "vitakin",
}

for _, discipline in ipairs(disciplines) do
    local power = "effect_" .. discipline .. "_potion"
    local comedown = power .. "_comedown"
    local due = "come_down_from_" .. discipline .. "_elixir"

    ccb.runtime.handler("drink_" .. discipline .. "_elixir", function(context)
        local character = context.character
        local cannot_gain_powers = has_trait(character, "CANNOT_GAIN_PSIONICS")
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You drink the concoction."))
        end
        if cannot_gain_powers then
            add_effect(character, "effect_matrix_potion_headblind", random_hours(6, 15))
            return
        end

        remove_effect(character, comedown)
        add_effect(character, power, 30 * 3600)
        add_effect(character, boost, 30 * 3600)
        if discipline == "electrokin" then
            if has_trait(character, "JITTERY") and not has_effect(character, electro_comedown) then
                checked(variables.set(character, jitter_key, 1, { include_before = false }))
            end
        elseif discipline == "photokin" then
            set_trait(character, "PHOTOLIXIR_LIGHT")
        elseif discipline == "telekin" then
            set_trait(character, "TELELIXIRDOWN")
        end
        tasks.after_character_turn(character, random_hours(12, 30), due)
    end)

    ccb.runtime.handler(due, function(task)
        local character = task.character
        remove_effect(character, power)
        remove_effect(character, boost)
        if discipline == "electrokin" and not had_jittery(character) then
            set_trait(character, "JITTERY")
        elseif discipline == "photokin" then
            remove_temporary_form(character, "PHOTOLIXIR_LIGHT")
        end
        add_effect(character, comedown, random_hours(24, 55))
        if discipline == "telekin" then
            remove_temporary_form(character, "TELELIXIRDOWN")
        end
    end)
end

ccb.runtime.handler("finish_electrokin_elixir_jitters", function(event)
    if event.data.effect == electro_comedown then
        local character = event.actors.character or services.creatures.avatar()
        if not had_jittery(character) then
            checked(mutations.erase(character, id("mutation", "JITTERY")))
        end
    end
end)
ccb.runtime.on("game:character_loses_effect", "finish_electrokin_elixir_jitters")

local function queue_blink(character)
    tasks.after_character_turn(character, services.random.native_int(30 * 60, 90 * 60), blink_handler)
    state.set(blink_state, "scheduled")
end

ccb.runtime.handler(blink_handler, function(task)
    local character = task.character
    if not has_effect(character, teleport_comedown) then
        state.set(blink_state, "dormant")
        return
    end
    checked(services.characters.cast_spell(character, id("spell", "teleport_blink_monster"), {
        message = ccb.services.translate("Reality suddenly warps around you and you are somewhere else!"),
    }))
    queue_blink(character)
end)

ccb.runtime.handler("initialize_teleport_elixir_blink_timer", function(event)
    local character = event.actors.character
    if state.get(blink_state) ~= "dormant" and not tasks.has_character_turn(character, blink_handler) then
        queue_blink(character)
    end
end)
ccb.runtime.on("character_ready", "initialize_teleport_elixir_blink_timer")

ccb.runtime.handler("resume_teleport_elixir_blink_timer", function(event)
    local character = event.actors.character
    if state.get(blink_state) == "dormant" and has_effect(character, teleport_comedown) then
        queue_blink(character)
    end
end)
ccb.runtime.on("character_conditions_changed", "resume_teleport_elixir_blink_timer")

ccb.runtime.handler("start_noetic_resilience", function(event)
    if event.data.effect == "effect_noetic_resilience_trigger" then
        local character = event.actors.character or services.creatures.avatar()
        remove_effect(character, "effect_noetic_resilience_comedown")
        add_effect(character, "effect_noetic_resilience", 30 * 3600)
        tasks.after_character_turn(character, random_hours(18, 30), "come_down_from_noetic_resilience")
    end
end)
ccb.runtime.on("game:character_gains_effect", "start_noetic_resilience")

ccb.runtime.handler("come_down_from_noetic_resilience", function(task)
    remove_effect(task.character, "effect_noetic_resilience")
    add_effect(task.character, "effect_noetic_resilience_comedown", random_hours(24, 55))
end)

local psionic_schools = {
    "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC",
    "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC",
}

ccb.runtime.handler("apply_noetic_resilience_comedown_penalty", function(event)
    local character = event.actors.character or services.creatures.avatar()
    if not has_effect(character, "effect_noetic_resilience_comedown") then return end
    for _, school in ipairs(psionic_schools) do
        local adjustment = school == "TELEPATH" and -3 or -4
        checked(services.spells.adjust_casting(character, "caster_level", adjustment,
            { school = id("mutation", school) }))
    end
end)
ccb.runtime.on("game:opens_spellbook", "apply_noetic_resilience_comedown_penalty")
