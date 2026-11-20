local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_limb_leg_l",
    name = ccb.content.text("Bionic Limb - Left Leg"),
    description = ccb.content.text("CBM which replaces your left leg with a bionic counterpart."),
    enchantments = { "ENCH_BIONIC_LEG_L" },
    passive_pseudo_items = { "armor_bio_leg_l" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    give_mutation_on_removal = { "NO_LEFT_LEG" },
})
content.add(content.Bionic {
    id = "bio_limb_leg_r",
    name = ccb.content.text("Bionic Limb - Right Leg"),
    description = ccb.content.text("CBM which replaces your right leg with a bionic counterpart."),
    enchantments = { "ENCH_BIONIC_LEG_R" },
    passive_pseudo_items = { "armor_bio_leg_r" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    give_mutation_on_removal = { "NO_RIGHT_LEG" },
})
content.add(content.Bionic {
    id = "bio_limb_treads",
    name = ccb.content.text("Bionic Limb - Tank Treads"),
    description = ccb.content.text("CBM which replaces your legs with tank treads."),
    enchantments = { "ENCH_BIONIC_TREADS" },
    passive_pseudo_items = { "armor_bio_treads" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    give_mutation_on_removal = { "NO_LEFT_LEG", "NO_RIGHT_LEG" },
})
content.add(content.Bionic {
    id = "bio_limb_arm_l",
    name = ccb.content.text("Bionic Limb - Left Arm"),
    description = ccb.content.text("CBM which replaces your left leg with a bionic counterpart."),
    enchantments = { "ENCH_BIONIC_ARM_L" },
    passive_pseudo_items = { "armor_bio_arm_l" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    give_mutation_on_removal = { "NO_LEFT_ARM" },
})
content.add(content.Bionic {
    id = "bio_limb_arm_r",
    name = ccb.content.text("Bionic Limb - Right Arm"),
    description = ccb.content.text("CBM which replaces your right leg with a bionic counterpart."),
    enchantments = { "ENCH_BIONIC_ARM_R" },
    passive_pseudo_items = { "armor_bio_arm_r" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    give_mutation_on_removal = { "NO_RIGHT_ARM" },
})
