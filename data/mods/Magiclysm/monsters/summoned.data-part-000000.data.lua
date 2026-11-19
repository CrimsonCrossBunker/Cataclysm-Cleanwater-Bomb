local ccb = require("ccb")

-- A buffed version for animist summons.
ccb.content.define_monster {
    id = "mon_magi_shadow",
    copy_from = "mon_shadow",
    name = ccb.content.plural_text("shadow", "shadows"),
    description = ccb.content.text("This is an animate shadow.  Looking like nothing more than an errant patch of normal shadow, it draws your attention by the way it moves subtly and whispers softly in the back of your mind.  Strange intrusive thoughts accompany the quiet murmur, awakening your most horrific memories and fears."),
    species = { "NETHER", "SUMMONED_CREATURE" },
    hp = 60,
    speed = 150,
    melee_skill = 8,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "stab", amount = 2.0, penetration = 20 } },
    dodge = 1,
    vision_day = 50,
    vision_night = 50,
    harvest = "exempt",
    defense = { id = "ZAPBACK", chance = 100 },
    flags = {
        "SEES", "HEARS", "GOODHEARING", "SMELLS", "NOHEAD", "HARDTOSHOOT", "GRABS", "WEBWALK", "PLASTIC",
        "ELECTRIC", "ACIDPROOF", "HIT_AND_RUN", "NO_BREATHE", "NOGIB",
    },
}

-- The version for monster summons.
ccb.content.define_monster {
    id = "mon_magi_shadow_monster",
    copy_from = "mon_magi_shadow",
    name = ccb.content.plural_text("shadow", "shadows"),
    description = ccb.content.text("This is an animate shadow.  Looking like nothing more than an errant patch of normal shadow, it draws your attention by the way it moves subtly and whispers softly in the back of your mind.  Strange intrusive thoughts accompany the quiet murmur, awakening your most horrific memories and fears."),
    species = { "NETHER", "SUMMONED_CREATURE" },
    default_faction = "zombie",
}

ccb.content.define_monster {
    id = "mon_keeper_of_the_glades_shaman",
    copy_from = "mon_keeper_of_the_glades",
    name = ccb.content.plural_text("keeper of the glades", "keeper of the glades"),
    species = { "FOREST_SPIRIT", "SUMMONED_CREATURE" },
    inheritance = { add = { attacks = {} } },
}
