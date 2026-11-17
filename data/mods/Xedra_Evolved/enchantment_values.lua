local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_deduction_regen_mana_regen_mana_multiply", function(ctx)
    return ctx.skills["deduction"] / 10
end)

ccb.runtime.handler("enchantment_bonus_dreamer_max_mana_add", function(ctx)
    return ctx.skills["deduction"] * 50
end)

ccb.runtime.handler("enchantment_bonus_eater_max_mana_add", function(ctx)
    return ctx.skills["deduction"] * 150
end)

ccb.runtime.handler("enchantment_unarmed_melee_boost_melee_damage_multiply", function(ctx)
    return ctx.skills["unarmed"] * 5
end)

ccb.runtime.handler("enchantment_wolf_sledge_bash_add", function(ctx)
    return ctx.skills["deduction"]
end)

content.add(content.Enchantment {
    id = "DEDUCTION_REGEN_MANA",
    has = "WORN",
    condition = "ALWAYS",
}
    :value("REGEN_MANA", {
        multiply_handler = "enchantment_deduction_regen_mana_regen_mana_multiply",
        load_skills = { "deduction" },
    }))

content.add(content.Enchantment {
    id = "BONUS_DREAMER",
    condition = "ALWAYS",
}
    :value("MAX_MANA", {
        add_handler = "enchantment_bonus_dreamer_max_mana_add",
        load_skills = { "deduction" },
    }))

content.add(content.Enchantment {
    id = "BONUS_EATER",
    condition = "ALWAYS",
}
    :value("MAX_MANA", {
        add_handler = "enchantment_bonus_eater_max_mana_add",
        load_skills = { "deduction" },
    })
    :value("REGEN_MANA", { multiply = -1 }))

content.add(content.Enchantment {
    id = "BONUS_DREAMSMITH",
    condition = "ALWAYS",
}
    :value("MAX_MANA", {
        add_handler = "enchantment_bonus_dreamer_max_mana_add",
        load_skills = { "deduction" },
    }))

content.add(content.Enchantment {
    id = "BONUS_INVENTOR",
    condition = "ALWAYS",
}
    :value("MAX_MANA", {
        add_handler = "enchantment_bonus_dreamer_max_mana_add",
        load_skills = { "deduction" },
    }))

content.add(content.Enchantment {
    id = "UNARMED_MELEE_BOOST",
    condition = "ALWAYS",
}
    :value("MELEE_DAMAGE", {
        multiply_handler = "enchantment_unarmed_melee_boost_melee_damage_multiply",
        load_skills = { "unarmed" },
    }))

content.add(content.Enchantment {
    id = "WOLF_SLEDGE",
    has = "WIELD",
    condition = "ALWAYS",
}
    :melee_damage("bash", {
        add_handler = "enchantment_wolf_sledge_bash_add",
        load_skills = { "deduction" },
    }))
