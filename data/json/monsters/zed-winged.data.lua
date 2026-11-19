local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spawn_raptor",
    name = ccb.content.plural_text("flesh-raptor", "flesh-raptors"),
    description = ccb.content.text("This small, winged predator darts through the air on three thinly-haired wings that look like stretched human hands.  A sheer, jagged spike juts out from the point where the wings meet.  It looks like nothing you've seen on Earth, and yet strangely like it is made of human parts."),
    species = { "GHOUL" },
    default_faction = "zombie",
    difficulty_adjustment = 1,
    volume = "4 L",
    mass = "6 kg",
    hp = 20,
    speed = 140,
    materials = { "flesh" },
    symbol = "z",
    color = "white",
    scents_tracked = { "sc_human", "sc_fetid" },
    aggression = 100,
    morale = 100,
    melee_skill = 8,
    melee_dice = 2,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 4 } },
    dodge = 3,
    weakpoint_sets = { "wps_arthropod_hymenoptera", "wps_arthropod_flying" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_flying" },
    vision_night = 5,
    harvest = "zombie_animal",
    decay = "zombie_decay_bone",
    attacks = { { id = "impale", damage = { { type = "stab", amount = 15, armor_multiplier = 0.6 } } } },
    upgrade = { half_life = 168, monster_group = "GROUP_ZOMBIE_RAPTOR_UPGRADES" },
    fungalize_into = "mon_spawn_raptor_dusted",
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "WARM", "POISON", "BASHES", "GROUP_BASH", "FILTHY",
        "HIT_AND_RUN", "SWARMS", "FLIES",
    },
}

ccb.content.define_monster {
    id = "mon_spawn_raptor_shady",
    name = ccb.content.plural_text("shadow raptor", "shadow raptors"),
    copy_from = "mon_spawn_raptor",
    color = "light_gray",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of three flapping wings connected to a jagged, pointed object."),
    upgrade = false,
    vision_day = 10,
    vision_night = 25,
    harvest = "zombie_animal_shadow",
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_spawn_raptor_unstable",
    name = ccb.content.plural_text("unstable flesh-raptor", "unstable flesh-raptor"),
    copy_from = "mon_spawn_raptor",
    speed = 100,
    color = "red",
    description = ccb.content.text("This small, winged predator darts through the air on three thinly-haired wings that look like stretched human hands.  A jagged spike juts out from the point where the wings meet, and a bloated, fleshy belly hangs beneath.  A sharp smell of rotten eggs hangs around it."),
    attacks = {
        { reference = "SUICIDE", cooldown = 20 },
        { id = "impale", damage = { { type = "stab", amount = 15, armor_multiplier = 0.6 } } },
    },
    upgrade = false,
    death = {
        drops = "explode_innards_small",
        outcome = {
            spell = { id = "death_explosion_mon_spawn_raptor_unstable", hit_self = true },
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_spawn_raptor_electric",
    name = ccb.content.plural_text("zaptor", "zaptors"),
    copy_from = "mon_spawn_raptor",
    harvest = "zombie_animal_electric",
    color = "light_cyan",
    difficulty_adjustment = 10,
    description = ccb.content.text("This small, winged predator darts through the air on three thinly-haired wings that look like stretched human hands.  A jagged spike with a pulsing electrical glow juts out from the point where the wings meet."),
    melee_damage = { { type = "electric", amount = 8 } },
    luminance = 8,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    attacks = { { id = "impale", damage = { { type = "stab", amount = 15, armor_multiplier = 0.6 } } } },
    defense = { id = "ZAPBACK", chance = 100 },
    upgrade = false,
    inheritance = { add = { flags = { "ELECTRIC" } } },
}
