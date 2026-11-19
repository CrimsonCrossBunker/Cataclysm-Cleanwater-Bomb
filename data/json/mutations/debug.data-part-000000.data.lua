local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DEBUG_CLAIRVOYANCE_PLUS",
    name = ccb.content.text("Debug Clairvoyance"),
    description = ccb.content.text("Being able to see through walls and the floor is clearly for dev purposes only."),
    points = 99,
    debug = true,
    valid = false,
    flags = { "CLAIRVOYANCE_PLUS" },
}

ccb.content.define_mutation {
    id = "DEBUG_CLAIRVOYANCE",
    name = ccb.content.text("Debug Clairvoyance Super"),
    description = ccb.content.text("Much bigger range than the other Debug Clairvoyance trait.  Unsure which one to use?  Use them both!  You can see all the bugs with this one."),
    points = 99,
    debug = true,
    valid = false,
    flags = { "SUPER_CLAIRVOYANCE" },
}

ccb.content.define_mutation {
    id = "DEBUG_NIGHTVISION",
    name = ccb.content.text("Debug Night and Map Vision"),
    description = ccb.content.text("Grants flawless night vision and the ability to see all of the overmaps without having to reveal them manually.  As such, you can clearly see that this is for dev purposes only."),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "DEBUG_MIND_CONTROL",
    name = ccb.content.text("Debug Mind Control"),
    description = ccb.content.text("Mind the bugs, would you kindly?"),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "DEBUG_PHASE_MOVEMENT",
    name = ccb.content.text("Debug Phase Movement"),
    description = ccb.content.text("You can walk anywhere, do anything.  Neither walls nor gravity can stop you."),
    points = 99,
    debug = true,
    valid = false,
    flags = { "PHASE_MOVEMENT" },
}

ccb.content.define_mutation {
    id = "DEBUG_CLOAK",
    name = ccb.content.text("Debug Invisibility"),
    description = ccb.content.text("If you see this, you'd best be debugging something."),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "DEBUG_SPEED",
    name = ccb.content.text("Debug Speed"),
    description = ccb.content.text("With this, you'll be fixing those bugs faster than ever!"),
    points = 99,
    debug = true,
    valid = false,
    active = true,
    enchantments = { "INLINE_ENCH_DEBUG_SPEED_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_STAMINA",
    name = ccb.content.text("Debug Stamina"),
    description = ccb.content.text("Your energy to squash bugs is endless!"),
    points = 99,
    debug = true,
    valid = false,
    active = true,
    enchantments = { "INLINE_ENCH_DEBUG_STAMINA_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_CARDIO",
    name = ccb.content.text("Debug Cardio"),
    description = ccb.content.text("You can run, but you'll never run out of breath."),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "INLINE_ENCH_DEBUG_CARDIO_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_NODMG",
    name = ccb.content.text("Debug Invincibility"),
    description = ccb.content.text("Bug-repellent forcefield."),
    points = 99,
    debug = true,
    valid = false,
    flags = { "CANNOT_TAKE_DAMAGE" },
}

ccb.content.define_mutation {
    id = "DEBUG_PREVENT_DEATH",
    name = ccb.content.text("Debug Prevent Death"),
    description = ccb.content.text("You are prevented from death."),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "DEBUG_HP",
    name = ccb.content.text("Debug 9000 HP"),
    description = ccb.content.text("If you need to survive the deadliest bug attacks."),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "INLINE_ENCH_DEBUG_HP_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_HP_REGEN",
    name = ccb.content.text("Debug Regeneration"),
    description = ccb.content.text("Heal yourself from this stupid bug attacks."),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "INLINE_ENCH_DEBUG_HP_REGEN_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_LS",
    name = ccb.content.text("Debug Life Support"),
    description = ccb.content.text("Holds hunger, thirst, and sleepiness stable.  You can debug all year long with this one!"),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "DEBUG_NOTEMP",
    name = ccb.content.text("Debug HVAC"),
    description = ccb.content.text("Temperature and weather won't bug you."),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "DEBUG_LIGHT",
    name = ccb.content.text("Debug Light"),
    description = ccb.content.text("You start to emit a light, so you can debug in the darkest nights."),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "INLINE_ENCH_DEBUG_LIGHT_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_CS",
    name = ccb.content.text("Debug Crafting Speed"),
    description = ccb.content.text("Craft the bug out 50 times faster."),
    points = 99,
    debug = true,
    valid = false,
    enchantments = { "INLINE_ENCH_DEBUG_CS_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_CNF",
    name = ccb.content.text("Debug Crafting Virtuoso"),
    description = ccb.content.text("Crafting failures won't bug you any more."),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "DEBUG_HS",
    name = ccb.content.text("Debug Hammerspace"),
    description = ccb.content.text("Crafting and construction requirements bugger off with this one.  Apply with care."),
    points = 99,
    debug = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "DEBUG_BIONICS",
    name = ccb.content.text("Debug Bionic Installation"),
    description = ccb.content.text("Lets you instantly install torsion ratchets for your eight legs."),
    points = 99,
    debug = true,
    valid = false,
}
