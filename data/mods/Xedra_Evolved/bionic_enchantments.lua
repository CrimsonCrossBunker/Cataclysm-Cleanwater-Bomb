local ccb = require("ccb")
local content = ccb.content

-- Definition IDs keep bionic enchantments independent of the display language.

-- data/mods/Xedra_Evolved/player/inventor_cbms.json

ccb.runtime.handler("bionic_ench_bio_inventor_mana_kj_penalty_switch_0_value_1_add", function(ctx)
    return (ctx.character_inputs.mana * (-1000000))
end)

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_inventor_mana_kj_penalty_switch_0",
    load_character_inputs = { mana = true },
    native_modifier_order = true,
}
    :value("BIONIC_MANA_PENALTY", { multiply = -1 })
    :value("BIONIC_POWER", {
        add_handler = "bionic_ench_bio_inventor_mana_kj_penalty_switch_0_value_1_add",
        load_skills = {}
    }))

local burned_book_inputs = { effect_intensities = { "effect_burned_books" } }

ccb.runtime.handler("inventor_burned_book_count", function(ctx)
    return ctx.character_inputs.effect_intensities.effect_burned_books
end)

ccb.runtime.handler("inventor_burned_book_learning", function(ctx)
    return (ctx.character_inputs.effect_intensities.effect_burned_books * -20) - 20
end)

local function book_boost(slot)
    return content.Enchantment {
        id = "BIONIC_ENCH_bio_inventor_book_burn_boost_" .. slot,
        load_character_inputs = burned_book_inputs,
        native_modifier_order = true,
    }
end

content.add(book_boost(0)
    :value("READING_EXP", { add_handler = "inventor_burned_book_learning", load_skills = {} })
    :value("LEARNING_FOCUS", { add_handler = "inventor_burned_book_learning", load_skills = {} }))

local book_skills = {
    "deduction",
    "speech",
    "computer",
    "firstaid",
    "mechanics",
    "traps",
    "driving",
    "swimming",
    "fabrication",
    "cooking",
    "tailor",
    "survival",
    "electronics",
    "archery",
    "gun",
    "launcher",
    "pistol",
    "rifle",
    "shotgun",
    "smg",
    "throw",
    "melee",
    "bashing",
    "cutting",
    "dodge",
    "stabbing",
    "unarmed",
    "chemistry",
}
for slot, skill in ipairs(book_skills) do
    content.add(book_boost(slot)
        :skill(skill, { add_handler = "inventor_burned_book_count", load_skills = {} }))
end

-- data/mods/Xedra_Evolved/player/renfield_cbms.json

content.add(content.Enchantment {
    id = "BIONIC_ENCH_xe_bio_spore_enhancer_0",
    native_modifier_order = true,
}
    :value("STRENGTH", { add = 1 })
    :value("DEXTERITY", { add = 1 }))
