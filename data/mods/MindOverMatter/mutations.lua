local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local effects = services.effects
local mutations = services.mutations
local tasks = ccb.tasks
local state = ccb.state.character

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return checked(mutations.has_id_text(character, trait))
end

local function has_effect(character, effect)
    return checked(effects.has(character, id("effect", effect)))
end

local function add_message(character, text, severity)
    if character.subtype == "avatar" then
        services.messages.add(services.translate(text), severity)
    end
end

local telelixir_state = "telelixir_cast_state"
local telelixir_tick = "telelixir_cast_tick"
local telelixir_spell = id("spell", "telelixir_random")

local function telelixir_cast(character)
    checked(services.characters.cast_spell(character, telelixir_spell, {
        targeted = true,
        message = services.translate("Your crystal-fueled powers activate!"),
    }))
end

local function queue_telelixir_cast(character)
    tasks.after_character_turn(character, services.random.native_int(2, 5), telelixir_tick)
    state.set(telelixir_state, "scheduled")
end

ccb.runtime.handler("telelixir_cast_once", function(context)
    local character = context.character
    if not has_trait(character, "TELELIXIRDOWN_active") then
        return
    end
    telelixir_cast(character)
    if not tasks.has_character_turn(character, telelixir_tick) then
        queue_telelixir_cast(character)
    end
end)

ccb.runtime.handler(telelixir_tick, function(task)
    local character = task.character
    if not has_trait(character, "TELELIXIRDOWN_active") then
        state.set(telelixir_state, "dormant")
        return
    end
    telelixir_cast(character)
    queue_telelixir_cast(character)
end)

ccb.runtime.handler("initialize_telelixir_cast_timer", function(event)
    local character = event.actors.character
    if state.get(telelixir_state) ~= "dormant" and not tasks.has_character_turn(character, telelixir_tick) then
        queue_telelixir_cast(character)
    end
end)
ccb.runtime.on("character_ready", "initialize_telelixir_cast_timer")

ccb.runtime.handler("resume_telelixir_cast_timer", function(event)
    local character = event.actors.character
    if state.get(telelixir_state) == "dormant" and has_trait(character, "TELELIXIRDOWN_active") then
        queue_telelixir_cast(character)
    end
end)
ccb.runtime.on("character_conditions_changed", "resume_telelixir_cast_timer")

ccb.runtime.handler("toggle_psi_extended_channeling", function(context)
    local character = context.character
    if not has_trait(character, "PSI_EXTENDED_CHANNELING_active") then
        if has_trait(character, "PSI_TORRENTIAL_CHANNELING_active") then
            checked(mutations.invoke_activation(character, id("mutation", "PSI_TORRENTIAL_CHANNELING"), false))
        end
        checked(mutations.replace(character, id("mutation", "PSI_EXTENDED_CHANNELING_active")))
        add_message(character, "You begin to take more care in channeling your powers.", "good")
    else
        checked(mutations.erase(character, id("mutation", "PSI_EXTENDED_CHANNELING_active")))
        add_message(character, "You return to your previous speed in channeling your powers.", "neutral")
    end
end)

ccb.runtime.handler("activate_psi_torrential_channeling", function(context)
    local character = context.character
    if not has_effect(character, "effect_mom_cascade_stone") then
        if has_trait(character, "PSI_EXTENDED_CHANNELING_active") then
            checked(mutations.invoke_activation(character, id("mutation", "PSI_EXTENDED_CHANNELING"), false))
        end
        checked(mutations.replace(character, id("mutation", "PSI_TORRENTIAL_CHANNELING_active")))
        add_message(character, "You begin drawing deeply on the Nether.", "good")
    else
        add_message(character,
            "No matter how you try, you cannot draw more deeply on the Nether than you already are.", "mixed")
    end
end)

ccb.runtime.handler("deactivate_psi_torrential_channeling", function(context)
    local character = context.character
    if not has_effect(character, "effect_mom_cascade_stone") then
        checked(mutations.erase(character, id("mutation", "PSI_TORRENTIAL_CHANNELING_active")))
        add_message(character, "You cut off the overflow of Nether power.", "neutral")
    else
        add_message(character, "You attempt to cut off the flow of Nether power but it's locked open!", "bad")
    end
end)
