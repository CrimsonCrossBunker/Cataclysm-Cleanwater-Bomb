local ccb = require("ccb")

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
