local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_lizardfolk_chieftan",
    name = ccb.content.plural_text("lizardfolk chieftain", "lizardfolk chieftains"),
    description = ccb.content.text("Among the lizardfolk, ambition is a rare quality.  Chieftains earn their place by exhibiting unusually high levels of ambition, often mistaken by outsiders as excessive, brutal violence.  This chief is the largest and strongest member of its tribe and carries a fierce trident to compliment its teeth and claws."),
    copy_from = "mon_lizardfolk_warrior",
    symbol = "L",
    hp = 200,
    melee_skill = 4,
    melee_dice = 3,
    melee_sides = 3,
    attacks = { { reference = "skewer", cooldown = 2 }, { cooldown = 5, kind = "bite" } },
    death = {
        drops = {
            entries = {
                { item = "lizardfolk_trident", probability = 30 },
                { group = "lair_loot_generic", probability = 40 },
                { item = "spearsling", probability = 20 },
                { item = "bone_human", probability = 10 },
            },
        },
    },
}

-- A copy of the standard mon_gator (now from Crazy Cataclysm) with a different description to match the lizardfolk lore.  Lizardfolk Shamans are able to shapeshift into crocodile form.
ccb.content.define_monster {
    id = "mon_crocodile",
    name = ccb.content.plural_text("crocodile", "crocodiles"),
    description = ccb.content.text("A once-and-future lizardfolk shaman, this large crocodile no longer has any hint of any humanoid characteristics and looks very, very dangerous."),
    default_faction = "lizardfolk",
    body_type = "gator",
    species = { "LIZARDFOLK" },
    volume = "108500 ml",
    mass = "120 kg",
    hp = 90,
    speed = 90,
    materials = { "flesh" },
    symbol = "C",
    color = "light_green",
    aggression = 30,
    morale = 50,
    melee_skill = 4,
    melee_dice = 1,
    melee_sides = 10,
    melee_damage = { { type = "cut", amount = 12 } },
    dodge = 2,
    vision_day = 3,
    vision_night = 35,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "lizardfolk",
    dissect = "dissect_lizard_sample_large",
    grab_strength = 50,
    attacks = {
        {
            id = "bite_grab",
            cooldown = 20,
            accuracy = 6,
            damage = {
                { type = "stab", amount = 9, armor_multiplier = 0.5 },
                { type = "bash", amount = 27, armor_multiplier = 0.5 },
            },
            infection_chance = 50,
        },
    },
    anger_triggers = { "PLAYER_CLOSE", "PLAYER_WEAK" },
    fear_triggers = { "FIRE", "HURT" },
    pathing = { avoid_traps = true, avoid_sharp = true },
    flags = {
        "SEES", "INFRARED_VISION", "HEARS", "GRABS", "SMELLS", "KEENNOSE", "PATH_AVOID_DANGER",
        "PUSH_MON", "SWIMS", "GROUP_MORALE", "NO_BREATHE",
    },
    armor = { bash = 6, cut = 8, bullet = 6 },
}
