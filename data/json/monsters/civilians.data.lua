local ccb = require("ccb")

-- So they are not perpetually fleeing despite lying in a hospital bed
ccb.content.define_monster {
    id = "mon_civilian_icu",
    name = ccb.content.plural_text("hospitalized person", "hospitalized persons"),
    description = ccb.content.text("This person is severely ill in some form or another, requiring intensive care that is not available anymore after the Cataclysm.  There is nothing you can do for them."),
    chat_topics = { "TALK_CIVILIAN_ICU" },
    speed = 0,
    morale = 0,
    upgrade = { monster = "mon_zombie_crawler" },
    zombify_into = "mon_zombie_crawler",
    copy_from = "mon_civilian_stationary",
    inheritance = { remove = { flags = { "SEES", "HEARS" } } },
}

ccb.content.define_monster {
    id = "mon_civilian_parent",
    name = ccb.content.plural_text("terrified parent", "terrified parents"),
    attacks = { { reference = "PARROT", cooldown = 0 } },
    description = ccb.content.text("Obsessed with finding their offspring, they scour the environment for certain death."),
    chat_topics = { "TALK_CIVILIAN_PARENT" },
    copy_from = "mon_civilian_panic",
}

-- They are human after all
ccb.content.define_monster {
    id = "mon_civilian_panic_robofac_chop_shop",
    name = ccb.content.plural_text("panicked person", "panicked persons"),
    description = ccb.content.text("This hysterical individual has a faint, yet fading, glint of intelligence in their bloodshot eyes.  They sometimes scream in fear and behave clearly irrationally.  This will quite likely cause their demise at the hands of the undead horde rather quickly."),
    looks_like = "mon_dementia",
    default_faction = "human",
    body_type = "human",
    species = { "HUMAN" },
    materials = { "hflesh" },
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    chat_topics = { "TALK_CIVILIAN_PANIC" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 75,
    speed = 90,
    symbol = "@",
    color = "white",
    difficulty_adjustment = 2,
    aggression = -50,
    morale = -50,
    vision_day = 10,
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 3 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    harvest = "human",
    dissect = "dissect_human_sample_single",
    pathing = { max_distance = 30, open_doors = false, avoid_traps = false, avoid_sharp = false },
    dodge = 1,
    zombify_into = "mon_zombie",
    flags = {
        "SEES",
        "HEARS",
        "WARM",
        "HUMAN",
        "CAN_OPEN_DOORS",
        "PATH_AVOID_DANGER",
        "CONVERSATION",
        "GUILT_HUMAN",
    },
    death = {
        drops = "default_zombie_death_drops",
        outcome = { spell = { id = "death_guilt", min_level = 6 } },
    },
}

ccb.content.define_monster {
    id = "mon_civilian_stationary_robofac_chop_shop",
    name = ccb.content.plural_text("petrified person", "petrified persons"),
    description = ccb.content.text("They just stand there, staring into the void, covered in filth and with a vacant expression on their face."),
    speed = 20,
    difficulty_adjustment = 0,
    copy_from = "mon_civilian_panic_robofac_chop_shop",
}

ccb.content.define_monster {
    id = "mon_civilian_parent_robofac_chop_shop",
    name = ccb.content.plural_text("terrified parent", "terrified parents"),
    attacks = { { reference = "PARROT", cooldown = 0 } },
    description = ccb.content.text("Covered in filth, this person is still clearly obsessed with finding their missing offspring."),
    chat_topics = { "TALK_CIVILIAN_PARENT" },
    copy_from = "mon_civilian_panic_robofac_chop_shop",
}
