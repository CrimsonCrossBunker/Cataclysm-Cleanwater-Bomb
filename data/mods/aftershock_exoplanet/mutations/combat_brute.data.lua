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

ccb.content.define_mutation {
    id = "AFS_COMBAT_DRUG_PRODUCTION",
    name = ccb.content.text("Stimulant biosynthesis"),
    description = ccb.content.text("You naturally produce combat-enhancing substances, and you might consciously trigger their release as you see fit."),
    vitamin_cost = 350,
    points = 15,
    active = true,
    cost = 800,
    consumes_calories = true,
    activation_message = ccb.content.text("You release the flood of combat-enhancing substances into your bloodstream."),
    on_activate = "activate_afs_combat_drug_production",
    categories = { "COMBAT_BRUTE" },
}

ccb.content.define_mutation {
    id = "AFS_HYPERMETABOLISM",
    name = ccb.content.text("Hypermetabolism"),
    description = ccb.content.text("Your particular metabolism allows you to burn calories at a prodigious rate to regenerate tissues in a matter of minutes; this is, however, a very wasteful process.  Activate to start healing."),
    threshold_requirements = { "THRESH_COMBAT_BRUTE" },
    categories = { "COMBAT_BRUTE" },
    types = { "METABOLISM" },
    points = 15,
    active = true,
    vitamin_cost = 350,
    transform = {
        target = "AFS_HYPERMETABOLISM_active",
        message = ccb.content.text("Your hyper-metabolism starts burning up calories."),
        active = true,
        moves = 0,
    },
}

ccb.content.define_mutation {
    id = "AFS_HYPERMETABOLISM_active",
    copy_from = "AFS_HYPERMETABOLISM",
    name = ccb.content.text("Hyper-Metabolism: burning"),
    description = ccb.content.text("You're burning calories like crazy to heal your wounds."),
    valid = false,
    cooldown = "1 s",
    cost = 9,
    consumes_calories = true,
    transform = {
        target = "AFS_HYPERMETABOLISM",
        message = ccb.content.text("Your hyper-metabolism slows down."),
        active = false,
        moves = 0,
    },
    enchantments = { "INLINE_ENCH_AFS_HYPERMETABOLISM_active_0" },
}

ccb.content.define_mutation {
    id = "AFS_FAST_BLOOD_PRODUCTION",
    name = ccb.content.text("Accelerated Hematopoiesis"),
    description = ccb.content.text("Your body produces blood at a prodigious rate, allowing you to recover from injuries that would be fatal to any ordinary human."),
    points = 15,
    enchantments = { "INLINE_ENCH_AFS_FAST_BLOOD_PRODUCTION_0" },
    threshold_requirements = { "THRESH_COMBAT_BRUTE" },
    categories = { "COMBAT_BRUTE" },
}

ccb.content.define_mutation {
    id = "AFS_REDUNDANT_ORGANS",
    name = ccb.content.text("Distributed Physiology"),
    description = ccb.content.text("Your vital organs have been restructured, split and distributed all across your body.  Anyone lucky enough to hit you is unlikely to deal a fatal blow."),
    threshold_requirements = { "THRESH_COMBAT_BRUTE" },
    points = 15,
    categories = { "COMBAT_BRUTE" },
    enchantments = { "INLINE_ENCH_AFS_REDUNDANT_ORGANS_0" },
}
