local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_milbot_base",
    abstract = true,
    looks_like = "mon_secubot",
    name = ccb.content.text_without_extraction("military robot"),
    description = ccb.content.text_without_extraction("A military robot still operating due to its internal power core.  This one is armed with an electric prod and an integrated 5.56mm firearm."),
    default_faction = "WraitheonRobotics",
    species = { "ROBOT" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 80,
    speed = 100,
    materials = { "steel" },
    symbol = "R",
    color = "red_green",
    aggression = 50,
    morale = 100,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    dodge = 4,
    vision_day = 50,
    pathing = { max_distance = 5 },
    flags = {
        "SEES", "HEARS", "BASHES", "ELECTRONIC", "NO_BREATHE", "BIOLOGICALPROOF", "PRIORITIZE_TARGETS",
        "PATH_AVOID_DANGER", "VENOM_IMMUNE",
    },
    armor = { bash = 12, cut = 12, stab = 6, acid = 12, heat = 5 },
    death = {
        drops = { groups = { { id = "broken_robots", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_defbot_base",
    abstract = true,
    looks_like = "mon_secubot",
    name = ccb.content.text_without_extraction("defense robot"),
    description = ccb.content.text_without_extraction("An automated defense robot still active due to its internal power source.  This one is armed with an electric prod and an integrated 9mm firearm."),
    default_faction = "cop_bot",
    species = { "ROBOT" },
    difficulty_adjustment = 10,
    volume = "62500 ml",
    mass = "81500 g",
    hp = 80,
    speed = 100,
    materials = { "steel" },
    symbol = "R",
    color = "light_blue",
    aggression = 100,
    morale = 100,
    luminance = 20,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    dodge = 4,
    vision_day = 50,
    pathing = { max_distance = 5 },
    flags = {
        "SEES", "HEARS", "BASHES", "ELECTRONIC", "NO_BREATHE", "BIOLOGICALPROOF", "PRIORITIZE_TARGETS",
        "PATH_AVOID_DANGER", "VENOM_IMMUNE",
    },
    armor = { bash = 10, cut = 10, stab = 5, acid = 10, heat = 5 },
    death = {
        drops = { groups = { { id = "broken_robots", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_advbot_base",
    abstract = true,
    copy_from = "mon_defbot_base",
    looks_like = "mon_copbot",
    name = ccb.content.text_without_extraction("advanced robot"),
    description = ccb.content.text_without_extraction("An advanced robot still functioning due to its internal fusion core.  This model is armed with a powerful laser-emitter."),
    default_faction = "defense_bot",
    species = { "ROBOT" },
    hp = 100,
    vision_day = 50,
    speed = 110,
    color = "white_cyan",
    aggression = 100,
    dodge = 5,
    armor = { bash = 8, cut = 6, stab = 6, acid = 12, heat = 8 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "afs_mon_reaver_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("bandits, pirates and reavers", "bandits, pirates and reavers"),
    description = ccb.content.text_without_extraction("A scavenger willing to engage in violence to scavenge your remains."),
    default_faction = "reavers",
    species = { "HUMAN" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 80,
    speed = 100,
    materials = { "flesh" },
    symbol = "r",
    color = "light_green_yellow",
    aggression = 50,
    morale = 100,
    anger_triggers = { "HURT", "FRIEND_DIED", "PLAYER_CLOSE" },
    aggressive_to_characters = false,
    melee_skill = 5,
    melee_dice = 3,
    melee_sides = 3,
    melee_armor_penetration = 3,
    dodge = 3,
    vision_day = 30,
    vision_night = 6,
    pathing = { max_distance = 5 },
    harvest = "human",
    dissect = "dissect_human_reaver",
    flags = {
        "SEES", "HEARS", "SMELLS", "BASHES", "GROUP_BASH", "HUMAN", "CAN_OPEN_DOORS",
        "PATH_AVOID_DANGER", "PRIORITIZE_TARGETS", "WIELDED_WEAPON", "VENOM_IMMUNE",
    },
    armor = { bash = 12, cut = 12, stab = 6, acid = 12, heat = 5 },
    death = { drops = { groups = { { id = "afs_bandits", weight = 1 } } } },
}
