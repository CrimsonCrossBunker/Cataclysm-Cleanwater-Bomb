local ccb = require("ccb")

-- No body part is intentional.  The wings should not be attackable by enemies or get in the way of clothes or armor.  These are also intended as less of a wide stat boost than the other dream toggleable mutations and instead specifically allow flight and carry weight.
ccb.content.define_mutation {
    id = "ethereal_wings",
    name = ccb.content.text("Ethereal Wings"),
    active = true,
    points = 1,
    visibility = 10,
    description = ccb.content.text("A wide set of ethereal wings sprouts from your back.  Despite them phasing through every form of matter you've encountered, they still somehow lift you off the ground.  Their mere appearance makes you feel lighter"),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "dismiss_ethereal_wings",
    enchantments = {
        "INLINE_ENCH_ethereal_wings_0",
        "INLINE_ENCH_ethereal_wings_1",
    },
    flags = { "GLIDE", "FEATHER_FALL" },
}

ccb.content.define_mutation {
    id = "karma_arms",
    name = ccb.content.text("Karma"),
    active = true,
    points = 1,
    visibility = 10,
    description = ccb.content.text("Ethereal hands appear behind your back, making you looks like an ancient god."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "dismiss_karma_arms",
    enchantments = {
        "INLINE_ENCH_karma_arms_0",
        "INLINE_ENCH_karma_arms_1",
    },
}

ccb.content.define_mutation {
    id = "devil_tail",
    name = ccb.content.text("Devil's Tail"),
    active = true,
    points = 1,
    visibility = 6,
    description = ccb.content.text("While not actually a devil's, this long, triangular pointed tail can stretch very far, allowing it to easily kill someone nearby."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "dismiss_devil_tail",
    enchantments = {
        "INLINE_ENCH_devil_tail_0",
        "INLINE_ENCH_devil_tail_1",
    },
}

ccb.content.define_mutation {
    id = "stalker_eyes",
    name = ccb.content.text("Stalker's Vision"),
    active = true,
    points = 1,
    visibility = 1,
    description = ccb.content.text("Your eyes transform into the orbits of an unknown creature.  You now see much better in the light and dark."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "dismiss_stalker_eyes",
    enchantments = {
        "INLINE_ENCH_stalker_eyes_0",
        "INLINE_ENCH_stalker_eyes_1",
    },
}

ccb.content.define_mutation {
    id = "LUCID_DREAM",
    name = ccb.content.text("Sleeper"),
    active = true,
    points = 99,
    description = ccb.content.text("You still sleep, yet your dreams still can impact the world.  Activate to wake up."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "end_lucid_dream",
}
