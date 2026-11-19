local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MELEE_PERK_MOMENTUM",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Momentum I"),
    description = ccb.content.text("Rapid movement generates momentum stacks.  Momentum greatly favors dextrous warriors."),
    replacements = { "MELEE_PERK_MOMENTUM_2" },
    flags = { "MELEE_PERK_MOMENTUM" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_MOMENTUM_2",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Momentum II"),
    description = ccb.content.text("Rapid movement generates momentum stacks.  As long as momentum is active your attacks gain extra physical damage equal to 10% of your dexterity.  You gain a point of dexterity for every 2 momentum stacks."),
    flags = { "MELEE_PERK_MOMENTUM" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_MOMENTUM_BULLET_DODGE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Ballistic Evasion"),
    description = ccb.content.text("If you have at least 4 momentum stacks, gain a 5% chance to dodge any ranged attack for every point of dexterity you have.  If you have less than 4 momentum stacks, gain a 1% chance to dodge any ranged attack for every point of dexterity you have."),
    flags = { "MELEE_PERK_MOMENTUM_BULLET_DODGE" },
    enchantments = { "melee_perk_ench_momentum_bullet_dodge" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_MOMENTUM_DUELIST",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Duelist Form"),
    description = ccb.content.text("If you have more than 1 momentum stack, your momentum will be set to 1 whenever you wait a turn."),
    flags = { "MELEE_PERK_MOMENTUM_DUELIST" },
}
