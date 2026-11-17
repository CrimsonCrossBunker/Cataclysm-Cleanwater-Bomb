local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_pyrokinetic_banked_fire_damage_enchant_active", function(ctx)
    return not (ctx.character_inputs.armed)
end)

ccb.runtime.handler("enchantment_pyrokinetic_banked_fire_damage_enchant_melee_damage_heat_add", function(ctx)
    return ctx.spell_levels["pyrokinetic_call_flames"] + 5
end)

content.add(content.Enchantment {
    id = "pyrokinetic_banked_fire_damage_enchant",
    has = "WORN",
    condition_handler = "enchantment_pyrokinetic_banked_fire_damage_enchant_active",
    load_character_inputs = { armed = true },
}
    :melee_damage("heat", { add_handler = "enchantment_pyrokinetic_banked_fire_damage_enchant_melee_damage_heat_add", load_spell_levels = { "pyrokinetic_call_flames" } }))

ccb.runtime.handler("enchantment_enchant_photokin_potion_rads_active", function(ctx)
    return ctx.character_inputs.radiation > 0
end)

content.add(content.Enchantment {
    id = "enchant_photokin_potion_rads",
    has = "HELD",
    condition_handler = "enchantment_enchant_photokin_potion_rads_active",
    load_character_inputs = { radiation = true },
}
    :value("LUMINATION", { add = 10 }))

local psychic_traits = {
    "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC",
    "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK",
}

ccb.runtime.handler("nether_incense_psychic_affinity", function(ctx)
    local traits = ctx.character_inputs.traits
    for _, trait in ipairs(psychic_traits) do
        if traits[trait] then
            return true
        end
    end
    return false
end)

local function register_nether_incense(id, effect)
    content.upsert_enchantment(content.Enchantment {
        id = id,
        has = "HELD",
        condition_handler = "nether_incense_psychic_affinity",
        load_character_inputs = { traits = psychic_traits },
    }:effect(effect, 1))
end

register_nether_incense("ench_mom_incense_nether_attunement", "effect_mom_incense_nether_attunement_minor")
register_nether_incense("ench_mom_incense_nether_attunement_major", "effect_mom_incense_nether_attunement_major")
