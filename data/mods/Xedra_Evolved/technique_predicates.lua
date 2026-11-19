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

local function wielded_has_flag(character, flag)
    local item = checked(services.inventory.wielded(character))
    return item ~= nil and checked(services.items.has_flag(item, id("json_flag", flag)))
end

local function terrain_has_flag(creature, flag)
    local position = checked(creatures.snapshot(creature)).position
    return services.gameplay.environment.terrain_has_flag(position, flag)
end

ccb.runtime.handler("allow_changeling_riastrad_knockback", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
end)

ccb.runtime.handler("allow_tec_precise", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
end)

ccb.runtime.handler("allow_tech_xe_ma_arvore_entangling_strike", function(combat)
    return checked(creatures.snapshot(combat.attacker)).outside
        and checked(creatures.snapshot(combat.target)).outside
        and terrain_has_flag(combat.target, "DIGGABLE")
end)

ccb.runtime.handler("allow_tech_xe_ma_arvore_disarm", function(combat)
    return checked(services.mutations.has_id_text(combat.attacker, "VINES3"))
        or wielded_has_flag(combat.attacker, "MAGIC_FOCUS")
end)

ccb.runtime.handler("allow_claws_shapeshifter_redhanded_rage_knockback", function(combat)
    return effect_intensity(combat.attacker, "effect_xe_werewolf_redhanded_rage") ~= nil
        and combat.attacker_size >= combat.target_size
end)

ccb.runtime.handler("allow_claws_shapeshifter_redhanded_rage_aoe_slash", function(combat)
    return effect_intensity(combat.attacker, "effect_xe_werewolf_redhanded_rage") ~= nil
end)

ccb.runtime.handler("allow_cqb_brutal", function(combat)
    return combat.attacker_size - 1 <= combat.target_size
end)
