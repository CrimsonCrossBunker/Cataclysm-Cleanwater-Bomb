local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_alpha_razorclaw",
    name = ccb.content.plural_text("alpha razorclaw", "alpha razorclaws"),
    description = ccb.content.text("A blood-red, gigantic razorclaw.  With its sword-like pincers, it serves as a protector of the nest."),
    default_faction = "razorclaw",
    body_type = "crab",
    species = { "MUTANT" },
    difficulty_adjustment = 2,
    volume = "108500 ml",
    mass = "120 kg",
    hp = 120,
    speed = 95,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "Y",
    color = "red",
    aggression = 15,
    morale = 100,
    aggressive_to_characters = false,
    melee_skill = 6,
    melee_dice = 4,
    melee_sides = 10,
    melee_damage = { { type = "cut", amount = 15 } },
    dodge = 2,
    bleed_rate = 60,
    vision_day = 30,
    vision_night = 20,
    pathing = { max_distance = 50, avoid_traps = true, avoid_sharp = true },
    harvest = "mutant_shellfish",
    dissect = "dissect_crustacean_large",
    weakpoint_sets = { "wps_arthropod" },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_basic_bug",
        "prof_wp_nat_armored",
    },
    grab_strength = 50,
    attacks = {
        { id = "grab", cooldown = 5 },
        { reference = "SHRIEK_ALERT", cooldown = 6 },
        { reference = "SHRIEK_STUN", cooldown = 1 },
        { reference = "EAT_CARRION", cooldown = 120 },
    },
    anger_triggers = { "PLAYER_CLOSE", "HURT" },
    fear_triggers = { "FIRE" },
    zombify_into = "mon_meat_cocoon_med",
    flags = {
        "SMELLS",
        "HEARS",
        "SEES",
        "GRABS",
        "ARTHROPOD_BLOOD",
        "QUEEN",
        "PATH_AVOID_DANGER",
        "PULP_PRYING",
        "EATS",
    },
    armor = { bash = 20, cut = 30, bullet = 24 },
}

-- NO_I18N
-- a default fish type - does not appear in-game
-- NO_I18N
ccb.content.define_monster {
    id = "mon_fish_tiny",
    abstract = true,
    name = ccb.content.text_without_extraction("tiny fish", "tiny fish"),
    description = ccb.content.text_without_extraction("A tiny fish."),
    default_faction = "fish_tiny",
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "800 ml",
    mass = "680 g",
    hp = 2,
    speed = 150,
    move_skills = { swim = 10 },
    dodge = 8,
    materials = { "flesh" },
    symbol = "f",
    color = "white",
    aggression = -60,
    morale = 5,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 0 } },
    melee_training_cap = 1,
    reproduction = { offspring = { egg = "egg_fish" }, count = 2, interval = 17 },
    mating_seasons = { "SPRING", "SUMMER" },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    harvest = "fish_tiny",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    flags = { "FISHABLE", "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE" },
}

-- NO_I18N
-- a default fish type - does not appear in-game
-- NO_I18N
ccb.content.define_monster {
    id = "mon_fish_small",
    abstract = true,
    name = ccb.content.text_without_extraction("small fish", "small fish"),
    description = ccb.content.text_without_extraction("A small fish."),
    default_faction = "fish_small",
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "2 L",
    mass = "1500 g",
    hp = 6,
    speed = 150,
    move_skills = { swim = 10 },
    dodge = 8,
    materials = { "flesh" },
    symbol = "f",
    color = "white",
    aggression = -60,
    morale = 5,
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 1 } },
    melee_training_cap = 1,
    reproduction = { offspring = { egg = "egg_fish" }, count = 2, interval = 17 },
    mating_seasons = { "SPRING", "SUMMER" },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    harvest = "fish_small",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dissect = "dissect_fish_sample_single",
    flags = { "FISHABLE", "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE" },
}

-- NO_I18N
-- NO_I18N
-- a default fish type - does not appear in-game
ccb.content.define_monster {
    id = "mon_fish_medium",
    abstract = true,
    description = ccb.content.text_without_extraction("A medium fish."),
    default_faction = "fish_medium",
    name = ccb.content.text_without_extraction("medium fish", "medium fish"),
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "7 L",
    mass = "4535 g",
    hp = 10,
    speed = 150,
    move_skills = { swim = 9 },
    dodge = 8,
    materials = { "flesh" },
    symbol = "f",
    color = "white",
    aggression = -60,
    morale = 5,
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    melee_training_cap = 1,
    reproduction = { offspring = { egg = "egg_fish" }, count = 2, interval = 17 },
    mating_seasons = { "SPRING", "SUMMER" },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    harvest = "fish_small",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dissect = "dissect_fish_sample_single",
    flags = { "FISHABLE", "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE" },
}

-- NO_I18N
-- NO_I18N
-- a default fish type - does not appear in-game
ccb.content.define_monster {
    id = "mon_fish_large",
    abstract = true,
    description = ccb.content.text_without_extraction("A large fish."),
    default_faction = "fish_large",
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "16 L",
    name = ccb.content.text_without_extraction("large fish", "large fish"),
    mass = "12 kg",
    hp = 20,
    speed = 150,
    move_skills = { swim = 8 },
    dodge = 8,
    materials = { "flesh" },
    symbol = "F",
    color = "white",
    aggression = -60,
    morale = 5,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 2 } },
    melee_training_cap = 2,
    reproduction = { offspring = { egg = "egg_fish" }, count = 2, interval = 17 },
    mating_seasons = { "SPRING", "SUMMER" },
    fear_triggers = { "SOUND", "PLAYER_CLOSE" },
    harvest = "fish_large",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dissect = "dissect_fish_sample_small",
    flags = { "FISHABLE", "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE" },
}

-- NO_I18N
-- NO_I18N
-- a default fish type - does not appear in-game
ccb.content.define_monster {
    id = "mon_fish_huge",
    abstract = true,
    description = ccb.content.text_without_extraction("A huge fish."),
    default_faction = "fish_large",
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "30 L",
    name = ccb.content.text_without_extraction("huge fish", "huge fish"),
    mass = "40750 g",
    hp = 30,
    speed = 150,
    move_skills = { swim = 7 },
    dodge = 8,
    materials = { "flesh" },
    symbol = "F",
    color = "white",
    aggression = -60,
    morale = 5,
    melee_dice = 1,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 3 } },
    reproduction = { offspring = { egg = "egg_fish" }, count = 2, interval = 17 },
    mating_seasons = { "SPRING", "SUMMER" },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    harvest = "fish_large",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dissect = "dissect_fish_sample_small",
    flags = { "FISHABLE", "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE" },
}

-- a default fish type - does not appear in-game
ccb.content.define_monster {
    id = "mon_fry",
    abstract = true,
    name = ccb.content.plural_text("fish fry", "fish fry"),
    description = ccb.content.text("A minuscule half-translucent fish larva.  Impossible to identify which species it belongs to."),
    default_faction = "fish_tiny",
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "3 ml",
    mass = "1 g",
    hp = 1,
    speed = 150,
    move_skills = { swim = 1 },
    dodge = 10,
    materials = { "flesh" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    symbol = "f",
    color = "white",
    aggression = -60,
    morale = 5,
    melee_dice = 1,
    melee_sides = 1,
    harvest = "exempt",
    melee_damage = { { type = "cut", amount = 0 } },
    melee_training_cap = 0,
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    flags = { "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s is smashed to non-recognizable pieces."),
        },
    },
}

-- a default fish type - does not appear in-game
ccb.content.define_monster {
    id = "mon_fry_mutant",
    abstract = true,
    name = ccb.content.plural_text("mutant fish fry", "mutant fish fry"),
    description = ccb.content.text("A half-translucent fish larva… though this one is far larger than the usual.  Impossible to identify which species it belongs to but you can safely tell that it is going to outgrow normal fish you're used to seeing."),
    default_faction = "fish_mutant_passive",
    body_type = "fish",
    species = { "FISH" },
    volume = "300 ml",
    mass = "275 g",
    hp = 3,
    speed = 150,
    move_skills = { swim = 1 },
    dodge = 8,
    materials = { "flesh" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    symbol = "f",
    color = "white",
    aggression = -60,
    morale = 5,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 0 } },
    melee_training_cap = 1,
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    harvest = "mutant_fish",
    dissect = "dissect_fish_sample_single",
    flags = { "SEES", "AQUATIC", "WATER_CAMOUFLAGE" },
}

ccb.content.define_monster {
    id = "mon_fish_brown_trout",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("brown trout", "brown trouts"),
    looks_like = "mon_fish_salmon",
    description = ccb.content.text("A brown trout.  A fish made popular by father-son fishing trips, except for the part where you have to gut it."),
    volume = "18320 ml",
    mass = "3 kg",
    reproduction = { offspring = { egg = "egg_brown_trout" }, count = 2, interval = 17 },
    mating_seasons = { "AUTUMN" },
}

ccb.content.define_monster {
    id = "mon_fry_brown_trout",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_brown_trout" },
}

ccb.content.define_monster {
    id = "mon_fish_brook_trout",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("brook trout", "brook trouts"),
    looks_like = "mon_fish_salmon",
    description = ccb.content.text("A brook trout.  A fish made popular by father-son fishing trips, except for the part where you have to gut it."),
    volume = "900 ml",
    mass = "1650 g",
    reproduction = { offspring = { egg = "egg_brook_trout" }, count = 2, interval = 17 },
    mating_seasons = { "AUTUMN" },
}

ccb.content.define_monster {
    id = "mon_fry_brook_trout",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_brook_trout" },
}

ccb.content.define_monster {
    id = "mon_fish_lake_trout",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("lake trout", "lake trouts"),
    looks_like = "mon_fish_salmon",
    description = ccb.content.text("A lake trout.  A fish made popular by father-son fishing trips, except for the part where you have to gut it."),
    volume = "6140 ml",
    mass = "4 kg",
    reproduction = { offspring = { egg = "egg_lake_trout" }, count = 2, interval = 17 },
    mating_seasons = { "AUTUMN" },
}

ccb.content.define_monster {
    id = "mon_fry_lake_trout",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_lake_trout" },
}

ccb.content.define_monster {
    id = "mon_fish_rainbow_trout",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("rainbow trout", "rainbow trouts"),
    looks_like = "mon_fish_salmon",
    description = ccb.content.text("A rainbow trout.  A fish made popular by father-son fishing trips, except for the part where you have to gut it."),
    volume = "10600 ml",
    mass = "3 kg",
    reproduction = { offspring = { egg = "egg_rainbow_trout" }, count = 2, interval = 17 },
    mating_seasons = { "AUTUMN" },
}

ccb.content.define_monster {
    id = "mon_fry_rainbow_trout",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_rainbow_trout" },
}

ccb.content.define_monster {
    id = "mon_fish_salmon",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("Atlantic salmon", "Atlantic salmon"),
    description = ccb.content.text("An Atlantic salmon.  A very fatty, nutritious fish.  Tastes great smoked."),
    volume = "10600 ml",
    mass = "4 kg",
    reproduction = { offspring = { egg = "egg_salmon" }, count = 2, interval = 17 },
    mating_seasons = { "AUTUMN" },
}

ccb.content.define_monster {
    id = "mon_fry_salmon",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_salmon" },
}

ccb.content.define_monster {
    id = "mon_fish_kokanee_salmon",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("kokanee salmon", "kokanee salmon"),
    looks_like = "mon_fish_salmon",
    description = ccb.content.text("A Kokanee salmon.  A very fatty, nutritious fish.  Tastes great smoked."),
    volume = "4470 ml",
    mass = "3500 g",
    reproduction = { offspring = { egg = "egg_kokanee_salmon" }, count = 2, interval = 17 },
    mating_seasons = { "AUTUMN" },
}

ccb.content.define_monster {
    id = "mon_fry_kokanee_salmon",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_kokanee_salmon" },
}

ccb.content.define_monster {
    id = "mon_fish_whitefish",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("lake whitefish", "lake whitefish"),
    description = ccb.content.text("A lake whitefish, closely related to salmon.  One can assume they taste just as nice when smoked."),
    volume = "7730 ml",
    mass = "2 kg",
    reproduction = { offspring = { egg = "egg_whitefish" }, count = 2, interval = 17 },
    mating_seasons = { "AUTUMN" },
}

ccb.content.define_monster {
    id = "mon_fry_whitefish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_whitefish" },
}

ccb.content.define_monster {
    id = "mon_fish_whitefish_round",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("round whitefish", "round whitefish"),
    looks_like = "mon_fish_whitefish",
    description = ccb.content.text("A round whitefish, closely related to salmon.  One can assume they taste just as nice when smoked."),
    volume = "850 ml",
    mass = "355 g",
    reproduction = { offspring = { egg = "egg_whitefish_round" }, count = 2, interval = 17 },
    mating_seasons = { "AUTUMN" },
}

ccb.content.define_monster {
    id = "mon_fry_whitefish_round",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_whitefish_round" },
}

ccb.content.define_monster {
    id = "mon_fish_lbass",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("largemouth bass", "largemouth bass"),
    description = ccb.content.text("A largemouth bass.  Very popular with sport fishermen."),
    volume = "3140 ml",
    reproduction = { offspring = { egg = "egg_lbass" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_lbass",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_lbass" },
}

ccb.content.define_monster {
    id = "mon_fish_sbass",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("smallmouth bass", "smallmouth bass"),
    description = ccb.content.text("A smallmouth bass.  Infamously intolerant to pollution, the presence of smallmouth bass is a good indicator of how clean a body of water is."),
    volume = "3140 ml",
    mass = "3 kg",
    reproduction = { offspring = { egg = "egg_sbass" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_sbass",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_sbass" },
}

ccb.content.define_monster {
    id = "mon_fish_pbass",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("striped bass", "striped bass"),
    description = ccb.content.text("A striped bass.  Mostly a saltwater fish, they migrate to fresher water to spawn."),
    volume = "16080 ml",
    mass = "6500 g",
    reproduction = { offspring = { egg = "egg_pbass" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_pbass",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_pbass" },
}

ccb.content.define_monster {
    id = "mon_fish_perch",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("yellow perch", "yellow perches"),
    looks_like = "mon_fish_pickerel",
    description = ccb.content.text("A small, sprightly perch.  It is a very bony fish, still has some tasty meat on it though."),
    volume = "220 ml",
    mass = "150 g",
    reproduction = { offspring = { egg = "egg_perch" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_perch",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_perch" },
}

ccb.content.define_monster {
    id = "mon_fish_walleye",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("walleye", "walleyes"),
    looks_like = "mon_fish_pbass",
    description = ccb.content.text("A walleye.  A green-brown medium-sized fish with a white belly."),
    volume = "4950 ml",
    mass = "3 kg",
    reproduction = { offspring = { egg = "egg_walleye" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_walleye",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_walleye" },
}

ccb.content.define_monster {
    id = "mon_fish_sunfish",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("banded sunfish", "banded sunfish"),
    description = ccb.content.text("A banded sunfish.  A small fish related to bass and bluegill."),
    volume = "20 ml",
    mass = "20 g",
    reproduction = { offspring = { egg = "egg_sunfish" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_sunfish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_sunfish" },
}

ccb.content.define_monster {
    id = "mon_fish_pumpkinseed",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("pumpkinseed", "pumpkinseeds"),
    looks_like = "mon_fish_sunfish",
    description = ccb.content.text("A pumpkinseed sunfish.  A small fish related to bass and bluegill."),
    volume = "80 ml",
    mass = "175 g",
    reproduction = { offspring = { egg = "egg_pumpkinseed" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_pumpkinseed",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_pumpkinseed" },
}

ccb.content.define_monster {
    id = "mon_fish_bluegill",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("bluegill", "bluegills"),
    description = ccb.content.text("A bluegill, an invasive species in Japan.  Commonly gutted and cooked whole."),
    volume = "290 ml",
    mass = "280 g",
    reproduction = { offspring = { egg = "egg_bluegill" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_bluegill",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_bluegill" },
}

ccb.content.define_monster {
    id = "mon_fish_redbreast",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("redbreast sunfish", "redbreast sunfish"),
    looks_like = "mon_fish_sunfish",
    description = ccb.content.text("A redbreast sunfish.  A small fish related to bass and bluegill."),
    volume = "110 ml",
    mass = "106 g",
    reproduction = { offspring = { egg = "egg_redbreast" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_redbreast",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_redbreast" },
}

ccb.content.define_monster {
    id = "mon_fish_green_sunfish",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("green sunfish", "green sunfish"),
    looks_like = "mon_fish_sunfish",
    description = ccb.content.text("A green sunfish.  A small fish related to bass and bluegill."),
    volume = "290 ml",
    mass = "280 g",
    reproduction = { offspring = { egg = "egg_green_sunfish" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_green_sunfish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_green_sunfish" },
}

ccb.content.define_monster {
    id = "mon_fish_rock_bass",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("rock bass", "rock bass"),
    looks_like = "mon_fish_sunfish",
    description = ccb.content.text("A rock bass.  Related to sunfish, this tiny fish has a camouflage-like patterning and red eyes."),
    volume = "750 ml",
    mass = "350 g",
    reproduction = { offspring = { egg = "egg_rock_bass" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_rock_bass",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_rock_bass" },
}

ccb.content.define_monster {
    id = "mon_fish_calico_bass",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("black crappie", "black crappie"),
    looks_like = "mon_fish_pbass",
    description = ccb.content.text("A black crappie.  A medium-sized fish also known as a 'calico bass'."),
    volume = "900 ml",
    mass = "400 g",
    reproduction = { offspring = { egg = "egg_calico_bass" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_calico_bass",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_calico_bass" },
}

ccb.content.define_monster {
    id = "mon_fish_warmouth",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("warmouth", "warmouths"),
    looks_like = "mon_fish_sunfish",
    description = ccb.content.text("A warmouth, similar to a rock bass.  This small fish is related to the sunfish."),
    volume = "290 ml",
    mass = "280 g",
    reproduction = { offspring = { egg = "egg_warmouth" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_warmouth",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_warmouth" },
}

ccb.content.define_monster {
    id = "mon_fish_bullhead",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("brown bullhead", "brown bullheads"),
    description = ccb.content.text("A brown bullhead, a type of catfish.  Delicious when battered and fried."),
    volume = "340 ml",
    mass = "650 g",
    reproduction = { offspring = { egg = "egg_bullhead" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_bullhead",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_bullhead" },
}

ccb.content.define_monster {
    id = "mon_fish_bullhead_yellow",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("yellow bullhead", "yellow bullheads"),
    looks_like = "mon_fish_bullhead",
    description = ccb.content.text("A yellow bullhead, a type of catfish.  Delicious when battered and fried, though smaller than its brown cousin."),
    volume = "250 ml",
    mass = "454 g",
    reproduction = { offspring = { egg = "egg_bullhead_yellow" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_bullhead_yellow",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_bullhead_yellow" },
}

ccb.content.define_monster {
    id = "mon_fish_channel_catfish",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("channel catfish", "channel catfish"),
    looks_like = "mon_fish_bullhead",
    description = ccb.content.text("A channel catfish.  It has a forked tail and long whiskers."),
    volume = "4040 ml",
    mass = "7 kg",
    reproduction = { offspring = { egg = "egg_channel_catfish" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_channel_catfish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_channel_catfish" },
}

ccb.content.define_monster {
    id = "mon_fish_white_catfish",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("white catfish", "white catfish"),
    looks_like = "mon_fish_bullhead",
    description = ccb.content.text("A white catfish.  A small whiskered fish with a broad head."),
    volume = "620 ml",
    mass = "950 g",
    reproduction = { offspring = { egg = "egg_white_catfish" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_white_catfish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_white_catfish" },
}

ccb.content.define_monster {
    id = "mon_fish_pike",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("northern pike", "northern pikes", "fish"),
    description = ccb.content.text("A northern pike.  Pike can be pretty aggressive fish, careful around those teeth."),
    volume = "3630 ml",
    mass = "1750 g",
    reproduction = { offspring = { egg = "egg_pike" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_pike",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_pike" },
}

ccb.content.define_monster {
    id = "mon_fish_pickerel",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("chain pickerel", "chain pickerels"),
    description = ccb.content.text("A chain pickerel.  It looks like a pike, but slightly smaller."),
    volume = "1620 ml",
    mass = "1150 g",
    reproduction = { offspring = { egg = "egg_pickerel" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_pickerel",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_pickerel" },
}

ccb.content.define_monster {
    id = "mon_fish_pickerel_american",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("American pickerel", "American pickerels"),
    description = ccb.content.text("An American pickerel.  It looks like a pike, but unlike its chain pickerel cousin, this one is way smaller."),
    volume = "170 ml",
    mass = "200 g",
    reproduction = { offspring = { egg = "egg_pickerel_american" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_pickerel_american",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_pickerel_american" },
}

ccb.content.define_monster {
    id = "mon_fish_muskellunge",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("muskellunge", "muskellunges"),
    looks_like = "mon_fish_pike",
    description = ccb.content.text("A muskellunge.  Closely related to pike but even larger, it shares the same aggression and sharp teeth."),
    volume = "18700 ml",
    mass = "10 kg",
    reproduction = { offspring = { egg = "egg_muskellunge" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_muskellunge",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_muskellunge" },
}

ccb.content.define_monster {
    id = "mon_fish_white_sucker",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("white sucker", "white suckers"),
    looks_like = "mon_fish_pbass",
    description = ccb.content.text("A white sucker.  It has a streamlined body with a round mouth."),
    volume = "2120 ml",
    mass = "660 g",
    reproduction = { offspring = { egg = "egg_white_sucker" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_white_sucker",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_white_sucker" },
}

ccb.content.define_monster {
    id = "mon_fish_carp",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("European carp", "European carp"),
    description = ccb.content.text("A golden-yellow common carp.  Some people think they don't taste great, but you can't afford to be choosy in the Cataclysm."),
    volume = "2010 ml",
    mass = "1 kg",
    reproduction = { offspring = { egg = "egg_carp" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_carp",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_carp" },
}

ccb.content.define_monster {
    id = "mon_fish_grass_carp",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("grass carp", "grass carps"),
    looks_like = "mon_fish_carp",
    description = ccb.content.text("A huge grass carp.  A golden, herbivorous fish."),
    volume = "16080 ml",
    mass = "15 kg",
    reproduction = { offspring = { egg = "egg_grass_carp" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_grass_carp",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_grass_carp" },
}

ccb.content.define_monster {
    id = "mon_fish_goldfish",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("goldfish", "goldfish"),
    looks_like = "mon_fish_carp",
    description = ccb.content.text("Yes, this is that common pet fish.  Though, given its size and the fact that it's still alive, you can take a wild guess that this one is feral."),
    volume = "570 ml",
    mass = "300 g",
    reproduction = { offspring = { egg = "egg_goldfish" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_goldfish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_goldfish" },
}

ccb.content.define_monster {
    id = "mon_fish_bowfin",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("bowfin", "bowfins"),
    description = ccb.content.text("A bowfin.  These fish are related to gar but without the huge teeth, skin-rending scales, and aggression."),
    volume = "4780 ml",
    mass = "1300 g",
    reproduction = { offspring = { egg = "egg_bowfin" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_bowfin",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_bowfin" },
}

ccb.content.define_monster {
    id = "mon_fish_gar_longnose",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("longnose gar", "longnose gar"),
    looks_like = "mon_fish_pike",
    description = ccb.content.text("A large ancient type of fish with a mean jaw and poisonous eggs."),
    volume = "4820 ml",
    mass = "920 g",
    reproduction = { offspring = { egg = "egg_gar_longnose" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_gar_longnose",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_gar_longnose" },
}

ccb.content.define_monster {
    id = "mon_fish_burbot",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("burbot", "burbots"),
    description = ccb.content.text("A relatively large fish that looks like a cross between a catfish and an eel, and is the only freshwater fish from the order that cods hail from."),
    volume = "1400 ml",
    mass = "620 g",
    reproduction = { offspring = { egg = "egg_burbot" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_burbot",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_burbot" },
}

ccb.content.define_monster {
    id = "mon_fish_sturgeon_lake",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("lake sturgeon", "lake sturgeon"),
    description = ccb.content.text("A very large armored bottom-feeder, the lake sturgeon is one of the largest unmutated fish one can find in the freshwater regions of New England."),
    volume = "20220 ml",
    mass = "14500 g",
    reproduction = { offspring = { egg = "egg_sturgeon_lake" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_sturgeon_lake",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_sturgeon_lake" },
}

ccb.content.define_monster {
    id = "mon_fish_sturgeon_shortnose",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("shortnose sturgeon", "shortnose sturgeon"),
    looks_like = "mon_fish_sturgeon_lake",
    description = ccb.content.text("While the shortnose sturgeon is still large, it is nothing compared to its cousin - the lake sturgeon.  What really sets it apart, however, is its signature shorter snout."),
    volume = "2720 ml",
    mass = "980 g",
    reproduction = { offspring = { egg = "egg_sturgeon_shortnose" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_sturgeon_shortnose",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_sturgeon_shortnose" },
}

ccb.content.define_monster {
    id = "mon_fish_fallfish",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("fallfish", "fallfish"),
    looks_like = "mon_fish_pbass",
    description = ccb.content.text("A fallfish.  These fish are small cyprinids, related to carp."),
    volume = "160 ml",
    mass = "120 g",
    reproduction = { offspring = { egg = "egg_fallfish" }, count = 2, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_fallfish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_fallfish" },
}

ccb.content.define_monster {
    id = "mon_fish_lobster",
    name = ccb.content.plural_text("lobster", "lobsters"),
    description = ccb.content.text("A dark greenish crustacean in its natural habitat.  These were once considered pests barely worth eating, then some marketing genius started selling them to people as a delicacy and they took off in popularity… and price."),
    default_faction = "fish_medium",
    body_type = "crab",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "1 L",
    mass = "680 g",
    hp = 12,
    speed = 80,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "f",
    color = "red",
    aggression = -50,
    morale = 5,
    melee_dice = 1,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 1 } },
    harvest = "lobster",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_bug" },
    dissect = "dissect_crustacean_single",
    reproduction = { offspring = { egg = "egg_fish" }, count = 2, interval = 180 },
    mating_seasons = { "SUMMER", "AUTUMN" },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    flags = { "FISHABLE", "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE", "ARTHROPOD_BLOOD" },
}

ccb.content.define_monster {
    id = "mon_fish_crayfish",
    name = ccb.content.plural_text("crayfish", "crayfish"),
    description = ccb.content.text("This crustacean looks like a tiny lobster, but is actually a completely different species.  If you could get ahold of a bunch more of these, a hefty pot of boiling water, and some spicy seasonings…"),
    default_faction = "fish_tiny",
    body_type = "crab",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "90 ml",
    mass = "52 g",
    hp = 3,
    speed = 150,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "f",
    color = "red",
    aggression = -50,
    morale = 5,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 1 } },
    harvest = "shellfish",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_bug" },
    dissect = "dissect_crustacean_single",
    reproduction = { offspring = { monster = "mon_fry_crayfish" }, count = 3, interval = 17 },
    mating_seasons = { "AUTUMN" },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    flags = { "FISHABLE", "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE", "ARTHROPOD_BLOOD" },
}

ccb.content.define_monster {
    id = "mon_fry_crayfish",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_crayfish" },
    name = ccb.content.plural_text("crustacean larva", "crustacean larvae"),
    description = ccb.content.text("A minuscule half-translucent crustacean larva.  Impossible to identify which species it belongs to."),
    body_type = "crab",
}

ccb.content.define_monster {
    id = "mon_fish_eel",
    name = ccb.content.plural_text("American eel", "American eels"),
    description = ccb.content.text("An American eel.  They used to be quite common in these parts until the dams were built.  They'll get a second chance now that those aren't running."),
    default_faction = "fish_medium",
    body_type = "snake",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "2160 ml",
    mass = "2150 g",
    hp = 10,
    speed = 150,
    move_skills = { swim = 10 },
    materials = { "flesh" },
    symbol = "f",
    color = "white",
    aggression = -50,
    morale = 5,
    melee_dice = 1,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 1 } },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    harvest = "fish_small",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dissect = "dissect_slimy_fish_single",
    flags = { "FISHABLE", "SEES", "SMELLS", "AQUATIC", "WATER_CAMOUFLAGE" },
}

ccb.content.define_monster {
    id = "mon_crayfish_small",
    name = ccb.content.plural_text("oversized crayfish", "oversized crayfish"),
    description = ccb.content.text("A mutant crayfish the size of a dog, with a brown carapace, claws, and long antennae."),
    copy_from = "mon_giant_crayfish",
    volume = "30 L",
    mass = "40 kg",
    dissect = "dissect_crustacean_small",
    upgrade = { grow_at_age = 30, monster = "mon_giant_crayfish" },
    inheritance = {
        add = { flags = { "NO_BREED" } },
        scale = { hp = 0.5, speed = 1.1, morale = 0.67, melee_sides = 0.67 },
    },
}

ccb.content.define_monster {
    id = "mon_giant_crayfish",
    name = ccb.content.plural_text("giant crayfish", "giant crayfish"),
    description = ccb.content.text("A mutant, terrestrial variety of crayfish, this massive crustacean resembles a humongous lobster."),
    default_faction = "crayfish",
    body_type = "crab",
    species = { "MUTANT" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 50,
    speed = 130,
    move_skills = { swim = 10 },
    materials = { "flesh" },
    symbol = "y",
    color = "red",
    morale = 100,
    melee_skill = 5,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 5 } },
    grab_strength = 30,
    attacks = { { id = "grab" } },
    dodge = 2,
    bleed_rate = 85,
    harvest = "mutant_shellfish",
    weakpoint_sets = { "wps_arthropod" },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_basic_bug",
        "prof_wp_nat_armored",
    },
    dissect = "dissect_crustacean_small",
    reproduction = { offspring = { monster = "mon_crayfish_giant_larva" }, count = 3, interval = 21 },
    mating_seasons = { "AUTUMN" },
    anger_triggers = { "PLAYER_CLOSE", "HURT" },
    fear_triggers = { "FIRE" },
    upgrade = { grow_at_age = 42, monster = "mon_crayfish_mega" },
    zombify_into = "mon_meat_cocoon_small",
    flags = { "SMELLS", "HEARS", "SEES", "GRABS", "PULP_PRYING", "ARTHROPOD_BLOOD" },
    armor = { cut = 8, bullet = 6 },
}

ccb.content.define_monster {
    id = "mon_crayfish_mega",
    name = ccb.content.plural_text("colossal crayfish", "colossal crayfish"),
    description = ccb.content.text("An enormous mutated gray crayfish with pincer claws and long antennae."),
    copy_from = "mon_giant_crayfish",
    volume = "625 L",
    mass = "815 kg",
    grab_strength = 75,
    melee_dice = 2,
    bleed_rate = 60,
    attacks = {
        { reference = "PARROT", cooldown = 20 },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    vision_day = 84,
    dissect = "dissect_crustacean_large",
    zombify_into = "mon_meat_cocoon_large",
    inheritance = {
        add = { flags = { "DESTROYS", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 10, speed = 0.25, dodge = 0.5, armor = { cut = 2, bullet = 2 } },
    },
}

ccb.content.define_monster {
    id = "mon_crayfish_giant_larva",
    name = ccb.content.plural_text("giant crayfish larva", "giant crayfish larvae"),
    description = ccb.content.text("A large crayfish larva already larger than non-mutated adults of its kind."),
    copy_from = "mon_larva_abstract",
    default_faction = "crayfish",
    body_type = "crab",
    species = { "MUTANT" },
    speed = 150,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "y",
    vision_day = 15,
    harvest = "mutant_shellfish",
    upgrade = { grow_at_age = 30, monster = "mon_giant_crayfish" },
    fear_triggers = { "HURT", "PLAYER_CLOSE", "SOUND" },
    inheritance = { add = { flags = { "AQUATIC", "WATER_CAMOUFLAGE" } } },
}

ccb.content.define_monster {
    id = "mon_razorclaw",
    name = ccb.content.plural_text("razorclaw", "razorclaws"),
    description = ccb.content.text("A man-sized crustacean clad in iron-like chitin, capable of emitting horrible shrieking noises.  Often spotted near shipwrecks or other dark, damp places, which it uses as nesting grounds."),
    default_faction = "razorclaw",
    body_type = "crab",
    species = { "MUTANT" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 80,
    speed = 85,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "Y",
    color = "magenta",
    aggression = 4,
    morale = 100,
    aggressive_to_characters = false,
    melee_skill = 6,
    melee_dice = 4,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 7 } },
    dodge = 2,
    bleed_rate = 65,
    vision_day = 30,
    vision_night = 15,
    pathing = { max_distance = 50, avoid_traps = true, avoid_sharp = true },
    harvest = "mutant_shellfish",
    dissect = "dissect_crustacean_small",
    weakpoint_sets = { "wps_arthropod" },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_nat_armored",
        "prof_wp_basic_bug",
    },
    grab_strength = 30,
    attacks = {
        { id = "grab", cooldown = 5 },
        { reference = "SHRIEK_ALERT", cooldown = 6 },
        { reference = "SHRIEK_STUN", cooldown = 1 },
        { reference = "EAT_CARRION", cooldown = 120 },
    },
    anger_triggers = { "PLAYER_CLOSE", "FRIEND_DIED", "FRIEND_ATTACKED", "HURT" },
    fear_triggers = { "FIRE" },
    zombify_into = "mon_meat_cocoon_small",
    flags = {
        "SMELLS",
        "HEARS",
        "SEES",
        "GRABS",
        "ARTHROPOD_BLOOD",
        "PATH_AVOID_DANGER",
        "PULP_PRYING",
        "EATS",
    },
    armor = { bash = 10, cut = 18, bullet = 14 },
}

ccb.content.define_monster {
    id = "mon_mutant_carp",
    name = ccb.content.plural_text("giant carp", "giant carps"),
    description = ccb.content.text("This thing looks like a carp, but huge and very, very angry.  Death is the gift of the carp god."),
    default_faction = "fish_mutant_passive",
    body_type = "fish",
    species = { "FISH" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 180,
    speed = 150,
    move_skills = { swim = 10 },
    materials = { "flesh" },
    symbol = "C",
    color = "white_magenta",
    aggression = 100,
    morale = 105,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 5,
    harvest = "mutant_fish",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dissect = "dissect_fish_sample_small",
    reproduction = { offspring = { egg = "egg_fish" }, count = 1, interval = 6 },
    mating_seasons = { "SPRING" },
    flags = { "SEES", "HEARS", "SMELLS", "AQUATIC" },
}

ccb.content.define_monster {
    id = "mon_mutant_salmon",
    name = ccb.content.plural_text("giant salmon", "giant salmon"),
    description = ccb.content.text("A mutated salmon roughly the size of a person.  Quite dangerous to the inexperienced angler."),
    default_faction = "fish_mutant_passive",
    body_type = "fish",
    species = { "FISH" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 110,
    armor = { bash = 4, cut = 3, bullet = 2 },
    speed = 175,
    move_skills = { swim = 10 },
    attack_cost = 145,
    materials = { "flesh" },
    symbol = "S",
    color = "white_magenta",
    aggression = 9,
    morale = 50,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 4 } },
    dodge = 5,
    harvest = "mutant_fish",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dissect = "dissect_fish_sample_small",
    reproduction = { offspring = { egg = "egg_mutant_salmon" }, count = 3, interval = 30 },
    mating_seasons = { "AUTUMN" },
    upgrade = { grow_at_age = 30, monster = "mon_mutant_salmon_huge" },
    anger_triggers = { "HURT" },
    flags = { "SEES", "HEARS", "AQUATIC" },
}

ccb.content.define_monster {
    id = "mon_mutant_salmon_huge",
    name = ccb.content.plural_text("huge salmon", "huge salmon"),
    description = ccb.content.text("A huge mutant salmon grown almost to the size of an alligator."),
    default_faction = "fish_mutant_passive",
    body_type = "fish",
    species = { "FISH" },
    volume = "312 L",
    mass = "265 kg",
    hp = 225,
    armor = { bash = 8, cut = 6, bullet = 3 },
    speed = 175,
    move_skills = { swim = 10 },
    attack_cost = 150,
    materials = { "flesh" },
    symbol = "S",
    color = "white_magenta",
    aggression = 9,
    morale = 80,
    melee_skill = 6,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 6 } },
    dodge = 4,
    harvest = "mutant_fish",
    dissect = "dissect_fish_sample_large",
    reproduction = { offspring = { egg = "egg_mutant_salmon" }, count = 3, interval = 30 },
    mating_seasons = { "AUTUMN" },
    upgrade = { grow_at_age = 42, monster = "mon_mutant_salmon_mega" },
    anger_triggers = { "HURT", "PLAYER_CLOSE" },
    flags = { "SEES", "HEARS", "AQUATIC" },
}

ccb.content.define_monster {
    id = "mon_fry_mutant_salmon",
    copy_from = "mon_fry_mutant",
    upgrade = { grow_at_age = 30, monster = "mon_mutant_salmon" },
}

ccb.content.define_monster {
    id = "mon_mutant_salmon_mega",
    name = ccb.content.plural_text("leaper salmon", "leaper salmon"),
    description = ccb.content.text("A huge mutant salmon, one that outgrows even the other ones present.  On its sides, beneath the fins, are visible two flesh-colored tubes which propel water as it leaps."),
    default_faction = "fish_mutant_passive",
    body_type = "fish",
    species = { "FISH" },
    volume = "400 L",
    mass = "340 kg",
    hp = 240,
    armor = { bash = 10, cut = 9, bullet = 3 },
    speed = 200,
    move_skills = { swim = 10 },
    attack_cost = 150,
    materials = { "flesh" },
    symbol = "S",
    color = "white_magenta",
    aggression = 9,
    morale = 90,
    melee_skill = 6,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 6 } },
    attacks = {
        {
            cooldown = 30,
            maximum_range = 10,
            minimum_target_distance = 2,
            ignore_destination_terrain = true,
            kind = "leap",
        },
    },
    dodge = 4,
    harvest = "mutant_fish",
    dissect = "dissect_fish_sample_large",
    reproduction = { offspring = { egg = "egg_mutant_salmon" }, count = 5, interval = 50 },
    mating_seasons = { "AUTUMN" },
    anger_triggers = { "HURT", "PLAYER_CLOSE" },
    flags = { "SEES", "HEARS", "AQUATIC" },
}

ccb.content.define_monster {
    id = "mon_sewer_fish",
    name = ccb.content.plural_text("seweranha", "seweranhas"),
    description = ccb.content.text("A large, mutant variety of carp.  It has shimmering green scales and a mouth lined with three jagged rows of razor-sharp teeth."),
    default_faction = "seweranha",
    body_type = "fish",
    species = { "FISH" },
    volume = "30 L",
    mass = "40750 g",
    hp = 20,
    speed = 180,
    materials = { "flesh" },
    symbol = "t",
    color = "light_green",
    aggression = 100,
    morale = 100,
    melee_skill = 6,
    melee_dice = 1,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 4 } },
    dodge = 6,
    vision_day = 1,
    vision_night = 30,
    harvest = "mutant_fish",
    dissect = "dissect_fish_sample_single",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    reproduction = { offspring = { egg = "egg_fish" }, count = 2, interval = 19 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN", "WINTER" },
    pathing = { max_distance = 5 },
    flags = { "SEES", "SMELLS", "AQUATIC" },
}

ccb.content.define_monster {
    id = "mon_fish_mackerel",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("Atlantic mackerel", "Atlantic mackerel"),
    description = ccb.content.text("An Atlantic mackerel, known for its distinctive striped pattern."),
    volume = "850 ml",
    mass = "425 g",
    reproduction = { offspring = { egg = "egg_mackerel" }, count = 3, interval = 20 },
}

ccb.content.define_monster {
    id = "mon_fry_mackerel",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_mackerel" },
}

ccb.content.define_monster {
    id = "mon_fish_flounder",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("summer flounder", "summer flounder"),
    description = ccb.content.text("A flatfish, the summer flounder, also known as a fluke, likes to stay camouflaged against the ocean floor."),
    volume = "4 L",
    mass = "1400 g",
    reproduction = { offspring = { egg = "egg_flounder" }, count = 2, interval = 22 },
}

ccb.content.define_monster {
    id = "mon_fry_flounder",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_flounder" },
}

ccb.content.define_monster {
    id = "mon_fish_blackfish",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("black sea bass", "black sea bass"),
    description = ccb.content.text("A small, robust fish, the black sea bass is known for its dark, mottled color and meaty texture."),
    volume = "1330 ml",
    mass = "850 g",
    reproduction = { offspring = { egg = "egg_blackfish" }, count = 2, interval = 15 },
}

ccb.content.define_monster {
    id = "mon_fry_blackfish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_blackfish" },
}

ccb.content.define_monster {
    id = "mon_fish_porgy",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("scup", "scup"),
    description = ccb.content.text("Also known as porgy, the scup is a small fish commonly found in Atlantic coastal waters, recognizable by its silver body with blue and purple tinges."),
    mass = "500 g",
    reproduction = { offspring = { egg = "egg_porgy" }, count = 3, interval = 16 },
}

ccb.content.define_monster {
    id = "mon_fry_porgy",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_porgy" },
}

ccb.content.define_monster {
    id = "mon_fish_bluefish",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("bluefish", "bluefish"),
    description = ccb.content.text("The bluefish, a moderately proportioned marine fish, is known for its aggressive nature and sharp teeth.  It sports a distinct blue-green coloration."),
    volume = "6785 ml",
    reproduction = { offspring = { egg = "egg_bluefish" }, count = 2, interval = 18 },
}

ccb.content.define_monster {
    id = "mon_fry_bluefish",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_bluefish" },
}

ccb.content.define_monster {
    id = "mon_fish_cod",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("Atlantic cod", "Atlantic cod"),
    description = ccb.content.text("A large, white-meat fish known for its mild flavor and flaky texture.  Highly prized in both commercial and recreational fishing."),
    volume = "31450 ml",
    mass = "30 kg",
    reproduction = { offspring = { egg = "egg_cod" }, count = 3, interval = 19 },
}

ccb.content.define_monster {
    id = "mon_fry_cod",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_cod" },
}

ccb.content.define_monster {
    id = "mon_fish_haddock",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("haddock", "haddock"),
    description = ccb.content.text("A popular food fish, the haddock is recognized by its dark lateral line and a black blotch above the pectoral fin."),
    volume = "6785 ml",
    mass = "1800 g",
    reproduction = { offspring = { egg = "egg_haddock" }, count = 3, interval = 18 },
}

ccb.content.define_monster {
    id = "mon_fry_haddock",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_haddock" },
}

ccb.content.define_monster {
    id = "mon_fish_bluefin_tuna",
    copy_from = "mon_fish_huge",
    name = ccb.content.plural_text("Atlantic bluefin tuna", "Atlantic bluefin tuna"),
    description = ccb.content.text("One of the largest and fastest fish in the waters of New England, the bluefin tuna is a streamlined predator with a dark blue back and silvery sides."),
    volume = "250 L",
    mass = "200 kg",
    reproduction = { offspring = { egg = "egg_bluefin_tuna" }, count = 1, interval = 22 },
}

ccb.content.define_monster {
    id = "mon_fry_bluefin_tuna",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_bluefin_tuna" },
}

ccb.content.define_monster {
    id = "mon_fish_halibut",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("Atlantic halibut", "Atlantic halibut"),
    description = ccb.content.text("The largest flatfish in the ocean, known for its dense, firm texture and mild flavor."),
    volume = "75 L",
    mass = "25 kg",
    reproduction = { offspring = { egg = "egg_halibut" }, count = 2, interval = 20 },
}

ccb.content.define_monster {
    id = "mon_fry_halibut",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_halibut" },
}

ccb.content.define_monster {
    id = "mon_fish_pollock",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("pollock", "pollock"),
    looks_like = "mon_fish_cod",
    description = ccb.content.text("A member of the cod family, pollock is a versatile fish known for its white, delicate meat and mild taste."),
    volume = "6785 ml",
    mass = "2250 g",
    reproduction = { offspring = { egg = "egg_pollock" }, count = 3, interval = 17 },
}

ccb.content.define_monster {
    id = "mon_fry_pollock",
    copy_from = "mon_fry",
    upgrade = { grow_at_age = 14, monster = "mon_fish_pollock" },
}
