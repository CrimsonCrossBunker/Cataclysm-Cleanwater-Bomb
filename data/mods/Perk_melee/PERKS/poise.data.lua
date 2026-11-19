local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MELEE_PERK_POISE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Defensive Stance"),
    description = ccb.content.text("You gain a stance meter that absorbs incoming melee attacks.  Dodging or taking melee damage reduces your stance, and when it reaches zero your stance is broken, causing you to take increased damage until you regain your footing."),
    flags = { "MELEE_PERK_POISE" },
    enchantments = { "melee_perk_ench_poise" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_SHRUG_OFF",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Shrug it off"),
    description = ccb.content.text("If your stance meter is full, you take 60% less damage from ballistic attacks."),
    flags = { "MELEE_PERK_SHRUG_OFF" },
    enchantments = { "melee_perk_ench_shrug_off" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_POISE_MOUNTAIN",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("The Mountain"),
    description = ccb.content.text("Waiting actions refill your stance.  All movement actions reduce your stance by 1."),
    flags = { "MELEE_PERK_POISE_MOUNTAIN" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_POISE_PARRY",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Perfect Parry"),
    description = ccb.content.text("If your stance meter is full, any successful block or parry will stagger your attacker for 2 turns."),
    flags = { "MELEE_PERK_POISE_PARRY" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_POISE_RECKLESS",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Recklessness"),
    description = ccb.content.text("You stamina regeneration is tripled while stance broken."),
    flags = { "MELEE_PERK_POISE_RECKLESS" },
    enchantments = { "melee_perk_ench_poise_reckless" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_POISE_FOOTWORK",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Master's Footwork"),
    description = ccb.content.text("You regain stance on every automatic movement action you perform."),
    flags = { "MELEE_PERK_POISE_FOOTWORK" },
}
