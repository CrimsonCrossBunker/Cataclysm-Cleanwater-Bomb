local ccb = require("ccb")
local content = ccb.content

do
    local group = content.NestedRecipeCategory {
        id = "nested_gossamer_clothing",
        name = ccb.content.text("gossamer clothes"),
        description = ccb.content.text("Recipes related to turning gossamer into clothing."),
        category = "CC_XEDRA",
        subcategory = "CSC_XEDRA_MISC",
        activity_level = 2,
        skill = "tailor",
        difficulty = 1,
    }
    group:recipe("tunic_gossamer", true)
    group:recipe("sleeveless_tunic_gossamer", true)
    group:recipe("doublet_gossamer", true)
    group:recipe("dress_gossamer", true)
    group:recipe("gown_gossamer", true)
    group:recipe("cloak_gossamer", true)
    group:recipe("jacket_light_gossamer", true)
    group:recipe("robe_wizard_gossamer", true)
    group:recipe("gloves_light_gossamer", true)
    group:recipe("loincloth_gossamer", true)
    group:recipe("pants_gossamer", true)
    group:recipe("pants_no_pocket_gossamer", true)
    group:recipe("skirt_gossamer", true)
    group:recipe("skirt_long_gossamer", true)
    group:recipe("socks_gossamer", true)
    group:recipe("stockings_gossamer", true)
    group:recipe("slippers_gossamer", true)
    group:recipe("sheet_gossamer_patchwork", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_gossamer_armor",
        name = ccb.content.text("gossamer armor"),
        description = ccb.content.text("Recipes related to turning gossamer into armor."),
        category = "CC_XEDRA",
        subcategory = "CSC_XEDRA_ARMOR",
        activity_level = 2,
        skill = "tailor",
        difficulty = 1,
    }
    group:recipe("gambeson_gossamer", true)
    group:recipe("gambeson_hood_gossamer", true)
    group:recipe("gambeson_pants_gossamer", true)
    group:recipe("gambeson_batting_gossamer", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_moonstears_weapons_clothing",
        name = ccb.content.text("moon's tears weapons"),
        description = ccb.content.text("Recipes related to turning moon's tears into weaponry."),
        category = "CC_XEDRA",
        subcategory = "CSC_XEDRA_WEAPONS",
        activity_level = 2,
        skill = "fabrication",
        difficulty = 1,
    }
    group:recipe("moons_tears_knife_baselard", true)
    group:recipe("moons_tears_broadsword", true)
    group:recipe("moons_tears_arming_sword", true)
    group:recipe("moons_tears_mace", true)
    group:recipe("moons_tears_scimitar", true)
    group:recipe("moons_tears_estoc", true)
    group:recipe("moons_tears_spear", true)
    group:recipe("moons_tears_battleaxe", true)
    group:recipe("moons_tears_katana", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "cat_arvore_treesinging",
        name = ccb.content.text("treesinging"),
        description = ccb.content.text("Recipes related to turning sung wood into furniture and items."),
        category = "CC_XEDRA",
        subcategory = "CSC_XEDRA_ELEMENTAL",
        activity_level = 4,
        skill = "gramarye",
        difficulty = 1,
    }
    group:recipe("create_chair_wood_treesung", true)
    group:recipe("create_wardrobe_wood_treesung", true)
    group:recipe("create_table_wood_treesung", true)
    group:recipe("create_bedframe_wood_treesung", true)
    group:recipe("create_verdant_helm", true)
    group:recipe("create_verdant_cuirass", true)
    group:recipe("create_verdant_gauntlets", true)
    group:recipe("create_verdant_leg_guards", true)
    group:recipe("create_verdant_boots", true)
    group:recipe("create_verdant_cloak", true)
    group:recipe("create_shortbow_treesung", true)
    group:recipe("create_greatbow_treesung", true)
    group:recipe("create_arrow_treesung", true)
    group:recipe("create_spear_treesung", true)
    group:recipe("create_pike_treesung", true)
    group:recipe("create_mace_treesung", true)
    group:recipe("create_q_staff_treesung", true)
    group:recipe("create_warhammer_treesung", true)
    group:recipe("create_naginata_treesung", true)
    group:recipe("create_baselard_treesung", true)
    content.add(group)
end
