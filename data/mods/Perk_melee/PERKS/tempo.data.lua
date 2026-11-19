local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MELEE_PERK_COMBAT_TEMPO",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Combat Tempo I"),
    description = ccb.content.text("Perfect.  Now do it again.\nAttacks generate stacks of combat tempo.  Tempo greatly favors the strong."),
    flags = { "MELEE_PERK_TEMPO" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_COMBAT_TEMPO_2",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Perfect Tempo"),
    description = ccb.content.text("You gain +15 quickness as long as you have the maximum number of combat tempo stacks."),
    flags = { "MELEE_PERK_PERFECT_TEMPO" },
    enchantments = { "melee_perk_ench_perfect_tempo" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_TEMPO_SHIFT",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Tempo Shift"),
    description = ccb.content.text("Gain a stack of combat tempo whenever you successfully block an attack."),
    flags = { "MELEE_PERK_TEMPO_SHIFT" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_TEMPO_ASSAULT",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Unrelenting Assault"),
    description = ccb.content.text("Whenever you kill an enemy in melee, you'll advance into their position and automatically attack an adjacent enemy.  You'll gain a momentum stack if you can normally gain them."),
    flags = { "MELEE_PERK_TEMPO_ASSAULT" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_TEMPO_ZONING",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Zoning"),
    description = ccb.content.text("If you have the maximum number of combat tempo stacks, killing an enemy will move you away from any other adjacent enemies.  This movement action will consume all of your combat tempo stacks, and grant you a momentum stack if can normally gain them."),
    flags = { "MELEE_PERK_TEMPO_ZONING" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_TEMPO_THROW",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Measured Throws"),
    description = ccb.content.text("Your throwing attacks deal 100% more damage for every combat tempo stack you have."),
    enchantments = { "INLINE_ENCH_MELEE_PERK_TEMPO_THROW_0" },
}
