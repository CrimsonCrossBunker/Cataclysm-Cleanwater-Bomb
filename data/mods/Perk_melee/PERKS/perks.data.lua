local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "MELEE_PERK_BASE",
    name = ccb.content.text_without_extraction("Melee Perk"),
    points = 0,
    description = ccb.content.text_without_extraction("We copy from this one."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "MELEE_PERK_CAREFREE_STANCE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Carefree Stance"),
    description = ccb.content.text("You aren't even trying.\nYou clear all combat buffs whenever you wait."),
    flags = { "MELEE_PERK_CAREFREE_STANCE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_PRESSURE_STRIKES",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Pressure Points"),
    description = ccb.content.text("Your unarmed melee attacks will redeal damage to their targets after 4 turns."),
    flags = { "MELEE_PERK_PRESSURE_STRIKES" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_MOVING_DODGE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Flowing Retreat"),
    description = ccb.content.text("You'll attempt to move away from your attackers when you successfully dodge an attack.  You'll gain a momentum stack if you can normally gain them."),
    flags = { "MELEE_PERK_MOVING_DODGE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_UNDODGING",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Unyielding"),
    description = ccb.content.text("You might choose to stop dodging attacks.  Activate to toggle this behavior."),
    flags = { "MELEE_PERK_MOVING_UNDODGING" },
    active = true,
    enchantments = { "melee_perk_ench_undodging" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_RIPOSTE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Counter Strikes"),
    description = ccb.content.text("You gain +1 accuracy for two turns after a successful block."),
    flags = { "MELEE_PERK_RIPOSTE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_BLOCK",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Stalwart"),
    description = ccb.content.text("You have an extra block attempt per turn."),
    flags = { "MELEE_PERK_BLOCK" },
    enchantments = { "INLINE_ENCH_MELEE_PERK_BLOCK_0" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_DODGE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Spry footwork"),
    description = ccb.content.text("You have an extra dodge attempt per turn."),
    flags = { "MELEE_PERK_DODGE" },
    enchantments = { "INLINE_ENCH_MELEE_PERK_DODGE_0" },
}
