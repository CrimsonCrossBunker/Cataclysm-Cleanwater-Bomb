local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_metamagic_quicken",
    name = ccb.content.text("Metamagic: Quicken Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells in a way that is much quicker, but also more wasteful.  -95% cast time, +100% cast cost.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your quicken metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_extended",
    name = ccb.content.text("Metamagic: Extended Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to make the effects of your spells last much longer for the same amount of mana with a more challenging invocation.  +100% duration, +4 difficulty.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your extended metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_widen",
    name = ccb.content.text("Metamagic: Widen Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells that affects a larger area.  +100% area of effect, +50% cast cost.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your widen metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_reach",
    name = ccb.content.text("Metamagic: Reach Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells from a longer distance.  +100% reach, +50% cast cost.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your reach metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_silent",
    name = ccb.content.text("Metamagic: Silent Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells quietly.  -100% noise, +20% cast cost, ignores mouth encumbrance.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your silent metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_still",
    name = ccb.content.text("Metamagic: Still Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells without moving.  +20% cast cost, ignores arm, leg, and hand encumbrance.  Can cast spells while holding items.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your still metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_careful",
    name = ccb.content.text("Metamagic: Careful Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You take your time when casting spells in order to get it right.  +200% cast time, -5 difficulty.  Can be toggled on or of by activating this trait."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your careful metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_efficient",
    name = ccb.content.text("Metamagic: Efficient Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You can cast your spells more efficiently at the cost of a more difficult cast.  *75% casting cost, +5 difficulty.  Can be toggled on or of by activating this trait."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your efficient metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_intuitive",
    name = ccb.content.text("Metamagic: Intuitive Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Casting spells comes more naturally for you.  You don't have to think as much when casting.  Focus no longer affects casting, +20% cast cost.  Can be toggled on or of by activating this trait.  Only affects spells that are affected by focus.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your intuitive metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}
