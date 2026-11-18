local ccb = require("ccb")
local services = ccb.services
local effects = services.effects
local tasks = ccb.tasks
local id = services.types.id

local insight = id("effect", "perk_insight")
local blind_check = id("effect", "perk_blind_check")
local insight_flag = id("json_flag", "MELEE_PERK_INSIGHT")
local infinite = id("json_flag", "MELEE_PERK_INSIGHT_INFINITE")
local sixth_sense = id("json_flag", "MELEE_PERK_SIXTH_SENSE")
local whole_body = id("body_part", "bp_null")
local insight_spell = id("spell", "perk_insight_spell")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function intensity(actor, effect)
    local result = effects.get(actor, effect, whole_body)
    if not result.ok and result.error.code == "not_found" then return -1 end
    return checked(result).intensity
end

local function gain_insight(actor)
    local current = intensity(actor, insight)
    if not checked(services.creatures.has_flag(actor, infinite)) and current >= 20 then return end
    local increment = intensity(actor, blind_check) > 14 and 5 or 1
    local applied = effects.add(actor, insight, services.time.duration(4, "day"), {
        intensity = current + increment,
    })
    if not applied.ok and applied.error.code ~= "rejected" then error(applied.error.message) end
end

ccb.runtime.handler("martial_perks_insight_hit", function(impact)
    gain_insight(impact.caster)
end)

ccb.content.add(ccb.content.Spell {
    id = "perk_insight_spell",
    name = ccb.content.text("Insight"),
    description = "",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "RANDOM_CRITTER", "RANDOM_TARGET", "NO_EXPLOSION_SFX", "SILENT" },
    min_range = 15,
    max_range = 15,
}:lua_impact("martial_perks_insight_hit"))

local function consider_gain(actor)
    local style = checked(services.martial_arts.current(actor)).id
    if style.value ~= "style_none" then
        checked(effects.remove(actor, insight))
        return
    end
    if not checked(services.characters.has_flag(actor, insight_flag)) then return end

    local character = checked(services.characters.snapshot(actor))
    if not services.random.native_probability(character.stats.perception, 20) then return end
    if checked(services.characters.has_flag(actor, sixth_sense)) and intensity(actor, insight) < 20 then
        local position = checked(services.creatures.snapshot(actor)).position
        if checked(services.monsters.count_nearby(position, nil, { radius = 15 })) > 0 then
            gain_insight(services.characters.avatar())
        end
    else
        checked(services.characters.cast_spell(actor, insight_spell, { targeted = true }))
    end
end

local due = "martial_perks_insight_due"

ccb.runtime.handler(due, function(payload)
    local actor = payload.character
    consider_gain(actor)
    tasks.after_character_turn(actor, 1, due)
end, 1)

ccb.runtime.handler("martial_perks_insight_ready", function(event)
    local actor = event.actors.character
    if not tasks.has_character_turn(actor, due) then tasks.after_character_turn(actor, 1, due) end
end)
ccb.runtime.on("character_ready", "martial_perks_insight_ready")
