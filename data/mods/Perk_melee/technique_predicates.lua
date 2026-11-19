local ccb = require("ccb")
local services = ccb.services
local creatures = services.creatures
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function effect_intensity(creature, effect, part)
    return checked(services.effects.exact_intensity(creature, id("effect", effect),
        part and id("body_part", part)))
end

ccb.runtime.handler("allow_tec_perk_stagger_strike", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and (effect_intensity(combat.attacker, "mabuff:buff_perk_tempo") or -1) > 2
        and not (effect_intensity(combat.target, "stunned") ~= nil)
end)

ccb.runtime.handler("allow_tec_perk_fore_stunned", function(combat)
    return effect_intensity(combat.target, "stunned") ~= nil
end)

ccb.runtime.handler("allow_tec_perk_vulgar_opening", function(combat)
    return not (effect_intensity(combat.attacker, "mabuff:buff_perk_tempo") ~= nil)
        and not (effect_intensity(combat.attacker, "mabuff:buff_perk_momentum") ~= nil)
        and not (effect_intensity(combat.attacker, "perk_insight") ~= nil)
end)

ccb.runtime.handler("allow_mma_tec_pokken_sweep", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
        and (not (checked(creatures.has_flag_text(combat.target, "FLIES")))
            or checked(creatures.has_flag_text(combat.target, "DISABLE_FLIGHT")))
end)

ccb.runtime.handler("allow_tec_perk_estocada", function(combat)
    return (effect_intensity(combat.attacker, "mabuff:buff_perk_momentum") or -1) == 1
end)

ccb.runtime.handler("allow_tec_perk_knife_finisher", function(combat)
    return (effect_intensity(combat.attacker, "mabuff:buff_perk_tempo") or -1) > 2
end)

ccb.runtime.handler("allow_tec_perk_duelist_combo", function(combat)
    return (effect_intensity(combat.attacker, "mabuff:buff_perk_tempo") or -1) == 2
        and (effect_intensity(combat.target, "perk_hit_marker") or -1) >= 2
end)
