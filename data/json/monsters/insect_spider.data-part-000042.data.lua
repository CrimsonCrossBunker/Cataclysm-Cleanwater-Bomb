local ccb = require("ccb")

-- when taming becomes more involved, this should be slowly tameable with honeydew, allowing for a tamed stag beetle through almost a year of effort
ccb.content.define_monster {
    id = "mon_stag_beetle_larva",
    name = ccb.content.plural_text("giant stag beetle larva", "giant stag beetle larvae"),
    description = ccb.content.text("Something about this cow-sized larva is pitiable, despite its immense size and sickening cream color."),
    default_faction = "stag_beetle_larva",
    body_type = "snake",
    species = { "INSECT" },
    volume = "200 L",
    mass = "300 kg",
    hp = 120,
    speed = 25,
    materials = { "iflesh" },
    symbol = "S",
    color = "white",
    aggression = -99,
    morale = -10,
    weakpoint_sets = { "wps_arthropod" },
    attacks = {
        { reference = "EAT_CROP", cooldown = 30 },
        { reference = "GRAZE", cooldown = 130 },
        { reference = "EAT_FOOD", cooldown = 30 },
    },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_bug" },
    harvest = "arachnid",
    dissect = "dissect_subterranean_insect_large",
    fear_triggers = { "FIRE", "HURT" },
    upgrade = { grow_at_age = 288, monster = "mon_stag_beetle_small" },
    zombify_into = "mon_meat_cocoon_large",
    flags = { "PATH_AVOID_FIRE", "PET_WONT_FOLLOW", "EATS" },
    armor = { bash = 5, cut = 6, acid = 6, bullet = 3 },
}

ccb.content.define_monster {
    id = "mon_stag_beetle_small",
    name = ccb.content.plural_text("giant stag beetle", "giant stag beetles"),
    description = ccb.content.text("It was called a giant even before the Cataclysm, but now this mutant beetle is the size of a small horse.  It looks ready to molt again, even though parts of the shell are still soft."),
    copy_from = "mon_stag_beetle_giant",
    volume = "200 L",
    mass = "300 kg",
    difficulty_adjustment = 1,
    melee_damage = { { type = "cut", amount = 4 } },
    attacks = {
        {
            id = "stag_smash",
            throw_strength = 40,
            damage = { { type = "bash", amount = 20, armor_multiplier = 0.5 } },
        },
    },
    dissect = "dissect_insect_sample_small",
    upgrade = { grow_at_age = 60, monster = "mon_stag_beetle_giant" },
    zombify_into = "mon_meat_cocoon_large",
    armor = { bash = 24, cut = 32, acid = 8, heat = 2, bullet = 20 },
    inheritance = {
        add = { flags = { "NO_BREED" } },
        remove = { flags = { "DESTROYS", "PUSH_VEH" } },
        scale = { hp = 0.5, morale = 0.5, melee_sides = 0.67 },
    },
}
