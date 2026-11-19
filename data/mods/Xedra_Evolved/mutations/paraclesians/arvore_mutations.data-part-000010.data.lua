local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_THORN_SKIN_ON",
    name = ccb.content.text_without_extraction("Unveiled Thorns Extended"),
    points = 7,
    visibility = 8,
    ugliness = 4,
    description = ccb.content.text_without_extraction("You are exuding thorns through your skin that have a chance of damaging attackers while increasing the damage of your unarmed attacks.  However, you cannot wear rigid armor over your thorns."),
    categories = { "ARVORE" },
    purifiable = false,
    player_display = false,
    valid = false,
    restricts_gear = { "head", "torso", "arm_l", "arm_r", "leg_r", "leg_l" },
    remove_rigid = { "head", "torso", "arm_l", "arm_r", "leg_r", "leg_l" },
    allow_soft_gear = true,
    integrated_armor = { "integrated_arvore_thorns" },
    enchantments = { "ench_arvore_thorns_mut" },
    covered_encumbrance = { hand_l = 10, hand_r = 10 },
}
