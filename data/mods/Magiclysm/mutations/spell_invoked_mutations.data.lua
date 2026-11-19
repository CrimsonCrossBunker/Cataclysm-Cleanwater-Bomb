local ccb = require("ccb")

-- Mostly copied from Huge with some Tough mixed in.  Strength bonus includes improvements from STR_UP mutation that's normally required for LARGE
ccb.content.define_mutation {
    id = "BIO_GIANT_GROWTH",
    name = ccb.content.text("Giant-sized"),
    points = 2,
    visibility = 4,
    ugliness = 8,
    mixed_effect = true,
    description = ccb.content.text("Magic has made you grow to enormous size!"),
    flags = { "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_HUGE" },
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    social_modifiers = { intimidate = 15 },
    enchantments = { "INLINE_ENCH_BIO_GIANT_GROWTH_0" },
}

ccb.content.define_mutation {
    id = "BIO_LASHING_TENTACLES",
    name = ccb.content.text("Lashing Tentacles"),
    description = ccb.content.text("You have a pair of vicious barbed tentacles growing from your shoulders."),
    points = 2,
    visibility = 6,
    ugliness = 8,
    restricts_gear = { "arm_shoulder_l", "arm_shoulder_r" },
    remove_rigid = { "arm_shoulder_l", "arm_shoulder_r" },
    allow_soft_gear = true,
    attacks = {
        {
            player_message = ccb.content.text("You lash at %s with your tentacles!"),
            npc_message = ccb.content.text("%1$s lashes at %2$s with their tentacles!"),
            chance = 20,
            base_damage = { type = "cut", amount = 10 },
        },
    },
}

ccb.content.define_mutation {
    id = "EARTHSHAPER_STONE_SLEEP",
    name = ccb.content.text_without_extraction("Stony Sleep"),
    description = ccb.content.text_without_extraction("You are resting in the depths of the earth.  You should never actually see this."),
    player_display = false,
    points = 0,
    enchantments = { "INLINE_ENCH_EARTHSHAPER_STONE_SLEEP_0" },
}

ccb.content.define_mutation {
    id = "BESTIAL_MIND",
    name = ccb.content.text("Animalistic Mind"),
    description = ccb.content.text("It's hard to think.  Let the instinct take over."),
    points = -2,
    enchantments = { "INLINE_ENCH_BESTIAL_MIND_0" },
}

ccb.content.define_mutation {
    id = "BESTIAL_MIND_COMBAT",
    name = ccb.content.text("Predator's Mind"),
    description = ccb.content.text("Hunt.  Kill.  Feed."),
    points = 0,
    mixed_effect = true,
    enchantments = { "INLINE_ENCH_BESTIAL_MIND_COMBAT_0" },
    flags = { "CANNIBAL", "PRED4", "PSYCHOPATH", "STRICT_HUMANITARIAN" },
}

ccb.content.define_mutation {
    id = "ANIMIST_BODY_OF_SPIRIT_APPEARANCE",
    name = ccb.content.text_without_extraction("Body of Spirit"),
    description = ccb.content.text_without_extraction("You're a disembodied spirit so you're all glowy and blue.  Spooky!"),
    points = 0,
    valid = false,
    player_display = false,
    appearance = { id = "mon_hologram", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "MAG_STAG_BEETLE_BOND",
    name = ccb.content.text("Beetle Bond"),
    points = 0,
    description = ccb.content.text("You have gained a bond with a stag beetle."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}
