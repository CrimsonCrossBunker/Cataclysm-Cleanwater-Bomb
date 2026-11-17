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

ccb.runtime.handler("salamander_flaming_whip_damage", function(ctx)
    local spell_level = ctx.spell_levels.salamander_flaming_whip_spell
    return 5 + spell_level * ((ctx.stats.dexterity + 10) / 20)
end)

content.add(content.Enchantment {
    id = "SALAMANDER_SUMMON_WHIP",
    has = "WIELD",
    condition = "ALWAYS",
}:melee_damage("heat", {
    add_handler = "salamander_flaming_whip_damage",
    load_spell_levels = { "salamander_flaming_whip_spell" },
}))

local native_random = ccb.services.random
ccb.runtime.handler("sylph_fulgurating_strikes_basic_damage", function(ctx)
    local spells = ctx.spell_levels
    local limit = spells.zap_electrical_emission + spells.sylph_call_lightning + spells.sylph_crash_of_lightning
    return native_random.native_int(math.min(0, limit), math.max(0, limit))
end)

content.add(content.Enchantment {
    id = "ench_sylph_fulgurating_strikes_basic",
}:melee_damage("electric", {
    add_handler = "sylph_fulgurating_strikes_basic_damage",
    load_spell_levels = { "zap_electrical_emission", "sylph_call_lightning", "sylph_crash_of_lightning" },
}))

ccb.runtime.handler("enchantment_crowd_speed_bonus", function(ctx)
    return ctx.character_inputs.nearby_monsters.hostiles / 2
end)
content.add(content.Enchantment {
    id = "MON_NEARBY_SPEED",
    has = "WIELD",
    load_character_inputs = { nearby_monsters = { hostiles = { radius = 25 } } },
}:value("SPEED", { add_handler = "enchantment_crowd_speed_bonus" }))

ccb.runtime.handler("enchantment_bloodthorne_near_blood", function(ctx)
    return ctx.character_inputs.nearby_monsters.blood_creatures >= 1
end)
ccb.runtime.handler("enchantment_bloodthorne_damage", function()
    return native_random.native_float(5, 15)
end)
content.add(content.Enchantment {
    id = "BLOODTHORNE_DRUID_HEARTWHIP",
    has = "WIELD",
    condition_handler = "enchantment_bloodthorne_near_blood",
    load_character_inputs = {
        nearby_monsters = { blood_creatures = { radius = 3, attitude = "both", species = { "RENFIELD", "VAMPIRE" } } },
    },
}
    :value("WEAKPOINT_ACCURACY", { multiply = 1.5 })
    :melee_damage("biological", { add_handler = "enchantment_bloodthorne_damage" }))
