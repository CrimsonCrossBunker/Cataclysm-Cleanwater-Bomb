local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PORTAL_DEPENDENT",
    name = ccb.content.text("Portal Dependent"),
    description = ccb.content.text("You feel alien in your own body, as if part of you remained behind with the storm.  You will suffer severely when not exposed to portal storms unless you find a way to anchor yourself to the world again."),
    points = -8,
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "REALITY_GRASP",
    name = ccb.content.text("Stabilized in Reality"),
    description = ccb.content.text("You have regained some substance and have stabilized somewhat, if not entirely.  Portal storm withdrawal will not affect you as strongly as before."),
    points = 1,
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "anti_shape",
    name = ccb.content.text("Extradimensional Comprehension"),
    description = ccb.content.text("In the tunnel at LIXA, you were inside of an impossible shape, where the X, Y, and Z axis were mere suggestions.  When you put the shape out of its misery, (as much misery as a concept can have), you saw it for what it was; just a shape.  You can now visualize \"impossible\" shapes in your mind's eye, rendering them mundane to you."),
    points = 1,
    player_display = true,
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_anti_shape_0" },
}

ccb.content.define_mutation {
    id = "HAS_NEMESIS",
    name = ccb.content.text("Hunted"),
    description = ccb.content.text("Something has been hunting you relentlessly.  You can outrun it, but it always seems to find you eventually."),
    points = -1,
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "TAINTED_SHADOW",
    name = ccb.content.text_without_extraction("Tainted Shadow"),
    description = ccb.content.text_without_extraction("You shouldn't see this.  This makes you spawn tainted shadows."),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NOT_GLASS",
    name = ccb.content.text("Comfortably Fluid"),
    description = ccb.content.text("You can hear your heartbeat in your ears, feel the blood sloshing around in your veins.  The uneven hitches in your breath, the aches in your joints, the rumbling of your stomach.  It's nasty and messy and ugly.  And you are extremely grateful for that."),
    points = 1,
    player_display = true,
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_NOT_GLASS_0" },
}
