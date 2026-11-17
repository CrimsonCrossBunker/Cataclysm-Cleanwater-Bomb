local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_iso_ench_deliverator_value_speed_add", function(ctx)
    return ctx.character_inputs.character_variables["ISO_CURRENT_LEVEL_DANGER"]
end)

content.add(content.Enchantment {
    id = "iso_ench_deliverator",
    condition = "ALWAYS",
    name = content.text("The Deliverator"),
    description = content.text("Always on the clock."),
    load_character_inputs = { character_variables = { "ISO_CURRENT_LEVEL_DANGER" } },
}
    :value("SPEED", { add_handler = "enchantment_iso_ench_deliverator_value_speed_add" }))

ccb.runtime.handler("enchantment_iso_ench_balthazar_control_active", function(ctx)
    return ctx.character_inputs.global_variables["balthazar_control"] == 1
end)

content.add(content.Enchantment {
    id = "iso_ench_balthazar_control",
    name = content.text("Active Combat Interface"),
    description = content.text("You have asked Balthazar to directly control you in combat."),
    condition_handler = "enchantment_iso_ench_balthazar_control_active",
    load_character_inputs = { global_variables = { "balthazar_control" } },
}
    :value("SPEED", { add = 30 })
    :value("AVOID_FRIENDRY_FIRE", { add = 1 })
    :value("STAMINA_REGEN_MOD", { add = 4 })
    :value("PAIN", { multiply = -1 })
    :value("RANGED_DAMAGE", { multiply = 0.2 })
    :value("MELEE_DAMAGE", { multiply = 0.8 })
    :value("EVASION", { add = 25 })
    :value("RECOIL_MODIFIER", { add = -25 })
    :value("NIGHT_VIS", { add = 25 }))
