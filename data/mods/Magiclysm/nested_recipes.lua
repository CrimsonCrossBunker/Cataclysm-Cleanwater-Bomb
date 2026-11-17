local ccb = require("ccb")
local content = ccb.content

do
    local group = content.NestedRecipeCategory {
        id = "nested_black_dragon_scale_armor_all",
        name = ccb.content.text("black dragon scale armors"),
        description = ccb.content.text("Recipes related to constructing black dragon scale armor."),
        category = "CC_ENCHANTED",
        subcategory = "CSC_ENCHANTED_ARMOR",
        activity_level = 2,
        skill = "fabrication",
        difficulty = 8,
    }
    group:requires_skill("spellcraft", 5)
    group:recipe("nested_black_dragon_scale_armor", true)
    group:recipe("nested_xl_black_dragon_scale_armor", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_black_dragon_scale_armor",
        name = ccb.content.text("black dragon scale armors"),
        description = ccb.content.text("Recipes related to constructing black dragon scale armor."),
        category = "CC_*",
        subcategory = "CSC_*_NESTED",
        activity_level = 2,
        skill = "fabrication",
        difficulty = 7,
    }
    group:requires_skill("spellcraft", 5)
    group:recipe("suit_black_dragon_scale", true)
    group:recipe("helmet_black_dragon_scale", true)
    group:recipe("gauntlets_black_dragon_scale", true)
    group:recipe("boots_black_dragon_scale", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_xl_black_dragon_scale_armor",
        name = ccb.content.text("XL black dragon scale armors"),
        description = ccb.content.text("Recipes related to constructing black dragon scale armor in XL sizes."),
        category = "CC_*",
        subcategory = "CSC_*_NESTED",
        activity_level = 2,
        skill = "fabrication",
        difficulty = 8,
    }
    group:requires_skill("spellcraft", 6)
    group:recipe("suit_xlblack_dragon_scale", true)
    group:recipe("helmet_xlblack_dragon_scale", true)
    group:recipe("gauntlets_xlblack_dragon_scale", true)
    group:recipe("boots_xlblack_dragon_scale", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_black_dragon_hide_armor_all",
        name = ccb.content.text("black dragon hide armors"),
        description = ccb.content.text("Recipes related to constructing hide dragon hide armor."),
        category = "CC_ENCHANTED",
        subcategory = "CSC_ENCHANTED_ARMOR",
        activity_level = 2,
        skill = "tailor",
        difficulty = 6,
    }
    group:requires_skill("spellcraft", 4)
    group:recipe("nested_black_dragon_hide_armor", true)
    group:recipe("nested_xl_black_dragon_hide_armor", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_black_dragon_hide_armor",
        name = ccb.content.text("black dragon hide armors"),
        description = ccb.content.text("Recipes related to constructing black dragon hide armor."),
        category = "CC_*",
        subcategory = "CSC_*_NESTED",
        activity_level = 2,
        skill = "tailor",
        difficulty = 5,
    }
    group:requires_skill("spellcraft", 3)
    group:recipe("suit_black_dragon_hide", true)
    group:recipe("helmet_black_dragon_hide", true)
    group:recipe("gloves_black_dragon_hide", true)
    group:recipe("boots_black_dragon_hide", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_xl_black_dragon_hide_armor",
        name = ccb.content.text("XL black dragon hide armors"),
        description = ccb.content.text("Recipes related to constructing black dragon hide armor in XL sizes."),
        category = "CC_*",
        subcategory = "CSC_*_NESTED",
        activity_level = 2,
        skill = "tailor",
        difficulty = 6,
    }
    group:requires_skill("spellcraft", 4)
    group:recipe("suit_xlblack_dragon_hide", true)
    group:recipe("helmet_xlblack_dragon_hide", true)
    group:recipe("gloves_xlblack_dragon_hide", true)
    group:recipe("boots_xlblack_dragon_hide", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_potion_fruits",
        name = ccb.content.text("potion fruits"),
        description = ccb.content.text("Recipes related to enchanting fruits with pure mana."),
        category = "CC_ENCHANTED",
        subcategory = "CSC_ENCHANTED_POTIONS",
        activity_level = 2,
        skill = "spellcraft",
        difficulty = 4,
    }
    group:recipe("potion_fruit_apple", true)
    group:recipe("potion_fruit_peach", true)
    group:recipe("potion_fruit_pear", true)
    group:recipe("potion_fruit_blackberries", true)
    group:recipe("potion_fruit_raspberries", true)
    group:recipe("potion_fruit_strawberries", true)
    group:recipe("potion_fruit_elderberries", true)
    group:recipe("potion_fruit_blueberries", true)
    group:recipe("potion_fruit_cranberries", true)
    group:recipe("potion_fruit_huckleberries", true)
    group:recipe("potion_fruit_wintergreen", true)
    group:recipe("potion_fruit_cherry", true)
    group:recipe("potion_fruit_apricot", true)
    group:recipe("potion_fruit_mayapple", true)
    group:recipe("potion_fruit_grapes", true)
    group:recipe("potion_fruit_m_stellatum_berries", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_magical_arrows",
        name = ccb.content.text("enchanted arrows"),
        description = ccb.content.text("Recipes related to creating enchanted arrows"),
        category = "CC_AMMO",
        subcategory = "CSC_AMMO_ARROWS",
        activity_level = 2,
        skill = "fabrication",
        difficulty = 3,
    }
    group:recipe("arrow_animist_crafted", true)
    group:recipe("arrow_magus_crafted", true)
    group:recipe("arrow_technomancer_crafted", true)
    group:recipe("arrow_biomancer_crafted", true)
    group:recipe("arrow_kelvinist_crafted", true)
    group:recipe("arrow_earthshaper_crafted", true)
    group:recipe("arrow_stormshaper_crafted", true)
    group:recipe("arrow_druid_crafted", true)
    group:recipe("arrow_odin", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_druidic_shapeshifting",
        name = ccb.content.text("druidic shapeshifting"),
        description = ccb.content.text("Recipes related to druidic shapeshifting."),
        category = "CC_ENCHANTED",
        subcategory = "CSC_ENCHANTED_RESEARCH",
        activity_level = 4,
        skill = "spellcraft",
        difficulty = 5,
    }
    group:recipe("prac_druidic_shapeshifting_bear", true)
    group:recipe("druidic_shapeshifting_bear_finalize", true)
    group:recipe("prac_druidic_shapeshifting_cougar", true)
    group:recipe("druidic_shapeshifting_cougar_finalize", true)
    group:recipe("prac_druidic_shapeshifting_deer", true)
    group:recipe("druidic_shapeshifting_deer_finalize", true)
    group:recipe("prac_druidic_shapeshifting_raven", true)
    group:recipe("druidic_shapeshifting_raven_finalize", true)
    content.add(group)
end
