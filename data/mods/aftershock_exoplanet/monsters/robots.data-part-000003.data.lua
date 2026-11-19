local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_bloodhound_drone",
    copy_from = "base_drone",
    name = ccb.content.plural_text("bloodhound drone", "bloodhound drones"),
    description = ccb.content.text("A small, spiked quadcopter robot equipped with a high-power spotlight.  This automated seeker drone was originally designed to harry and harass fugitives while maintaining visual contact for other pursuers."),
    difficulty_adjustment = 2,
    default_faction = "science",
    speed = 150,
    color = "light_gray",
    scents_tracked = { "sc_human" },
    melee_skill = 2,
    melee_dice = 4,
    melee_sides = 3,
    dodge = 3,
    attacks = { { reference = "SEARCHLIGHT", cooldown = 1 } },
    luminance = 60,
    melee_damage = { { type = "cut", amount = 12 } },
    revert_item = "bot_bloodhound_drone",
    armor = { bash = 8, cut = 10, bullet = 15 },
    inheritance = { add = { flags = { "HIT_AND_RUN", "SMELLS" } }, remove = { flags = { "PACIFIST" } } },
    death = {
        drops = {
            groups = {
                { id = "robots", weight = 4 },
                { id = "manhack", weight = 1 },
                { id = "turret_searchlight", weight = 1 },
            },
        },
        outcome = { corpse = "BROKEN" },
    },
}

ccb.content.define_monster {
    id = "mon_utilibot",
    name = ccb.content.plural_text("EINAC Seneschal", "EINAC Seneschals"),
    looks_like = "mon_hazmatbot",
    description = ccb.content.text("One of the many cheaper models produced by EINAC.  It is supposedly multi-purpose, and equipped with several tools to facilitate this; however, it is commonly used for janitorial work."),
    default_faction = "utility_bot",
    species = { "ROBOT" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 150,
    speed = 70,
    materials = { "steel" },
    symbol = "R",
    color = "green",
    morale = 80,
    aggression = 0,
    melee_dice = 4,
    melee_sides = 5,
    anger_triggers = { "HURT" },
    vision_day = 50,
    flags = {
        "SEES",
        "HEARS",
        "ELECTRONIC",
        "BIOLOGICALPROOF",
        "NO_BREATHE",
        "PRIORITIZE_TARGETS",
        "PATH_AVOID_DANGER",
    },
    armor = { bash = 15, cut = 20, bullet = 30, afs_laser = 10 },
    death = {
        drops = { groups = { { id = "broken_robots", weight = 3 } } },
        outcome = { corpse = "BROKEN" },
    },
}

ccb.content.define_monster {
    id = "mon_hazmatbot",
    copy_from = "mon_utilibot",
    name = ccb.content.plural_text("TsKBEM Likvidator", "TsKBEM Likvidators"),
    description = ccb.content.text("A now ancient industrial robot line first made by the Soviet TsKBEM, and still in use thanks to its easily obtained fabrication schematics.  Built to operate within nuclear reactors and waste repositories, the Likvidator is assembled around an armored bipedal chassis that mounts several heavy manipulator arms.  Legend claims it was originally designed after a nuclear disaster during early space-age Earth."),
    hp = 250,
    armor = { bash = 15, cut = 20, bullet = 30, afs_laser = 10 },
}

ccb.content.define_monster {
    id = "mon_utilibot_butler",
    copy_from = "mon_utilibot",
    name = ccb.content.plural_text("EINAC Famulus", "EINAC Famuli"),
    color = "dark_gray",
    description = ccb.content.text("A top of the line luxury model, the Famulus is a humaniform robot, derived from Wraitheon schematics with slight alterations to give it a more human appearance.  Designed to be a robotic servant, its AI tailored for the needs of each customer, it is arguably one of the few commercial robots to pass the Turing test."),
}
