local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("has_effect_sleep", function(ctx)
    return ctx.character_inputs.effects["sleep"]
end)

ccb.runtime.handler("has_trait_arvore_wood_weapon_damage", function(ctx)
    return ctx.character_inputs.traits["ARVORE_WOOD_WEAPON_DAMAGE"]
end)

content.add(content.Enchantment {
    id = "ench_sevenoclock_coat_climate_control",
    has = "WORN",
    condition_handler = "has_effect_sleep",
    load_character_inputs = { effects = { "sleep" } },
}
    :value("CLIMATE_CONTROL_HEAT", { add = 1000 })
    :value("CLIMATE_CONTROL_CHILL", { add = 1000 }))

content.add(content.Enchantment {
    id = "ench_jagged_claws_when_bramble_bite",
    has = "WORN",
    condition_handler = "has_trait_arvore_wood_weapon_damage",
    load_character_inputs = { traits = { "ARVORE_WOOD_WEAPON_DAMAGE" } },
}
    :value("MELEE_DAMAGE", { multiply = 0.25 }))
