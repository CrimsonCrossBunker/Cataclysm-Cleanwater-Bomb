local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DEBUG_TORSO",
    name = ccb.content.text("Debug Torso Replacement"),
    points = 99,
    valid = false,
    description = ccb.content.text("They said college what make me smart, this is a lot to lug around!"),
    enchantments = { "ENCH_DEBUG_TORSO" },
    debug = true,
}

ccb.content.define_mutation {
    id = "EYEBULGE",
    name = ccb.content.text("Bulging Eyes"),
    types = { "EYES" },
    points = 0,
    visibility = 8,
    ugliness = 4,
    description = ccb.content.text("Your eyes bulge out several inches from your skull.  This does not affect your vision in any way."),
    enchantments = { "INLINE_ENCH_EYEBULGE_0" },
    additions = { "MEMBRANE", "PRE_EYES_INSECT" },
    replacements = { "EYES_INSECT", "COMPOUND_EYES", "EYESTALKS1", "CEPH_EYES", "FROG_EYES" },
    categories = { "BATRACHIAN", "INSECT", "GASTROPOD", "FISH", "CEPHALOPOD", "CRUSTACEAN" },
}
