local ccb = require("ccb")
local content = ccb.content

-- Definition IDs keep bionic enchantments independent of the display language.

-- data/mods/XedraWood/patterns/flames_patterns.json

content.add(content.Enchantment {
    id = "BIONIC_ENCH_flames_tattoo_one_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :effect("effect_flames_tattoo_one", 1))

ccb.runtime.handler("bionic_ench_flames_tattoo_two_0_value_0_add", function(ctx)
    return (10 + (ctx.character_inputs.character_variables["flames_tattoo_count"] * 4))
end)

content.add(content.Enchantment {
    id = "BIONIC_ENCH_flames_tattoo_two_0", condition = "ACTIVE",
    load_character_inputs = { character_variables = { "flames_tattoo_count" } },
    native_modifier_order = true,
}
    :value("LUMINATION", { add_handler = "bionic_ench_flames_tattoo_two_0_value_0_add", load_skills = {  } }))

-- data/mods/XedraWood/patterns/mountain_patterns.json

ccb.runtime.handler("bionic_ench_mountain_tattoo_two_0_melee_damage_0_add", function(ctx)
    return (4 + (ctx.character_inputs.character_variables["mountain_tattoo_count"] * 2))
end)

ccb.runtime.handler("bionic_ench_mountain_tattoo_two_0_active", function(ctx)
    return ((ctx.character_inputs.character_variables["mountain_tattoo_two_active"] == 1) and
        not (ctx.character_inputs.armed))
end)

content.add(content.Enchantment {
    id = "BIONIC_ENCH_mountain_tattoo_two_0",
    condition_handler = "bionic_ench_mountain_tattoo_two_0_active",
    load_character_inputs = {
        armed = true,
        character_variables = { "mountain_tattoo_count", "mountain_tattoo_two_active" }
    },
    native_modifier_order = true,
}
    :melee_damage("bash", {
        add_handler = "bionic_ench_mountain_tattoo_two_0_melee_damage_0_add",
        load_skills = {}
    }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_mountain_tattoo_three_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("KNOCKBACK_RESIST", { add = 100 })
    :value("KNOCKDOWN_RESIST", { add = 100 })
    :effect("effect_mountain_tattoo_three", 1))

ccb.runtime.handler("bionic_ench_mountain_tattoo_four_0_value_0_add", function(ctx)
    return (ctx.character_inputs.environment.position_z * (-10))
end)

ccb.runtime.handler("bionic_ench_mountain_tattoo_four_0_active", function(ctx)
    return (not (ctx.character_inputs.environment.outside) and
        (ctx.character_inputs.environment.position_z <= (-1)))
end)

content.add(content.Enchantment {
    id = "BIONIC_ENCH_mountain_tattoo_four_0",
    condition_handler = "bionic_ench_mountain_tattoo_four_0_active",
    load_character_inputs = { environment = { outside = true, position_z = true } },
    native_modifier_order = true,
}
    :value("POWER_TRICKLE", {
        add_handler = "bionic_ench_mountain_tattoo_four_0_value_0_add",
        load_skills = {}
    }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_mountain_tattoo_five_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("CARDIO_MULTIPLIER", { multiply = 0.5 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_mountain_tattoo_five_1", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", { multiply = 4 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_mountain_tattoo_six_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("SPEED", { multiply = -0.1 }))
