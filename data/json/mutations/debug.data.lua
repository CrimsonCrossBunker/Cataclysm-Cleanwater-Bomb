local ccb = require("ccb")

-- Moved to mainline so multiple mods have access to this debug trait.
ccb.content.define_mutation {
    id = "DEBUG_MANA",
    name = ccb.content.text("Debug Mana"),
    description = ccb.content.text("To cast bug killing spells.  Also increase the cast speed of spells."),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "INLINE_ENCH_DEBUG_MANA_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_MANA_FURNACE",
    name = ccb.content.text("Debug Mana Furnace"),
    description = ccb.content.text("Using mana to incinerate all bugs, activate to start burning."),
    points = 99,
    debug = true,
    valid = false,
    active = true,
    transform = {
        target = "DEBUG_MANA_FURNACE_active",
        message = ccb.content.text("You start using mana to burning bugs."),
        active = true,
        moves = 0,
    },
}

ccb.content.define_mutation {
    id = "DEBUG_MANA_FURNACE_active",
    copy_from = "DEBUG_MANA_FURNACE",
    name = ccb.content.text("Debug Mana Furnace (ON)"),
    description = ccb.content.text("You're burning mana like crazy to burn of all bugs, also making you glow softly."),
    cooldown = "1 s",
    cost = 100,
    consumes_mana = true,
    body_light = { torso = 8 },
    transform = {
        target = "DEBUG_MANA_FURNACE",
        message = ccb.content.text("You stop incinerating bugs with mana."),
        active = false,
        moves = 0,
    },
}

ccb.content.define_mutation {
    id = "DEBUG_NOSCENT",
    name = ccb.content.text("Debug Deodorizer"),
    description = ccb.content.text("Smell that bug?  Smell's certainly not coming from you!"),
    points = 99,
    debug = true,
    valid = false,
    flags = { "NO_SCENT" },
}

ccb.content.define_mutation {
    id = "DEBUG_SILENT",
    name = ccb.content.text("Debug Silent Walk"),
    description = ccb.content.text("Be vewwy vewwy quiet.  We're hunting bugs."),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "MUT_DEBUG_FREE_DODGES",
    name = ccb.content.text("Debug Free Dodges"),
    description = ccb.content.text("You'll never get tired of testing dodges!"),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "ENCH_DEBUG_FREE_DODGES" },
}

ccb.content.define_mutation {
    id = "DEBUG_TAIL",
    name = ccb.content.text("Debug Tail"),
    description = ccb.content.text("Gain a tail bodypart."),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "ENCH_DEBUG_TAIL" },
}

ccb.content.define_mutation {
    id = "DEBUG_ONLY_HEAD",
    name = ccb.content.text("Debug No Torso"),
    description = ccb.content.text("They said college costs an arm and a leg, they sure weren't kidding!"),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "ENCH_DEBUG_ONLY_HEAD" },
}

ccb.content.define_mutation {
    id = "DEBUG_BIG_HEAD",
    name = ccb.content.text("Debug Big Head"),
    description = ccb.content.text("They said college what make me smart, this is a lot to lug around!"),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "ENCH_DEBUG_BIG_HEAD" },
}

ccb.content.define_mutation {
    id = "DEBUG_WEIGHT_MULT",
    name = ccb.content.text("Debug Half Weight"),
    description = ccb.content.text("Better than GLP1 drugs!"),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "ENCH_DEBUG_WEIGHT_MODIFIER" },
}

ccb.content.define_mutation {
    id = "DEBUG_NO_ENCUMBRANCE",
    name = ccb.content.text("Debug No Encumbrance"),
    description = ccb.content.text("Wear 20 shirts.  It's the end of the world, you can do what you want."),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "INLINE_ENCH_DEBUG_NO_ENCUMBRANCE_0" },
}
