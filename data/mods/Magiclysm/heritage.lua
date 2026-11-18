local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local state = ccb.state.character
local sky_island = content.is_mod_active("skyisland")
local mind_over_matter = content.is_mod_active("mindovermatter")
local xedra = content.is_mod_active("xedra_evolved")

local builds = {
    "ELVEN_BUILD",
    "DWARVEN_BUILD",
    "GOBLIN_BUILD",
    "RAVENFOLK_BUILD",
    "LIZARDFOLK_BUILD",
}
local xedra_heritages = {
    "NATIVE_SHAPESHIFTER",
    "DHAMPIR_TRAIT",
    "CHANGELING_MAGIC",
    "FAIR_FOLK_COMMONER_SELECTOR",
    "UNKNOWING_CHANGELING_NOBLE",
    "UNKNOWING_CHANGELING_COMMONER_BROWNIE",
    "UNKNOWING_CHANGELING_COMMONER_POOKA",
    "UNKNOWING_CHANGELING_COMMONER_SELKIE",
    "UNKNOWING_CHANGELING_COMMONER_TROW",
    "LILIN_TRAITS",
    "GRACKEN",
    "XEDRA_CHRONOMANCER",
}

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has(character, name)
    return value(services.mutations.has_id_text(character, name))
end

local function has_any(character, traits)
    for _, trait in ipairs(traits) do
        if has(character, trait) then return true end
    end
    return false
end

local function other_heritage(character)
    return has_any(character, builds)
        or (mind_over_matter and has(character, "FIFTH_SUN_PEOPLE"))
        or (xedra and has_any(character, xedra_heritages))
end

local function install(name, mutation, eligible, inactive)
    local key = name .. "_timer"
    local due = name .. "_due"

    local function schedule(character)
        ccb.tasks.after_character_turn(character, 1, due)
        state.set(key, "scheduled")
    end

    local function wake(character)
        if state.get(key) == "dormant" and not inactive(character) then
            schedule(character)
        end
    end

    ccb.runtime.handler(due, function(event)
        local character = event.character
        if eligible(character) then
            value(services.mutations.replace(character, services.types.id("mutation", mutation)))
        elseif inactive(character) then
            state.set(key, "dormant")
            return
        end
        schedule(character)
    end)

    local ready = name .. "_ready"
    ccb.runtime.handler(ready, function(event)
        local character = event.actors.character
        if ccb.tasks.has_character_turn(character, due) then
            state.set(key, "scheduled")
        elseif state.get(key) == "dormant" then
            wake(character)
        else
            schedule(character)
        end
    end)
    ccb.runtime.on("character_ready", ready)

    local changed = name .. "_conditions"
    ccb.runtime.handler(changed, function(event)
        wake(event.actors.character)
    end)
    ccb.runtime.on("character_conditions_changed", changed)
end

install("magiclysm_human_build", "HUMAN_BUILD", function(character)
    return not other_heritage(character)
        and not (sky_island and has(character, "SI_TRIFFID_DECOR_MUTATION"))
end, function(character)
    return has(character, "HUMAN_BUILD") or other_heritage(character)
end)

if xedra then
    install("magiclysm_chronomancer_build", "HUMAN_CHRONOMANCER_BUILD", function(character)
        return has(character, "XEDRA_CHRONOMANCER")
    end, function(character)
        return not has(character, "XEDRA_CHRONOMANCER") or has(character, "HUMAN_CHRONOMANCER_BUILD")
    end)
end
