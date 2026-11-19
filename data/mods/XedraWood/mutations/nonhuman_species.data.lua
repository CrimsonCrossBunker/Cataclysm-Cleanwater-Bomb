local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LIZARDFOLK_BUILD",
    name = ccb.content.text("Lizardfolk"),
    types = { "HERITAGE" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 3,
    ugliness = 0,
    description = ccb.content.text("Lizardfolk are taller, stronger, and more resilient than humans but not much thicker and are surprisingly fast for their size (+1 STR, +1 DEX).  Also, they are carnivorous."),
    enchantments = { "INLINE_ENCH_LIZARDFOLK_BUILD_0" },
    vitamin_intervals = { vitC = -1200 },
    flags = { "HERITAGE", "CARNIVORE_DIET", "LARGE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "LIZARDFOLK_NO_HAIR",
    name = ccb.content.text_without_extraction("Lizardfolk No Hair Or Beard"),
    description = ccb.content.text_without_extraction("Removes all hair and beard if you're a lizardfolk.  You shouldn't see this."),
    points = 0,
    purifiable = false,
    player_display = false,
    mixed_effect = true,
    cancels = {
        "hair_beaded", "hair_body_length", "hair_braid", "hair_bun", "hair_buzzcut", "hair_crewcut",
        "hair_curls", "hair_detective", "hair_extremely_long", "hair_fro", "hair_long",
        "hair_long_mohawk", "hair_long_over_eye", "hair_medium", "hair_messy", "hair_modern",
        "hair_mohawk", "hair_mullet", "hair_ponytail", "hair_puff", "hair_punk_long", "hair_short",
        "hair_short_no_fringe", "hair_short_over_eye", "hair_super_princess", "hair_twintails",
        "hair_very_long", "natural_hair_growth", "FACIAL_HAIR_GOATEE", "FACIAL_HAIR_CIRCLE",
        "FACIAL_HAIR_ROYALE", "FACIAL_HAIR_ANCHOR", "FACIAL_HAIR_SHORTBOXED", "FACIAL_HAIR_CHEVRON",
        "FACIAL_HAIR_3DAYSTUBBLE", "FACIAL_HAIR_HORSESHOE", "FACIAL_HAIR_MUSTACHE",
        "FACIAL_HAIR_MUTTONCHOPS", "FACIAL_HAIR_GUNSLINGER", "FACIAL_HAIR_CHIN_STRIP",
        "FACIAL_HAIR_CHIN_CURTAIN", "FACIAL_HAIR_CHIN_STRAP", "FACIAL_HAIR_BEARD",
        "FACIAL_HAIR_BEARD_LONG", "FACIAL_HAIR_BEARD_VERY_LONG", "FACIAL_HAIR_HANDLEBAR",
        "FACIAL_HAIR_NECKBEARD", "FACIAL_HAIR_PENCIL", "FACIAL_HAIR_SHENANDOAH", "FACIAL_HAIR_SIDEBURNS",
        "FACIAL_HAIR_SOUL_PATCH", "FACIAL_HAIR_TOOTHBRUSH", "FACIAL_HAIR_VANDYKE", "FACIAL_HAIR_WALRUS",
        "FACIAL_HAIR_ZAPPA",
    },
}

-- Alternate so webbed hands are not a prerequisite
ccb.content.define_mutation {
    id = "WEBBED_LIZ_FEET",
    name = ccb.content.text("Lizardfolk Feet"),
    points = 1,
    types = { "FEET" },
    description = ccb.content.text("Your feet are heavily webbed, with three large scaled toes and a dewclaw in the back, allowing you to swim faster.  However, your feet are not designed for human footwear."),
    restricts_gear = { "foot_l", "foot_r" },
    flags = { "WEBBED_FEET", "TOUGH_FEET" },
    wet_protection = { { part = "foot_l", good = 6 }, { part = "foot_r", good = 6 } },
}

ccb.content.define_mutation {
    id = "WEBBED_LIZ_HANDS",
    name = ccb.content.text("Lizardfolk Hands"),
    description = ccb.content.text("Your hands are heavily webbed, causing problems with gloves.  However, you can swim much faster.  Slightly decreases wet penalties."),
    types = { "HANDS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    visibility = 3,
    ugliness = 2,
    flags = { "WEBBED_HANDS" },
    covered_encumbrance = { hand_l = 50, hand_r = 50 },
    wet_protection = { { part = "hand_l", good = 3 }, { part = "hand_r", good = 3 } },
}

ccb.content.define_mutation {
    id = "STRONGER_RESISTWARM_LIZ",
    name = ccb.content.text("High Heat Tolerance"),
    description = ccb.content.text("Used to the warmth of the swamps as you are, you are little bothered by heat."),
    types = { "ACCLIMATIZATION" },
    points = 3,
    valid = false,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_STRONGER_RESISTWARM_LIZ_0" },
}

ccb.content.define_mutation {
    id = "COLDBLOOD4_LIZ",
    flags = { "ECTOTHERM" },
    name = ccb.content.text("Ectothermia"),
    points = -3,
    description = ccb.content.text("Your body is permanently cold-blooded.  Your speed lowers or raises 1% for every 2 (1.1) degrees below or above 65 F (18.3 C).  All this and you need even more food to maintain your energy."),
    purifiable = false,
    types = { "METABOLISM" },
    enchantments = { "INLINE_ENCH_COLDBLOOD4_LIZ_0" },
}

ccb.content.define_mutation {
    id = "INFRARED_LIZ",
    name = ccb.content.text("Heatsight"),
    description = ccb.content.text("Your eyes are capable of sensing the heat of your prey.  And anyone else, if necessary."),
    points = 5,
    vitamin_cost = 210,
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "PRED_LIZ",
    name = ccb.content.text("Scalefolk Mindset"),
    description = ccb.content.text("While not completely predatory, the lizardfolk are generally not particularly invested in the welfare of warmbloods.  Their death does not affect you greatly, and your ability to maintain combat skills is enhanced."),
    points = 2,
    purifiable = false,
    types = { "PREDATION" },
    flags = { "PRED2" },
    enchantments = { "INLINE_ENCH_PRED_LIZ_0" },
}

ccb.content.define_mutation {
    id = "MUZZLE_LONG_LIZ",
    name = ccb.content.text("Lizardfolk Muzzle"),
    points = 0,
    visibility = 8,
    ugliness = 8,
    mixed_effect = true,
    description = ccb.content.text("Your face and jaws are those of a predatory lizard, with a set of sharp teeth to go with them.  They look NASTY--as do the bite wounds they can inflict--but prevent wearing mouthgear."),
    types = { "MUZZLE" },
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 10 },
    enchantments = { "INLINE_ENCH_MUZZLE_LONG_LIZ_0" },
}

ccb.content.define_mutation {
    id = "REGEN_LIZARDFOLK",
    name = ccb.content.text("Reptilian Healing"),
    description = ccb.content.text("Your broken limbs mend themselves without significant difficulty in addition to your already-quick healing.  You do not require splints for broken limbs."),
    cancels = { "ROT1", "ROT2", "ROT3" },
    points = 5,
    purifiable = false,
    vitamin_cost = 210,
    flags = { "MEND_ALL" },
    enchantments = { "INLINE_ENCH_REGEN_LIZARDFOLK_0" },
}
