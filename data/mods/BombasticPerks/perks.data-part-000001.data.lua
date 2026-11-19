local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_STR_UP",
    name = ccb.content.text("Stronger"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Have you been working out?  +1 Strength."),
    replacements = { "perk_STR_UP_2" },
    enchantments = { "INLINE_ENCH_perk_STR_UP_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_STR_UP_2",
    name = ccb.content.text("Even Stronger"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You HAVE been working out.  +2 Strength."),
    prerequisites = { "perk_STR_UP" },
    enchantments = { "INLINE_ENCH_perk_STR_UP_2_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_DEX_UP",
    name = ccb.content.text("Faster"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Have you been doing cardio?  +1 Dexterity."),
    replacements = { "perk_DEX_UP_2" },
    enchantments = { "INLINE_ENCH_perk_DEX_UP_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_DEX_UP_2",
    name = ccb.content.text("Even Faster"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You HAVE been doing cardio.  +2 Dexterity."),
    prerequisites = { "perk_DEX_UP" },
    enchantments = { "INLINE_ENCH_perk_DEX_UP_2_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_INT_UP",
    name = ccb.content.text("Smarter"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Have you been reading?  +1 Intelligence."),
    replacements = { "perk_INT_UP_2" },
    enchantments = { "INLINE_ENCH_perk_INT_UP_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_INT_UP_2",
    name = ccb.content.text("Even Smarter"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You HAVE been reading.  +2 Intelligence."),
    prerequisites = { "perk_INT_UP" },
    enchantments = { "INLINE_ENCH_perk_INT_UP_2_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_PER_UP",
    name = ccb.content.text("Sharper"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Have you been staring out into the middle distance?  +1 Perception."),
    replacements = { "perk_PER_UP_2" },
    enchantments = { "INLINE_ENCH_perk_PER_UP_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_PER_UP_2",
    name = ccb.content.text("Even Sharper"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You HAVE been staring out into the middle distance.  +2 Perception."),
    prerequisites = { "perk_PER_UP" },
    enchantments = { "INLINE_ENCH_perk_PER_UP_2_0" },
    flags = { "PERK" },
}
