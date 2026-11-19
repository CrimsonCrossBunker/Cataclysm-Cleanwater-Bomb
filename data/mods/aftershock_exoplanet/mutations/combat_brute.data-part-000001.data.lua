local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_COMBAT_BRUTE",
    name = ccb.content.text("Perfect Warrior"),
    points = 1,
    description = ccb.content.text("None around you could best you in a fight."),
    valid = false,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "AFS_THROWING_STRENGTH",
    name = ccb.content.text("All-Star Pitch"),
    description = ccb.content.text("If you throw a grenade at someone, it will first cave their skull in."),
    categories = { "COMBAT_BRUTE" },
    points = 2,
    replacements = { "GOODCARDIO2" },
    enchantments = { "INLINE_ENCH_AFS_THROWING_STRENGTH_0" },
}

ccb.content.define_mutation {
    id = "AFS_STRONG",
    name = ccb.content.text("Bio-Sculpted Musculature"),
    description = ccb.content.text("Your arms and legs are finely threaded pieces of living machinery, greatly increasing your strength and capacity to lift and carry heavy objects.  Unfortunately, the complex tissue heals at a slower rate than normal."),
    categories = { "COMBAT_BRUTE" },
    points = 4,
    enchantments = { "INLINE_ENCH_AFS_STRONG_0" },
}

ccb.content.define_mutation {
    id = "AFS_GOOD_HEAD",
    name = ccb.content.text("Intra-Cranial Padding"),
    description = ccb.content.text("Internal bladders of cerebrospinal fluid better protect your brain from trauma and concussions.  You cannot be stunned in melee, and your head is more resistant than normal.  The reduced brain volume has slightly deleterious effects on your intelligence and learning ability."),
    categories = { "COMBAT_BRUTE" },
    points = 1,
    integrated_armor = { "integrated_cranial_padding" },
    enchantments = { "INLINE_ENCH_AFS_GOOD_HEAD_0" },
}

ccb.content.define_mutation {
    id = "AFS_WAR_BUILD",
    name = ccb.content.text("Superhuman Physique"),
    description = ccb.content.text("Your augmented body dwarfs anything ordinary humans can achieve.  You are stronger, faster, and more durable than any unaugmented human could ever hope to be."),
    threshold_requirements = { "THRESH_COMBAT_BRUTE" },
    points = 15,
    categories = { "COMBAT_BRUTE" },
    enchantments = { "INLINE_ENCH_AFS_WAR_BUILD_0" },
}
