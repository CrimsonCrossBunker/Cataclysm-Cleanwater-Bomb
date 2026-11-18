local ccb = require("ccb")
local content = ccb.content
local variables = ccb.services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function poise(actor)
    return checked(variables.get_number(actor, "poise")).value or 0
end

local function set_poise(actor, value)
    checked(variables.set(actor, "poise", value, { include_before = false }))
end

ccb.runtime.handler("martial_perks_gain_poise", function(impact)
    local caster = impact.caster
    local value = poise(caster)
    if value < 4 then set_poise(caster, value + 1) end
end)

ccb.runtime.handler("martial_perks_lose_poise", function(impact)
    local caster = impact.caster
    local value = poise(caster)
    if value > 0 then set_poise(caster, value - 1) end
end)

content.add(content.Spell {
    id = "perk_poise_spell",
    name = ccb.content.text("Insight"),
    description = "",
    message = content.text("You cast %s!"),
    sound_description = content.text("an explosion."),
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "RANDOM_CRITTER", "RANDOM_TARGET", "NO_EXPLOSION_SFX", "SILENT" },
    min_range = 15,
    max_range = 15,
}:lua_impact("martial_perks_gain_poise"))

content.add(content.Spell {
    id = "perk_lose_poise_spell",
    name = ccb.content.text("Insight"),
    description = "",
    message = content.text("You cast %s!"),
    sound_description = content.text("an explosion."),
    shape = "blast",
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT" },
    min_range = 15,
    max_range = 15,
}:lua_impact("martial_perks_lose_poise"))
