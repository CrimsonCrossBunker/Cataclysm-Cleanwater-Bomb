local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MELEE_PERK_INSIGHT",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Insight I"),
    description = ccb.content.text("You passively accumulate up to 20 insight stacks while near enemies.  Each insight stack increases all damage dealt by 1 until your next attack.  Insight greatly favors perceptive warriors."),
    flags = { "MELEE_PERK_INSIGHT" },
    enchantments = { "melee_perk_ench_insight" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_INSIGHT_DODGE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Like Water"),
    description = ccb.content.text("You gain a +25 dodge chance if you have at least 10 insight stacks."),
    flags = { "MELEE_PERK_LIKE_WATER" },
    enchantments = { "melee_perk_ench_insight_dodge" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_SIXTH_SENSE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Sixth Sense"),
    description = ccb.content.text("You accumulate up to 20 insight stacks even from enemies you can't see.  You can perceive unseen enemies within 10 tiles if you have at least 10 insight stacks."),
    flags = { "MELEE_PERK_SIXTH_SENSE" },
    enchantments = { "melee_perk_ench_six_sense" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_INSIGHT_INFINITE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("The Psychic Sea"),
    description = ccb.content.text("You can accumulate an infinite number of insight stacks."),
    flags = { "MELEE_PERK_INSIGHT_INFINITE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_TWILIGHT_FORM",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Twilight Form"),
    description = ccb.content.text("Whenever you kill an enemy in melee, you retain 50% of your insight stacks."),
    flags = { "MELEE_PERK_TWILIGHT_FORM" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_BLIND_CALCULUS",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Blind Calculus"),
    description = ccb.content.text("If you have been blind for at least 15 turns, every time you would gain an insight stack you instead gain 5."),
    flags = { "MELEE_PERK_BLIND_CALCULUS" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_MYSTIC_SHOT",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Mystic Shot I"),
    description = ccb.content.text("Insight stacks also increase the accuracy of ranged bow and crossbow attacks by 2% per stack.  Ranged attacks will consume insight stacks."),
    flags = { "MELEE_PERK_MYSTIC_SHOT" },
    enchantments = { "melee_perk_ench_insight_mystic_shot" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_MYSTIC_SHOT_2",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Mystic Shot II"),
    description = ccb.content.text("Insight stacks also increase the damage of ranged bow and crossbow attacks by 1% per stack."),
    flags = { "MELEE_PERK_MYSTIC_SHOT_2" },
    enchantments = { "melee_perk_ench_insight_mystic_shot_2" },
}
