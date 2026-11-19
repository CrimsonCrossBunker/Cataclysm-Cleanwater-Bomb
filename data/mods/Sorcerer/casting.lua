local ccb = require("ccb")
local state = require("spell_state")
local services = ccb.services
local id = services.types.id

local sorcerer = id("mutation", "SORCERER")
local adrenaline = id("effect", "adrenaline")
local anemia = id("effect", "redcells_anemia")
local whole_body = id("body_part", "bp_null")
local magiclysm_spells = { mod = id("mod", "magiclysm") }
local sorcerer_spells = { mod = id("mod", "sorcerer") }

local function intensity(character, effect)
    local result = services.effects.get(character, effect, whole_body)
    if not result.ok and result.error.code == "not_found" then
        -- The native intensity query returns -1 when the effect is absent.
        return -1
    end
    return state.checked(result).intensity
end

ccb.runtime.handler("sorcerer_adjust_casting", function(event)
    local character = event.actors.character or services.characters.avatar()
    if not state.checked(services.mutations.has(character, sorcerer)) then
        return
    end

    local source = state.checked(services.variables.get_string(character, "power_source")).value
    if source ~= "intelligence" and source ~= "strength" and source ~= "dodge" then
        return
    end

    local snapshot = state.checked(services.characters.snapshot(character, 0))
    local bonus
    if source == "intelligence" then
        bonus = math.floor(snapshot.stats.intelligence / 2) - 3
    elseif source == "strength" then
        bonus = math.floor(snapshot.stats.strength / 2) - 3
            + (intensity(character, adrenaline) == 2 and 3 or 0) - intensity(character, anemia)
        state.set(character, "temp_bloodrager_boost", bonus)
    else
        bonus = math.floor(snapshot.combat.dodge / 2) - 2
    end

    state.checked(services.spells.adjust_casting(character, "caster_level", bonus, magiclysm_spells))
    state.checked(services.spells.adjust_casting(character, "caster_level", bonus, sorcerer_spells))
end)
ccb.runtime.on("game:opens_spellbook", "sorcerer_adjust_casting")
