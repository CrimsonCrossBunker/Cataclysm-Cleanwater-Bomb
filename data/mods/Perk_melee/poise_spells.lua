local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local tasks = ccb.tasks
local variables = services.variables
local id = services.types.id

local poise_flag = id("json_flag", "MELEE_PERK_POISE")
local poise_mountain = id("json_flag", "MELEE_PERK_POISE_MOUNTAIN")
local poise_spell = id("spell", "perk_poise_spell")
local poise_effect = id("effect", "effect_poise")
local regen_due = "martial_perks_poise_regen_due"

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

ccb.runtime.handler("martial_perks_start_poise", function(event)
    if event.data.trait ~= "MELEE_PERK_POISE" then return end
    local actor = event.actors.character or ccb.services.characters.avatar()
    if actor:is_valid() then set_poise(actor, 4) end
end)
ccb.runtime.on("game:gains_mutation", "martial_perks_start_poise")

ccb.runtime.handler(regen_due, function(payload)
    local actor = payload.character
    if checked(services.characters.has_flag(actor, poise_flag))
        and not checked(services.characters.has_flag(actor, poise_mountain)) then
        if poise(actor) < 4 then
            checked(services.characters.cast_spell(actor, poise_spell, { targeted = true }))
        end
    elseif checked(services.martial_arts.current(actor)).id.value ~= "style_none"
        and poise_effect:is_valid() then
        checked(services.effects.remove(actor, poise_effect))
    end
    tasks.after_character_turn(actor, 10, regen_due)
end, 1)

ccb.runtime.handler("martial_perks_poise_regen_ready", function(event)
    local actor = event.actors.character
    if not tasks.has_character_turn(actor, regen_due) then
        tasks.after_character_turn(actor, 10, regen_due)
    end
end)
ccb.runtime.on("character_ready", "martial_perks_poise_regen_ready")

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
