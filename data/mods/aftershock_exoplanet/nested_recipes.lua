local ccb = require("ccb")
local content = ccb.content

do
    local group = content.NestedRecipeCategory {
        id = "afs_electrokinesis_practice",
        name = ccb.content.text("contemplation: electrokinesis"),
        description = ccb.content.text("Recipes related to practicing electrokinesis."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_PSI",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 10,
    }
    group:recipe("practice_afs_electrokinetic_see_electric", true)
    group:recipe("practice_afs_electrokinetic_shock_touch", true)
    group:recipe("practice_afs_electrokinetic_zap_enemies", true)
    group:recipe("practice_afs_electrokinetic_hacking_interface", true)
    group:recipe("practice_afs_electrokinetic_personal_battery", true)
    group:recipe("practice_afs_electrokinetic_recharge_vehicle", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "afs_precognition_practice",
        name = ccb.content.text("contemplation: precognition"),
        description = ccb.content.text("Recipes related to practicing precognition."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_PSI",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 10,
    }
    group:recipe("practice_afs_precog_danger_sense", true)
    group:recipe("practice_afs_precog_damage_foresee", true)
    group:recipe("practice_afs_precog_ranged_enhance", true)
    group:recipe("practice_afs_precog_craft_bonus", true)
    group:recipe("practice_afs_precog_dodge_bonus", true)
    group:recipe("practice_afs_precog_melee_enhance", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "afs_telekinesis_practice",
        name = ccb.content.text("contemplation: telekinesis"),
        description = ccb.content.text("Recipes related to practicing telekinesis."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_PSI",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 10,
    }
    group:recipe("practice_afs_telekinetic_move_items", true)
    group:recipe("practice_afs_telekinetic_move_creatures", true)
    group:recipe("practice_afs_telekinetic_momentum", true)
    group:recipe("practice_afs_telekinetic_wave", true)
    group:recipe("practice_afs_telekinetic_hammer", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "afs_telepathy_practice",
        name = ccb.content.text("contemplation: telepathy"),
        description = ccb.content.text("Recipes related to practicing telepathy."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_PSI",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 10,
    }
    group:recipe("practice_afs_telepathic_shield", true)
    group:recipe("practice_afs_telepathic_mind_sense", true)
    group:recipe("practice_afs_telepathic_suggestion", true)
    group:recipe("practice_afs_telepathic_confusion", true)
    group:recipe("practice_afs_telepathic_blast", true)
    content.add(group)
end
