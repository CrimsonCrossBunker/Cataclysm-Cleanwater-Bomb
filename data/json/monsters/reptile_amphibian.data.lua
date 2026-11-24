local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_snake_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract snake"),
    description = ccb.content.text_without_extraction("This is an abstract monster for other snakes to copy from, so that we have some common foundation to work with.  If it appears in the game that's a bug."),
    default_faction = "snake_small",
    body_type = "snake",
    categories = { "WILDLIFE" },
    species = { "REPTILE" },
    volume = "150 ml",
    mass = "150 g",
    hp = 1,
    speed = 100,
    move_skills = { climb = 6, swim = 4 },
    materials = { "flesh" },
    symbol = "s",
    color = "brown",
    aggression = 8,
    morale = 60,
    aggressive_to_characters = false,
    melee_skill = 2,
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 6,
    vision_day = 15,
    vision_night = 8,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "mammal_tiny",
    dissect = "dissect_lizard_sample_single",
    fear_triggers = { "PLAYER_CLOSE", "HURT" },
    placate_triggers = { "PLAYER_WEAK" },
    mating_seasons = { "SUMMER" },
    biosignature = { item = "shed_snakeskin", interval = 180 },
    flags = {
        "SEES",
        "HEARS",
        "SMELLS",
        "KEENNOSE",
        "HARDTOSHOOT",
        "PATH_AVOID_DANGER",
        "ANIMAL",
        "CORNERED_FIGHTER",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_snakelet_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract snakelet"),
    description = ccb.content.text_without_extraction("This is an abstract monster for other snakelets to copy from, so that we have some common foundation to work with.  If it appears in the game that's a bug."),
    copy_from = "mon_snake_abstract",
    volume = "10 ml",
    mass = "10 g",
    speed = 60,
    aggression = -35,
    morale = -20,
    vision_day = 10,
    vision_night = 6,
    biosignature = { item = "shed_snakeskin_little", interval = 180 },
    inheritance = { add = { flags = { "NO_BREED" }, fear_triggers = { "SOUND" } } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_turtle_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract turtle"),
    description = ccb.content.text_without_extraction("This is an abstract monster for other turtles to copy from, so that we have some common foundation to work with.  If it appears in the game that's a bug."),
    default_faction = "turtle_small",
    body_type = "turtle",
    categories = { "WILDLIFE" },
    species = { "REPTILE" },
    volume = "350 ml",
    mass = "350 g",
    hp = 1,
    speed = 65,
    move_skills = { swim = 10 },
    materials = { "flesh" },
    symbol = "o",
    color = "brown",
    aggression = 5,
    aggressive_to_characters = false,
    morale = 60,
    melee_skill = 2,
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 1,
    vision_day = 15,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "mammal_tiny",
    dissect = "dissect_lizard_sample_single",
    fear_triggers = { "SOUND", "HURT" },
    mating_seasons = { "SUMMER" },
    flags = { "SEES", "HEARS", "SMELLS", "PATH_AVOID_DANGER", "ANIMAL", "CORNERED_FIGHTER" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_turtle_baby_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract turtle hatchling"),
    description = ccb.content.text_without_extraction("This is an abstract monster for other turtle hatchlings to copy from, so that we have some common foundation to work with.  If it appears in the game that's a bug."),
    copy_from = "mon_turtle_abstract",
    volume = "15 ml",
    mass = "15 g",
    speed = 45,
    aggression = -35,
    morale = -20,
    vision_day = 10,
    inheritance = { add = { flags = { "NO_BREED" } } },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_s",
    name = ccb.content.plural_text("timber rattlesnake snakelet", "timber rattlesnake snakelets"),
    description = ccb.content.text("A timber rattlesnake in its hatchling stage.  It will eventually grow a rattle and learn how to hunt."),
    copy_from = "mon_snakelet_abstract",
    upgrade = { grow_at_age = 1460, monster = "mon_rattlesnake" },
    inheritance = { add = { flags = { "VENOM" } } },
}

-- On average, a female rattlesnake gives birth to at least eight babies, up to around fifteen.  Most baby rattlesnakes are born in the early summer, but sometimes in late summer and early autumn.
ccb.content.define_monster {
    id = "mon_rattlesnake",
    name = ccb.content.plural_text("timber rattlesnake", "timber rattlesnakes"),
    description = ccb.content.text("The most venomous viper native to New England.  Climatic changes have extended its range far into the north."),
    copy_from = "mon_snake_abstract",
    volume = "750 ml",
    mass = "750 g",
    hp = 2,
    melee_skill = 5,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 4 } },
    attacks = { { reference = "RATTLE", cooldown = 6 } },
    anger_triggers = { "PLAYER_CLOSE" },
    fear_triggers = { "HURT" },
    reproduction = { offspring = { monster_group = "REPRODUCTION_MUT_RATTLESNAKE" }, count = 10, interval = 135 },
    mating_seasons = { "SUMMER" },
    inheritance = { add = { flags = { "BADVENOM" } } },
}

-- The numbers here can technically go up to 80 snakelets, with averages reaching 40, but lets be honest the game couldn't handle that.
ccb.content.define_monster {
    id = "mon_gartersnake",
    name = ccb.content.plural_text("common garter snake", "common garter snakes"),
    description = ccb.content.text("A common species of snake found all across North America."),
    copy_from = "mon_snake_abstract",
    default_faction = "snake_tiny_aquatic",
    reproduction = { offspring = { monster = "mon_gartersnake_baby" }, count = 10, interval = 90 },
    mating_seasons = { "SUMMER" },
}

ccb.content.define_monster {
    id = "mon_gartersnake_baby",
    name = ccb.content.plural_text("common garter snake snakelet", "common garter snake snakelets"),
    description = ccb.content.text("A garter snake in its juvenile stage."),
    copy_from = "mon_snakelet_abstract",
    default_faction = "snake_tiny_aquatic",
    upgrade = { grow_at_age = 544, monster = "mon_gartersnake" },
}

-- The reason its using the lizard faction is that it feeds on worms, so it can't use the snake factions that hunt other small animals.
-- Actually no info on weight, I just kinda assumed 1g per 1cm of length since they're tiny.
ccb.content.define_monster {
    id = "mon_wormsnake",
    name = ccb.content.plural_text("worm snake", "worm snakes"),
    description = ccb.content.text("A small burrowing reptile that's just enjoying its time hunting earthworms."),
    copy_from = "mon_snake_abstract",
    default_faction = "lizard_tiny",
    volume = "25 ml",
    mass = "25 g",
    speed = 70,
    vision_day = 6,
    vision_night = 6,
    reproduction = { offspring = { egg = "egg_wormsnake" }, count = 8, interval = 50 },
    biosignature = { item = "shed_snakeskin_little", interval = 180 },
    inheritance = { add = { flags = { "CAN_DIG" }, fear_triggers = { "SOUND", "BRIGHT_LIGHT" } } },
}

ccb.content.define_monster {
    id = "mon_wormsnake_baby",
    name = ccb.content.plural_text("worm snake snakelet", "worm snake snakelets"),
    description = ccb.content.text("A worm snake in its hatchling stage.  Not that much smaller than an adult, actually."),
    default_faction = "lizard_tiny",
    copy_from = "mon_snakelet_abstract",
    upgrade = { grow_at_age = 300, monster = "mon_wormsnake" },
    inheritance = { add = { fear_triggers = { "BRIGHT_LIGHT" } } },
}

ccb.content.define_monster {
    id = "mon_turtle_painted",
    name = ccb.content.plural_text("painted turtle", "painted turtles"),
    description = ccb.content.text("A dark-colored species of freshwater turtle with bright orange markings."),
    copy_from = "mon_turtle_abstract",
    volume = "370 ml",
    mass = "370 g",
    hp = 2,
    reproduction = { offspring = { egg = "egg_turtle_painted" }, count = 8, interval = 40 },
    mating_seasons = { "SUMMER" },
}

-- In northmost regions of the range we're looking at 6 years as an absolute minimum to reach adulthood.
ccb.content.define_monster {
    id = "mon_turtle_painted_baby",
    name = ccb.content.plural_text("painted turtle hatchling", "painted turtle hatchlings"),
    description = ccb.content.text("A painted turtle in its hatchling stage."),
    copy_from = "mon_turtle_baby_abstract",
    upgrade = { grow_at_age = 2190, monster = "mon_turtle_painted" },
}

-- Similar to the garter snake, we're reaching 80 at maximum estimates, but that is a deeply unserious amount of baby turtles for the game to handle.
ccb.content.define_monster {
    id = "mon_turtle_snapping_common",
    name = ccb.content.plural_text("common snapping turtle", "common snapping turtles"),
    description = ccb.content.text("A prehistoric-looking species of freshwater turtle with a nasty bite."),
    copy_from = "mon_turtle_abstract",
    default_faction = "turtle_small_predator",
    volume = "6 L",
    mass = "6 kg",
    hp = 16,
    aggression = 15,
    melee_skill = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 3 } },
    anger_triggers = { "PLAYER_CLOSE" },
    reproduction = { offspring = { egg = "egg_turtle_snapping_common" }, count = 25, interval = 103 },
    mating_seasons = { "SUMMER" },
}

-- 12 years to reach maturity. It should probably be 15 years, because we're reaching the Northern range of the species in the setting, but odds are nobody is ever gonna see those grow to adulthood anyway.
ccb.content.define_monster {
    id = "mon_turtle_snapping_common_baby",
    name = ccb.content.plural_text("common snapping turtle hatchling", "common snapping turtle hatchlings"),
    description = ccb.content.text("A common snapping turtle in its hatchling stage."),
    copy_from = "mon_turtle_baby_abstract",
    default_faction = "turtle_small_predator",
    upgrade = { grow_at_age = 4380, monster = "mon_turtle_snapping_common" },
}

-- This is only a guesstimate. Other species of skinks with similar bodyplan reach ~40g of body mass at over double body length, so what we have is likely higher than in reality.
ccb.content.define_monster {
    id = "mon_skink_fivelined",
    name = ccb.content.plural_text("five-lined skink", "five-lined skinks"),
    description = ccb.content.text("A small species of skink.  The only native lizard of New England."),
    default_faction = "lizard_tiny",
    body_type = "lizard",
    categories = { "WILDLIFE" },
    species = { "REPTILE" },
    volume = "25 ml",
    mass = "25 g",
    hp = 1,
    speed = 125,
    materials = { "flesh" },
    symbol = "i",
    color = "brown",
    aggression = -30,
    morale = 60,
    melee_skill = 1,
    melee_dice = 1,
    melee_sides = 1,
    dodge = 6,
    vision_day = 20,
    vision_night = 5,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "mammal_tiny",
    dissect = "dissect_lizard_sample_single",
    fear_triggers = { "PLAYER_CLOSE", "HURT", "SOUND" },
    reproduction = { offspring = { egg = "egg_skink_fivelined" }, count = 18, interval = 55 },
    mating_seasons = { "SUMMER" },
    flags = { "SEES", "HEARS", "SMELLS", "HARDTOSHOOT", "PATH_AVOID_DANGER", "ANIMAL" },
}

-- Sexual maturity at 2-3 years, but there's no way in hell they don't reach adult size before that, so we take 10 months as a fairly safe guesstimate.
ccb.content.define_monster {
    id = "mon_skink_fivelined_baby",
    name = ccb.content.plural_text("five-lined skink hatchling", "five-lined skink hatchlings"),
    description = ccb.content.text("A five-lined skink in its hatchling stage."),
    copy_from = "mon_skink_fivelined",
    volume = "3 ml",
    mass = "3 g",
    speed = 60,
    morale = -20,
    vision_day = 16,
    vision_night = 3,
    upgrade = { grow_at_age = 300, monster = "mon_skink_fivelined" },
    inheritance = { add = { flags = { "NO_BREED" } } },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_big",
    name = ccb.content.plural_text("mutant rattlesnake", "mutant rattlesnakes"),
    description = ccb.content.text("A mutated timber rattlesnake, about three times as large as the norm.  While it isn't big enough to regard humans as potential prey, it is more aggressive and dangerous compared to a normal rattler."),
    copy_from = "mon_rattlesnake_giant",
    volume = "30 L",
    mass = "40750 g",
    aggression = -10,
    melee_skill = 5,
    melee_damage = { { type = "cut", amount = 6 } },
    attacks = {
        { reference = "RATTLE", cooldown = 8 },
        {
            cooldown = 6,
            damage = { { type = "stab", amount = 8, armor_multiplier = 0.8 } },
            kind = "bite",
        },
    },
    reproduction = { offspring = { monster = "mon_rattlesnake_s" }, count = 13, interval = 240 },
    mating_seasons = { "AUTUMN", "SUMMER" },
    upgrade = { half_life = 260, monster = "mon_rattlesnake_giant" },
    biosignature = { item = "shed_snakeskin_big", interval = 180 },
    armor = { bash = 1, cut = 3, bullet = 2, electric = 1 },
    inheritance = {
        remove = { anger_triggers = { "PLAYER_CLOSE" } },
        scale = { hp = 0.5, speed = 0.9, morale = 0.67, melee_sides = 0.5 },
    },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_big_s",
    name = ccb.content.plural_text("mutant rattlesnake snakelet", "mutant rattlesnake snakelet"),
    description = ccb.content.text("A large mutated timber rattlesnake in its hatchling stage.  It will eventually grow a rattle and learn how to hunt."),
    copy_from = "mon_rattlesnake_s",
    default_faction = "mutant",
    volume = "750 ml",
    mass = "1 kg",
    hp = 12,
    speed = 90,
    move_skills = { swim = 6 },
    materials = { "flesh" },
    symbol = "s",
    color = "brown",
    aggression = -30,
    upgrade = { grow_at_age = 365, monster = "mon_rattlesnake_big" },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    harvest = "mutant_tiny",
    biosignature = { item = "shed_snakeskin", interval = 180 },
    flags = {
        "SEES", "HEARS", "SMELLS", "BADVENOM", "HARDTOSHOOT", "KEENNOSE", "PATH_AVOID_DANGER", "ANIMAL",
        "INFRARED_VISION",
    },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_giant",
    name = ccb.content.plural_text("giant rattlesnake", "giant rattlesnakes"),
    description = ccb.content.text("A large mutated timber rattlesnake, about six times as large as the norm.  While it still isn't big enough to regard humans as potential prey, it is much more aggressive and dangerous compared to a normal rattler."),
    default_faction = "mutant",
    body_type = "snake",
    categories = { "WILDLIFE" },
    species = { "REPTILE" },
    difficulty_adjustment = 2,
    volume = "62500 ml",
    mass = "81500 g",
    hp = 64,
    speed = 100,
    move_skills = { climb = 6, swim = 6 },
    materials = { "flesh" },
    symbol = "s",
    color = "brown",
    morale = 60,
    aggressive_to_characters = false,
    melee_skill = 6,
    melee_dice = 2,
    melee_sides = 8,
    melee_damage = { { type = "cut", amount = 8 } },
    dodge = 4,
    vision_day = 30,
    vision_night = 8,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "mutant_animal_large_noskin",
    dissect = "dissect_lizard_sample_small",
    attacks = {
        { reference = "RATTLE", cooldown = 6 },
        {
            cooldown = 5,
            damage = { { type = "stab", amount = 10, armor_multiplier = 0.7 } },
            kind = "bite",
        },
    },
    anger_triggers = { "HURT", "PLAYER_CLOSE" },
    placate_triggers = { "PLAYER_WEAK" },
    reproduction = { offspring = { monster = "mon_rattlesnake_big_s" }, count = 15, interval = 120 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    upgrade = { half_life = 320, monster = "mon_rattlesnake_mega" },
    biosignature = { item = "shed_snakeskin_giant", interval = 180 },
    zombify_into = "mon_meat_cocoon_small",
    flags = {
        "SEES", "HEARS", "SMELLS", "BADVENOM", "HARDTOSHOOT", "KEENNOSE", "PATH_AVOID_DANGER", "ANIMAL",
        "INFRARED_VISION",
    },
    armor = { bash = 2, cut = 4, bullet = 3, electric = 1 },
}

-- Big jaw full of long fangs - about as grabby as you can get without multiple appendages, consider a coiling attack on next update
-- You brought this upon yourself, serpentdom is proud
-- Rattlesnake's gestation period is around 90 days, but it varies depending on the breed.  The timber rattlesnake has a gestation period of up to five months.
-- Deathrattle is heavily mutated, so a short gestation period and all-year large clutch birth are plausible
ccb.content.define_monster {
    id = "mon_rattlesnake_mega",
    name = ccb.content.plural_text("deathrattle serpent", "deathrattle serpents"),
    description = ccb.content.text("A primal fear strikes when the club-like tail of this massively warped snake shifts, an assortment of bones rattling softly.  Multiple sets of hollow fangs have erupted in its maw, which itself is flanked by skinless ropes of powerful muscle.  Its scales constantly shed off and regrow with unnatural speed."),
    default_faction = "mutant",
    body_type = "snake",
    categories = { "WILDLIFE" },
    species = { "REPTILE" },
    difficulty_adjustment = 10,
    volume = "620 L",
    mass = "760 kg",
    hp = 400,
    speed = 110,
    move_skills = { climb = 6, swim = 6 },
    materials = { "flesh" },
    symbol = "S",
    color = "brown",
    aggression = 60,
    morale = 100,
    aggressive_to_characters = false,
    melee_skill = 8,
    melee_dice = 6,
    melee_sides = 6,
    melee_damage = { { type = "stab", amount = 8 } },
    dodge = 3,
    vision_day = 35,
    vision_night = 35,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "mutant_animal_large_noskin",
    dissect = "dissect_lizard_sample_large",
    grab_strength = 70,
    attacks = {
        { reference = "RATTLE", cooldown = 2 },
        {
            id = "bite_grab",
            cooldown = 8,
            damage = { { type = "stab", amount = 32, armor_multiplier = 0.1 } },
            effects = { { id = "venom_dmg", duration = 2200 }, { id = "venom_weaken", duration = 9000 } },
            infection_chance = 100,
        },
    },
    regenerates = 2,
    anger_triggers = { "HURT", "PLAYER_CLOSE" },
    reproduction = { offspring = { monster = "mon_rattlesnake_big_s" }, count = 20, interval = 90 },
    zombify_into = "mon_meat_cocoon_large",
    biosignature = { item = "shed_snakeskin_scales", interval = 180 },
    flags = {
        "SEES", "HEARS", "SMELLS", "BADVENOM", "KEENNOSE", "PATH_AVOID_DANGER", "ANIMAL", "PUSH_MON",
        "INFRARED_VISION",
    },
    armor = { bash = 6, cut = 8, bullet = 6, electric = 3, acid = 6 },
}

ccb.content.define_monster {
    id = "mon_sewer_snake",
    name = ccb.content.plural_text("sewer snake", "sewer snakes"),
    description = ccb.content.text("An aggressive mutant variety of the worm snake, turned pale yellow from lack of sunlight.  It swarms beneath the ground, and is named for its habit of infesting sewer lines."),
    default_faction = "sewer_snake",
    body_type = "snake",
    species = { "REPTILE" },
    difficulty_adjustment = 2,
    volume = "30000 ml",
    mass = "40750 g",
    hp = 10,
    speed = 90,
    move_skills = { swim = 6 },
    materials = { "flesh" },
    symbol = "s",
    color = "yellow",
    aggression = 20,
    morale = 40,
    melee_skill = 6,
    melee_dice = 1,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 1,
    vision_day = 1,
    vision_night = 30,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "mutant_animal_large_noskin",
    dissect = "dissect_lizard_sample_single",
    pathing = { max_distance = 5 },
    zombify_into = "mon_meat_cocoon_small",
    flags = { "SEES", "SMELLS", "WARM", "VENOM" },
}

-- NO_I18N
ccb.content.define_monster {
    id = "mon_proxy_tadpole",
    abstract = true,
    description = ccb.content.text_without_extraction("The larval form of some species of frog.  This one is only hypothetical and you shouldn't be seeing it without debug."),
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    default_faction = "fish_tiny",
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "AMPHIBIAN" },
    volume = "5 ml",
    mass = "3 g",
    hp = 1,
    speed = 70,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "t",
    color = "brown",
    aggression = -60,
    morale = -5,
    dodge = 10,
    melee_training_cap = 0,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "exempt",
    vision_night = 30,
    fear_triggers = { "PLAYER_CLOSE", "HURT", "FRIEND_ATTACKED", "SOUND" },
    flags = { "FISHABLE", "SEES", "SMELLS", "HEARS", "AQUATIC", "WATER_CAMOUFLAGE", "SWARMS" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s is smashed to non-recognizable pieces."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_leo_tadpole",
    copy_from = "mon_proxy_tadpole",
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    description = ccb.content.text("A speckled, gray-brown tadpole.  Its tail is broad and paddle-like, and its body rotund.  Sometime soon it will grow legs and lose its tail entirely."),
    color = "dark_gray",
    upgrade = { grow_at_age = 22, monster_group = "GROUP_TADPOLE_LEO" },
}

ccb.content.define_monster {
    id = "mon_bullfrog_tadpole",
    copy_from = "mon_proxy_tadpole",
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    description = ccb.content.text("Every part of this speckled, green-brown tadpole is thick and broad.  It must be from some larger species of frog."),
    color = "green",
    volume = "240 ml",
    mass = "120 g",
    hp = 2,
    upgrade = { grow_at_age = 91, monster_group = "GROUP_TADPOLE_BULLFROG" },
}

ccb.content.define_monster {
    id = "mon_fowler_tadpole",
    copy_from = "mon_proxy_tadpole",
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    description = ccb.content.text("The larval form of some species of frog.  Soon enough it will undergo metamorphosis into its adult form.  This dark, speckled one has a rather large, bulbous body compared to its thin, tapered tail."),
    upgrade = { grow_at_age = 8, monster_group = "GROUP_TADPOLE_FOWLER" },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_freedom_tadpole",
    copy_from = "mon_proxy_tadpole",
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    description = ccb.content.text("The larval form of some species of frog.  Soon enough it will undergo metamorphosis into its adult form.  This dark, speckled one has a rather large, bulbous body compared to its thin, tapered tail."),
    upgrade = { grow_at_age = 15, monster_group = "GROUP_TADPOLE_FREEDOM" },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_peeper_tadpole",
    copy_from = "mon_proxy_tadpole",
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    description = ccb.content.text("A tiny larval frog.  Almost solid black, this one is barely a speck in the water around it."),
    color = "dark_gray",
    upgrade = { grow_at_age = 15, monster_group = "GROUP_TADPOLE_PEEPER" },
}

ccb.content.define_monster {
    id = "mon_gray_tadpole",
    copy_from = "mon_proxy_tadpole",
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    description = ccb.content.text("This rather unique tadpole might be mistaken for a small fish.  It sports a very broad tail with bright red-orange coloration at its end, dotted with black spots."),
    color = "red",
    upgrade = { grow_at_age = 15, monster_group = "GROUP_TADPOLE_GRAY" },
}

ccb.content.define_monster {
    id = "mon_mink_tadpole",
    copy_from = "mon_proxy_tadpole",
    description = ccb.content.text("A brown and tan speckled tadpole with a wide body and very broad, feather-shaped tail."),
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    upgrade = { grow_at_age = 91, monster = "mon_mink_frog" },
}

ccb.content.define_monster {
    id = "mon_pickerel_tadpole",
    copy_from = "mon_proxy_tadpole",
    description = ccb.content.text("This yellowish tadpole is covered in flecks of brown and cream coloring.  Its eyes rest close together on a notably pointed face."),
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    color = "yellow",
    upgrade = { grow_at_age = 22, monster_group = "GROUP_TADPOLE_PICKEREL" },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_green_tadpole",
    copy_from = "mon_proxy_tadpole",
    description = ccb.content.text("A corpulent green tadpole with a yellow underbelly and black speckles."),
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    color = "green",
    upgrade = { grow_at_age = 22, monster_group = "GROUP_TADPOLE_GREEN" },
}

ccb.content.define_monster {
    id = "mon_wood_tadpole",
    copy_from = "mon_proxy_tadpole",
    description = ccb.content.text("This mottled brown tadpole appears rather typical until you can get a glimpse from the side.  Then its high, peaked mouth and low round belly stand out in profile."),
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    upgrade = { grow_at_age = 15, monster_group = "GROUP_TADPOLE_WOOD" },
}

ccb.content.define_monster {
    id = "mon_spade_tadpole",
    copy_from = "mon_proxy_tadpole",
    description = ccb.content.text("A squat and wide-bellied tadpole with wide-set eyes."),
    name = ccb.content.plural_text("tadpole", "tadpoles"),
    upgrade = { grow_at_age = 8, monster = "mon_spade_frog" },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_proxy_bigtad",
    abstract = true,
    description = ccb.content.text("A tadpole the size of a bass.  It could win awards if it hadn't been debugged."),
    name = ccb.content.plural_text("giant tadpole", "giant tadpoles"),
    default_faction = "fish_small",
    body_type = "fish",
    species = { "AMPHIBIAN" },
    volume = "2 L",
    mass = "1500 g",
    hp = 10,
    speed = 120,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "J",
    color = "brown",
    aggression = -40,
    morale = 5,
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    melee_training_cap = 1,
    dodge = 6,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dissect = "dissect_batrachian_sample_single",
    harvest = "mutant_animal_noskin",
    vision_night = 30,
    fear_triggers = { "PLAYER_CLOSE", "FIRE", "HURT", "FRIEND_ATTACKED", "SOUND" },
    flags = { "FISHABLE", "SEES", "SMELLS", "HEARS", "AQUATIC", "WATER_CAMOUFLAGE" },
}

-- When possible, add effect for rare flicker of very low luminance.
ccb.content.define_monster {
    id = "mon_pattern_bigtad",
    copy_from = "mon_proxy_bigtad",
    description = ccb.content.text("A giant, gray-brown tadpole.  Its body is covered in irregular, chaotic speckles of pitch black and chalk white."),
    name = ccb.content.plural_text("giant tadpole", "giant tadpoles"),
    color = "dark_gray",
    upgrade = { grow_at_age = 22, monster = "mon_pattern_bigfrog" },
}

ccb.content.define_monster {
    id = "mon_strange_bigtad",
    copy_from = "mon_proxy_bigtad",
    description = ccb.content.text("This giant, green tadpole would have been an oddity before the collapse.  Now it's simply part of the scenery."),
    name = ccb.content.plural_text("giant tadpole", "giant tadpoles"),
    color = "green",
    upgrade = { grow_at_age = 91, monster = "mon_strange_bigfrog" },
}

ccb.content.define_monster {
    id = "mon_foul_bigtad",
    copy_from = "mon_proxy_bigtad",
    description = ccb.content.text("This big tadpole has already grown some warty bumps on its softball-sized body.  Its nearly whip-thin tail appears to have no trouble propelling its much larger core."),
    name = ccb.content.plural_text("giant tadpole", "giant tadpoles"),
    upgrade = { grow_at_age = 8, monster = "mon_foul_bigfrog" },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_odd_bigtad",
    copy_from = "mon_proxy_bigtad",
    description = ccb.content.text("Some kind of giant tadpole.  This speckled one has a body the size of a grapefruit and a thin, tapered tail.  It flits about the water in quick bursts."),
    name = ccb.content.plural_text("giant tadpole", "giant tadpoles"),
    upgrade = { grow_at_age = 10, monster = "mon_odd_bigfrog" },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_vocal_bigtad",
    copy_from = "mon_proxy_bigtad",
    description = ccb.content.text("A much larger than average tadpole.  Despite its unusual size, it is hard to make out any features from its dark, almost black, tint."),
    name = ccb.content.plural_text("giant tadpole", "giant tadpoles"),
    upgrade = { grow_at_age = 10, monster_group = "GROUP_BIGTAD_VOCAL" },
}

ccb.content.define_monster {
    id = "mon_shift_bigtad",
    copy_from = "mon_proxy_bigtad",
    color = "red",
    description = ccb.content.text("This tadpole's expanded size only accentuates its other unique feature.  Its tail fin is a vibrant gradient of crimson to yellow."),
    name = ccb.content.plural_text("giant tadpole", "giant tadpoles"),
    upgrade = { grow_at_age = 10, monster = "mon_shift_bigfrog" },
}

ccb.content.define_monster {
    id = "mon_proxy_frog",
    abstract = true,
    description = ccb.content.text("A hypothetical frog, if you're seeing this there's a problem."),
    name = ccb.content.plural_text("proxy frog", "proxy frogs"),
    default_faction = "amphibian_tiny",
    body_type = "frog",
    looks_like = "mon_frog",
    categories = { "WILDLIFE" },
    species = { "AMPHIBIAN" },
    volume = "300 ml",
    mass = "30 g",
    hp = 3,
    speed = 80,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "b",
    color = "brown",
    melee_damage = { { type = "cut", amount = 0 } },
    dodge = 6,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_amphibian" },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog" },
    dissect = "dissect_batrachian_sample_single",
    harvest = "mammal_tiny",
    vision_night = 30,
    attacks = { { cooldown = 32, maximum_range = 4, allow_no_target = true, kind = "leap" } },
    fear_triggers = { "PLAYER_CLOSE", "FIRE", "HURT", "FRIEND_ATTACKED", "SOUND" },
    mating_seasons = { "SPRING", "SUMMER" },
    flags = { "FISHABLE", "SEES", "SMELLS", "HEARS", "WATER_CAMOUFLAGE", "SMALL_HIDER", "SWARMS" },
}

ccb.content.define_monster {
    id = "mon_leo_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("Leopard frogs are named for the brown spots on their backs and legs.  Although limited by size, they too are voracious predators."),
    name = ccb.content.plural_text("leopard frog", "leopard frogs"),
    reproduction = { offspring = { egg = "egg_leo_frog" }, count = 6, interval = 20 },
}

-- When possible, add effect for rare flicker of very low luminance.
ccb.content.define_monster {
    id = "mon_pattern_frog",
    copy_from = "mon_leo_frog",
    description = ccb.content.text("This large frog is covered in chaotic markings like a fractal river map over a background of TV static.  While most lose their gills during metamorphosis, this frog seems to have retained them, or something like them."),
    name = ccb.content.plural_text("strangely-patterned frog", "strangely-patterned frogs"),
    categories = { "NULL" },
    harvest = "mutant_tiny",
    upgrade = { grow_at_age = 15, monster = "mon_pattern_bigfrog" },
}

ccb.content.define_monster {
    id = "mon_bullfrog_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("The American bullfrog, in its natural habitat.  It feeds on insects, mice, lizards, and any other living thing it can stuff down its gullet."),
    name = ccb.content.plural_text("bullfrog", "bullfrogs"),
    volume = "1000 ml",
    mass = "750 g",
    hp = 4,
    color = "green",
    harvest = "bullfrog",
    reproduction = { offspring = { egg = "egg_bullfrog_frog" }, count = 16, interval = 26 },
}

ccb.content.define_monster {
    id = "mon_strange_frog",
    copy_from = "mon_bullfrog_frog",
    description = ccb.content.text("Based on its vestigial tail, you would surmise that this bullfrog still has some growing to do.  That is if it weren't already larger than any adult frog."),
    name = ccb.content.plural_text("strange bullfrog", "strange bullfrogs"),
    categories = { "NULL" },
    volume = "4 L",
    mass = "3 kg",
    hp = 12,
    harvest = "mutant_tiny",
    upgrade = { grow_at_age = 15, monster = "mon_strange_bigfrog" },
}

ccb.content.define_monster {
    id = "mon_fowler_toad",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("Fowler's toads secrete a harmful and distasteful compound from their backs.  This helps safeguard them from predators and also gives them a distinctive odor like boiled peanuts."),
    name = ccb.content.plural_text("Fowler's toad", "Fowler's toads"),
    reproduction = { offspring = { egg = "egg_fowler_toad" }, count = 8, interval = 36 },
    inheritance = { add = { flags = { "POISON" } } },
}

-- NO_BREATHE flag is to prevent gassing by other 'foul' toads.  When possible, add effect for aoe morale debuff around toad. Possibly stack up until triggering nausea/vomiting.
ccb.content.define_monster {
    id = "mon_foul_toad",
    copy_from = "mon_fowler_toad",
    description = ccb.content.text("You could almost smell it before you saw it.  This toad reeks.  You're not quite sure what like, but it's hot and musky and it sticks in your nose until you're tasting it."),
    name = ccb.content.plural_text("foul toad", "foul toads"),
    categories = { "NULL" },
    harvest = "mutant_tiny",
    upgrade = { grow_at_age = 15, monster = "mon_foul_bigfrog" },
    inheritance = { add = { flags = { "POISON", "NO_BREATHE" } } },
}

ccb.content.define_monster {
    id = "mon_freedom_toad",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("American toads can vary greatly in appearance.  Individual toads will shift their coloration and patterning throughout the seasons to better camouflage."),
    name = ccb.content.plural_text("American toad", "American toads"),
    reproduction = { offspring = { egg = "egg_freedom_toad" }, count = 8, interval = 36 },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_odd_toad",
    copy_from = "mon_freedom_toad",
    description = ccb.content.text("Wide as a watermelon and halfway up to your knee, this toad's size is alarming.  So too are its odd proportions.  It's as if it hasn't fully grown."),
    name = ccb.content.plural_text("odd toad", "odd toads"),
    categories = { "NULL" },
    volume = "4 L",
    mass = "3 kg",
    hp = 12,
    harvest = "mutant_tiny",
    upgrade = { grow_at_age = 15, monster = "mon_odd_bigfrog" },
}

ccb.content.define_monster {
    id = "mon_peeper_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("This diminutive frog has a distinctive chirping call and bands of darker skin that come to form a rough 'X' shape on its back."),
    name = ccb.content.plural_text("spring peeper", "spring peepers"),
    volume = "20 ml",
    mass = "4 g",
    hp = 1,
    attacks = {
        { reference = "PARROT", cooldown = 30 },
        { cooldown = 32, maximum_range = 4, allow_no_target = true, kind = "leap" },
    },
    reproduction = { offspring = { egg = "egg_peeper_frog" }, count = 8, interval = 20 },
}

ccb.content.define_monster {
    id = "mon_vocal_frog",
    copy_from = "mon_peeper_frog",
    description = ccb.content.text("A small brown frog with a very big voice.  When it calls, its whole criss-crossed torso expands and trembles like an inflatable suit.  The loud squeaky sound it makes is more charming than troubling.  The frequency can be exhausting."),
    name = ccb.content.plural_text("vocal treefrog", "vocal treefrogs"),
    categories = { "NULL" },
    harvest = "mutant_tiny",
    upgrade = { grow_at_age = 15, monster_group = "GROUP_FROGS_UPGRADE_VOCAL" },
}

ccb.content.define_monster {
    id = "mon_gray_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("This treefrog can change its coloration much like a chameleon, shifting from a near-white gray, through greens and browns, to a dark, almost charcoal color."),
    name = ccb.content.plural_text("gray treefrog", "gray treefrogs"),
    volume = "150 ml",
    mass = "10 g",
    hp = 2,
    color = "light_gray",
    reproduction = { offspring = { egg = "egg_gray_frog" }, count = 8, interval = 26 },
    inheritance = { add = { flags = { "CAMOUFLAGE" } } },
}

ccb.content.define_monster {
    id = "mon_shift_frog",
    copy_from = "mon_gray_frog",
    description = ccb.content.text("You've seen it wrinkle its skin into bark and disappear on a tree; settle on a toadstool and take its spots.  It's no trick of the light, this frog's skin shifts not just color but texture."),
    name = ccb.content.plural_text("shifting treefrog", "shifting treefrogs"),
    categories = { "NULL" },
    harvest = "mutant_tiny",
    upgrade = { grow_at_age = 15, monster = "mon_shift_bigfrog" },
}

ccb.content.define_monster {
    id = "mon_mink_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("This pungent frog is named for the mammal with which it shares both name and odor.  Its skin is light green underneath a heavy spatter of almost black mottling."),
    name = ccb.content.plural_text("mink frog", "mink frogs"),
    volume = "150 ml",
    mass = "10 g",
    hp = 2,
    color = "green",
    reproduction = { offspring = { egg = "egg_mink_frog" }, count = 8, interval = 26 },
}

ccb.content.define_monster {
    id = "mon_tail_frog",
    copy_from = "mon_mink_frog",
    description = ccb.content.text("This very large, funky frog has an accentuated, paddle-like tail that accounts for half its body mass.  It is green with many brown spots scattering across its back."),
    name = ccb.content.plural_text("tailed frog", "tailed frogs"),
    categories = { "NULL" },
    harvest = "mutant_tiny",
}

ccb.content.define_monster {
    id = "mon_pickerel_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("The pickerel frog is identifiable by two rows of roughly square-shaped spots that run along its back, shaded a darker brown than the rest of their skin.  Though not more than an irritant to humans, their skin secretions are known for being fatal to most things their size."),
    name = ccb.content.plural_text("pickerel frog", "pickerel frogs"),
    volume = "150 ml",
    mass = "10 g",
    hp = 2,
    reproduction = { offspring = { egg = "egg_pickerel_frog" }, count = 8, interval = 26 },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_palette_frog",
    copy_from = "mon_pickerel_frog",
    description = ccb.content.text("You're quite sure that no frog this bright and garish could be native to New England.  Most of its skin is a light brown, but the large, squarish patches on its back and legs are of every different hue, all of them bright."),
    name = ccb.content.plural_text("palette frog", "palette frogs"),
    categories = { "NULL" },
    color = "magenta",
    harvest = "mutant_tiny",
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_green_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("True to its name this frog is green.  Though this one is certainly of the Northern subspecies, they are common throughout, and native to, the Eastern half of North America.  The shades of green can vary greatly and there might be some brown on the limbs or mottled on the back."),
    name = ccb.content.plural_text("green frog", "green frogs"),
    volume = "150 ml",
    mass = "10 g",
    hp = 2,
    color = "green",
    reproduction = { offspring = { egg = "egg_green_frog" }, count = 8, interval = 20 },
}

ccb.content.define_monster {
    id = "mon_wood_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("This frog wears a pattern of tans and browns, with a darker eye mask and a light cream underbelly.  Its coverings make for great camouflage among the dry leaves and tree bark."),
    name = ccb.content.plural_text("wood frog", "wood frogs"),
    volume = "150 ml",
    mass = "10 g",
    hp = 2,
    reproduction = { offspring = { egg = "egg_wood_frog" }, count = 8, interval = 36 },
}

ccb.content.define_monster {
    id = "mon_spade_frog",
    copy_from = "mon_proxy_frog",
    description = ccb.content.text("The eastern variety of the American spadefoot toad is a squat, round toad with vertical pupils.  Its body is colored a muddy mixture of browns, tans, and yellow-greens.  Their name comes from the keratinous projection on their hind legs that aids them in digging."),
    name = ccb.content.plural_text("spadefoot toad", "spadefoot toads"),
    volume = "150 ml",
    mass = "10 g",
    hp = 2,
    reproduction = { offspring = { egg = "egg_spade_frog" }, count = 8, interval = 20 },
    mating_seasons = { "SPRING", "SUMMER", "FALL", "WINTER" },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_leo_worm",
    copy_from = "mon_leo_frog",
    description = ccb.content.text("You see a whole leopard frog and then some.  This poor thing must have almost a dozen extra legs sticking off of it.  It is difficult to determine an exact number as most of them are underdeveloped or otherwise malformed."),
    name = ccb.content.plural_text("many-legged frog", "many-legged frogs"),
    categories = { "NULL" },
    dissect = "dissect_worm_frog_single",
    harvest = "mutant_tiny",
    attacks = {
        {
            cooldown = 32,
            maximum_range = 4,
            allow_no_target = true,
            random_leap = true,
            kind = "leap",
        },
    },
}

ccb.content.define_monster {
    id = "mon_green_worm",
    copy_from = "mon_green_frog",
    description = ccb.content.text("A green frog that has suffered some kind of mutation.  At its hips it has clusters of extra legs, some are complete but others lack feet or end at the first joint."),
    name = ccb.content.plural_text("many-legged frog", "many-legged frogs"),
    categories = { "NULL" },
    dissect = "dissect_worm_frog_single",
    harvest = "mutant_tiny",
    attacks = {
        {
            cooldown = 32,
            maximum_range = 4,
            allow_no_target = true,
            random_leap = true,
            kind = "leap",
        },
    },
}

ccb.content.define_monster {
    id = "mon_wood_worm",
    copy_from = "mon_wood_frog",
    description = ccb.content.text("This cream and brown frog looks more like a great insect in profile.  It has evidently mutated, growing many additional, spindly legs that rise high before attempting to bend back downwards."),
    name = ccb.content.plural_text("many-legged frog", "many-legged frogs"),
    categories = { "NULL" },
    dissect = "dissect_worm_frog_single",
    harvest = "mutant_tiny",
    attacks = {
        {
            cooldown = 32,
            maximum_range = 4,
            allow_no_target = true,
            random_leap = true,
            kind = "leap",
        },
    },
}

ccb.content.define_monster {
    id = "mon_proxy_bigfrog",
    abstract = true,
    name = ccb.content.plural_text("oversized proxy frog", "oversized proxy frogs"),
    description = ccb.content.text("An unreal frog of unusually large size.  This one is here by mistake; likely drawn by some kind of (de)bug."),
    default_faction = "frog",
    body_type = "frog",
    species = { "AMPHIBIAN" },
    volume = "60 L",
    mass = "50 kg",
    hp = 50,
    speed = 100,
    move_skills = { climb = 4, swim = 8 },
    materials = { "flesh" },
    symbol = "m",
    color = "brown",
    aggression = -10,
    morale = 20,
    aggressive_to_characters = false,
    melee_skill = 5,
    melee_dice = 1,
    melee_sides = 8,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 2,
    armor = { bash = 4 },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_amphibian" },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog" },
    dissect = "dissect_batrachian_sample_single",
    harvest = "mutant_animal_large_noskin",
    vision_night = 30,
    pathing = { max_distance = 5 },
    grab_strength = 2,
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 3,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 10,
            move_cost = 0,
            maximum_range = 10,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    fear_triggers = { "FRIEND_DIED", "FIRE", "SOUND" },
    anger_triggers = { "STALK", "PLAYER_WEAK", "PLAYER_CLOSE", "MATING_SEASON" },
    burn_into = "mon_frog_husk",
    mating_seasons = { "SPRING", "SUMMER" },
    flags = { "FISHABLE", "SEES", "SMELLS", "HEARS", "SWARMS", "WATER_CAMOUFLAGE" },
}

ccb.content.define_monster {
    id = "mon_strange_bigfrog",
    name = ccb.content.plural_text("mutant bullfrog", "mutant bullfrogs"),
    description = ccb.content.text("A mutant bullfrog larger than most dogs.  It looks unwell, as if this growth spurt was less than comfortable."),
    copy_from = "mon_proxy_bigfrog",
    color = "light_green",
    aggression = 0,
    upgrade = { grow_at_age = 30, monster_group = "GROUP_FROGS_UPGRADE_STRANGE" },
    zombify_into = "mon_zombullfrog",
    reproduction = { offspring = { egg = "egg_strange_bigfrog" }, count = 12, interval = 20 },
    inheritance = { remove = { flags = { "SWARMS" } } },
}

ccb.content.define_monster {
    id = "mon_odd_bigfrog",
    name = ccb.content.plural_text("oversized toad", "oversized toads"),
    description = ccb.content.text("This toad seems to have been mutated to absurd size by the Cataclysm.  It's only half your size but that hardly feels comforting."),
    copy_from = "mon_proxy_bigfrog",
    aggression = 0,
    upgrade = { grow_at_age = 30, monster_group = "GROUP_FROGS_UPGRADE_ODD" },
    zombify_into = "mon_toad_zombie",
    reproduction = { offspring = { egg = "egg_odd_bigfrog" }, count = 12, interval = 20 },
    inheritance = { add = { flags = { "POISON" } }, remove = { flags = { "SWARMS" } } },
}

ccb.content.define_monster {
    id = "mon_pattern_bigfrog",
    name = ccb.content.plural_text("staticskin frog", "staticskin frogs"),
    description = ccb.content.text("Bioluminescent trails trace through the dark speckled patterns on this oversized frog's skin.  What would be cleanly defined spots on another frog, are instead fragmented collages of gray and black pigment over pale skin.  Its vestigial gills have grown into something else.  You can see them bulging the flesh under its mouth."),
    copy_from = "mon_proxy_bigfrog",
    volume = "30 L",
    mass = "20 kg",
    hp = 40,
    speed = 80,
    symbol = "x",
    color = "light_blue",
    melee_sides = 4,
    melee_damage = { { type = "electric", amount = 3 }, { type = "cut", amount = 1 } },
    armor = { bash = 2, acid = 2, heat = 1, electric = 4 },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog", "wps_amphibian_electric" },
    luminance = 3,
    defense = { id = "ZAPBACK", chance = 100 },
    upgrade = { grow_at_age = 30, monster_group = "GROUP_FROGS_UPGRADE_PATTERN" },
    zombify_into = "mon_frog_shocker",
    reproduction = { offspring = { egg = "egg_pattern_bigfrog" }, count = 12, interval = 20 },
}

-- When possible, add an AOE burst & temporary trail of slippery, toxic grease on several hour cooldown.  The toad can expel grease like a squid with ink.  The grease offgasses into something between tear gas and a blister agent, hence the smell.  NO_BREATHE flag is to prevent self-gassing.
ccb.content.define_monster {
    id = "mon_foul_bigfrog",
    name = ccb.content.plural_text("greasy stinktoad", "greasy stinktoads"),
    description = ccb.content.text("This lumpy oversized toad is a real stinker!  A miasma like rotted onions coated in rancid peanut butter surrounds it.  Even approaching it makes your eyes water and your throat tighten until you're coughing to catch breath.  It doesn't help that its leathery skin looks to be coated in a thick greasy substance, no doubt related to the creature's horrid odor."),
    copy_from = "mon_proxy_bigfrog",
    volume = "30 L",
    mass = "20 kg",
    hp = 40,
    speed = 70,
    symbol = "g",
    melee_sides = 4,
    armor = { bash = 2, acid = 4, heat = 1 },
    emissions = { { id = "emit_tear_gas_toad", delay = "1 s" } },
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 3,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 5,
            move_cost = 0,
            maximum_range = 6,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    upgrade = { grow_at_age = 30, monster_group = "GROUP_FROGS_UPGRADE_FOUL" },
    zombify_into = "mon_toad_zombie",
    reproduction = { offspring = { egg = "egg_foul_bigfrog" }, count = 12, interval = 20 },
    inheritance = { add = { flags = { "POISON", "NO_BREATHE" } } },
}

-- Give climbing (Z axis) ability when available.
ccb.content.define_monster {
    id = "mon_jumbo_bigfrog",
    name = ccb.content.plural_text("jumbo treefrog", "jumbo treefrogs"),
    description = ccb.content.text("On thick, over-proportioned legs, this large treefrog slings its weight with notable force.  It doesn't seem dangerous, but its size is still cause for concern.  Even scrunched up, it is as large as a Thanksgiving turkey."),
    copy_from = "mon_proxy_bigfrog",
    volume = "20 L",
    mass = "14 kg",
    hp = 20,
    speed = 110,
    symbol = "k",
    morale = 10,
    melee_sides = 2,
    dodge = 3,
    grab_strength = 1,
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 3,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 8,
            move_cost = 0,
            maximum_range = 12,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    fear_triggers = { "HURT", "FRIEND_DIED", "FIRE", "SOUND" },
    anger_triggers = { "PLAYER_CLOSE", "MATING_SEASON" },
    zombify_into = "mon_zombtreefrog",
    reproduction = { offspring = { egg = "egg_vocal_bigfrog" }, count = 12, interval = 20 },
    harvest = "bullfrog",
    inheritance = { remove = { flags = { "SWARMS" } } },
}

-- Give climbing (Z axis) ability when available.
ccb.content.define_monster {
    id = "mon_vocal_bigfrog",
    name = ccb.content.plural_text("wailing treefrog", "wailing treefrogs"),
    description = ccb.content.text("Now the size of a dog, this tan, speckled tree frog will not stop making noise.  Its increased size has only boosted its volume.  It belts out sound in a relentless series of piercing, grinding chirps."),
    copy_from = "mon_jumbo_bigfrog",
    attacks = {
        { reference = "PARROT", cooldown = 30 },
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 3,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 8,
            move_cost = 0,
            maximum_range = 12,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
}

-- Give climbing (Z axis) ability when available.
ccb.content.define_monster {
    id = "mon_shift_bigfrog",
    name = ccb.content.plural_text("mimic treefrog", "mimic treefrogs"),
    description = ccb.content.text("You've seen enough to gather that this is a frog with some very specialized camouflage.  Its skin appears able to reactively change texture and color to match its surroundings.  Like a morphing ghillie suit it can extend filaments to mimic individual leaves and blades of grass.  It is keen enough to match the swaying of brush in the wind."),
    copy_from = "mon_jumbo_bigfrog",
    speed = 130,
    color = "light_gray",
    dodge = 6,
    armor = { bash = 5, acid = 2, heat = 5, electric = 4 },
    vision_night = 35,
    zombify_into = "mon_frog_shadow",
    reproduction = { offspring = { egg = "egg_shift_bigfrog" }, count = 12, interval = 20 },
    inheritance = { add = { flags = { "CAMOUFLAGE" } } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_proxy_giganfrog",
    abstract = true,
    name = ccb.content.text_without_extraction("giant proxy frog"),
    description = ccb.content.text_without_extraction("This frog is much too big to be real, must be a bug"),
    default_faction = "frog",
    body_type = "frog",
    species = { "AMPHIBIAN" },
    volume = "240 L",
    mass = "200 kg",
    hp = 120,
    speed = 90,
    move_skills = { climb = 4, swim = 8 },
    materials = { "flesh" },
    symbol = "M",
    color = "brown",
    aggression = 10,
    morale = 100,
    aggressive_to_characters = false,
    melee_skill = 5,
    melee_dice = 1,
    melee_sides = 12,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 2,
    armor = { bash = 4, electric = 1 },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_amphibian" },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog" },
    dissect = "dissect_batrachian_sample_small",
    harvest = "mutant_animal_large_noskin",
    vision_night = 30,
    pathing = { max_distance = 5 },
    grab_strength = 20,
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 4,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 10,
            move_cost = 0,
            maximum_range = 10,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    fear_triggers = { "FIRE" },
    anger_triggers = { "STALK", "PLAYER_WEAK", "PLAYER_CLOSE", "MATING_SEASON" },
    burn_into = "mon_frog_mummy",
    mating_seasons = { "SPRING", "SUMMER" },
    flags = { "FISHABLE", "SEES", "SMELLS", "HEARS", "GRABS", "WATER_CAMOUFLAGE", "BASHES" },
}

ccb.content.define_monster {
    id = "mon_strange_giganfrog",
    name = ccb.content.plural_text("giant bullfrog", "giant bullfrogs"),
    description = ccb.content.text("A mutated bullfrog taller than you are.  It stares with amber eyes as it considers the easiest way to swallow you whole."),
    copy_from = "mon_proxy_giganfrog",
    color = "light_green",
    upgrade = { grow_at_age = 45, monster_group = "GROUP_FROGS_UPGRADE_STRANGE_MEGA" },
    zombify_into = "mon_zombullfrog",
    reproduction = { offspring = { egg = "egg_strange_bigfrog" }, count = 18, interval = 20 },
}

ccb.content.define_monster {
    id = "mon_odd_giganfrog",
    name = ccb.content.plural_text("giant toad", "giant toads"),
    description = ccb.content.text("This toad has grown bigger than a human.  It looks uninterested in eating you but you better not give it a chance."),
    copy_from = "mon_proxy_giganfrog",
    upgrade = { grow_at_age = 45, monster_group = "GROUP_FROGS_UPGRADE_ODD_MEGA" },
    zombify_into = "mon_toad_zombie",
    reproduction = { offspring = { egg = "egg_odd_bigfrog" }, count = 18, interval = 20 },
    inheritance = { add = { flags = { "POISON" } } },
}

ccb.content.define_monster {
    id = "mon_pattern_giganfrog",
    name = ccb.content.plural_text("taser tongue", "taser tongues"),
    description = ccb.content.text("This pale, trash can-sized frog sports a series of faintly glowing spots among its chaotic skin patterns.  The glow seems most concentrated around its unusually bulky neck and mouth.  Its dark eyes scan for an appetizing target."),
    copy_from = "mon_proxy_giganfrog",
    volume = "200 L",
    mass = "180 kg",
    hp = 100,
    symbol = "P",
    color = "light_blue",
    aggression = -1,
    morale = 50,
    melee_skill = 4,
    melee_damage = { { type = "electric", amount = 6 }, { type = "cut", amount = 1 } },
    armor = { bash = 6, cut = 2, acid = 3, heat = 3, electric = 6 },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog", "wps_amphibian_electric" },
    luminance = 2,
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 4,
            damage = { { type = "electric", amount = 4 } },
            effects = { { id = "zapped", duration = { 2, 10 } } },
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 10,
            move_cost = 0,
            maximum_range = 8,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    defense = { id = "ZAPBACK", chance = 100 },
    anger_triggers = { "PLAYER_WEAK", "PLAYER_CLOSE", "MATING_SEASON", "FRIEND_ATTACKED" },
    zombify_into = "mon_frog_shocker",
    reproduction = { offspring = { egg = "egg_pattern_bigfrog" }, count = 18, interval = 20 },
    inheritance = { add = { flags = { "SWARMS" } } },
}

-- When possible, add ability to dig furrows (lines of shallow pits) and wallow.  NO_BREATHE flag is to prevent gassing by younger of its kind.
ccb.content.define_monster {
    id = "mon_foul_giganfrog",
    name = ccb.content.plural_text("giant hogtoad", "giant hogtoads"),
    description = ccb.content.text("This large, odious, boar-sized toad shares some features with its namesake.  It grunts, roots and wallows, but more striking are the dense tusk-like growths sprouting from its face and jaw.  Though they seem to be most effective for burrowing and protection, in places they come to curved points that look quite sharp."),
    copy_from = "mon_proxy_giganfrog",
    speed = 100,
    symbol = "G",
    melee_sides = 20,
    melee_damage = { { type = "cut", amount = 2 } },
    armor = { bash = 6, cut = 3, acid = 5, heat = 2, electric = 2 },
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_amphibian",
        "prof_wp_skeleton",
    },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog", "wps_amphibian_bone", "wps_bone_armor" },
    emissions = { { id = "emit_tear_gas_leak", delay = "1 s" } },
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 3,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 8,
            move_cost = 0,
            maximum_range = 8,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    anger_triggers = { "PLAYER_WEAK", "PLAYER_CLOSE", "MATING_SEASON", "FRIEND_ATTACKED" },
    upgrade = { grow_at_age = 45, monster_group = "GROUP_FROGS_UPGRADE_FOUL_MEGA" },
    zombify_into = "mon_toad_zombie",
    reproduction = { offspring = { egg = "egg_foul_bigfrog" }, count = 18, interval = 20 },
    inheritance = { add = { flags = { "POISON", "NO_BREATHE", "SWARMS" } } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_proxy_megafrog",
    abstract = true,
    name = ccb.content.text_without_extraction("mega proxy frog"),
    description = ccb.content.text_without_extraction("You can only imagine the size of the (de)bugs that drew out this enormous frog"),
    default_faction = "frog",
    body_type = "frog",
    species = { "AMPHIBIAN" },
    volume = "650 L",
    mass = "800 kg",
    hp = 1200,
    regenerates = 4,
    speed = 80,
    move_skills = { swim = 8 },
    materials = { "flesh" },
    symbol = "F",
    color = "brown",
    aggression = 5,
    morale = 100,
    aggressive_to_characters = false,
    melee_skill = 4,
    melee_dice = 6,
    melee_sides = 10,
    melee_damage = { { type = "cut", amount = 1 } },
    armor = { bash = 8, cut = 3, bullet = 2, electric = 2 },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_amphibian" },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog" },
    dissect = "dissect_batrachian_sample_huge",
    harvest = "mutant_animal_large_noskin",
    vision_night = 10,
    pathing = { max_distance = 5 },
    grab_strength = 50,
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 5,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 10,
            move_cost = 0,
            maximum_range = 12,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    fear_triggers = { "FIRE" },
    anger_triggers = { "STALK", "PLAYER_WEAK", "PLAYER_CLOSE", "MATING_SEASON" },
    burn_into = "mon_frog_smoker_hulk",
    mating_seasons = { "SPRING", "SUMMER" },
    flags = { "SEES", "SMELLS", "GRABS", "HEARS", "DESTROYS" },
}

ccb.content.define_monster {
    id = "mon_strange_megafrog",
    name = ccb.content.plural_text("colossal croaker", "colossal croakers"),
    description = ccb.content.text("Bloated to titanic size, rivaling a moose, this mutated bullfrog takes several seconds just to blink each vacant eye.  In place of the cognition it has lost, the beast has gained an even more voracious appetite and the might to sustain it."),
    copy_from = "mon_proxy_megafrog",
    color = "green",
    attacks = {
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 5,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 10,
            move_cost = 0,
            maximum_range = 12,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
        { reference = "SHRIEK_ALERT", cooldown = 20 },
        { reference = "SHRIEK_STUN", cooldown = 5 },
    },
    zombify_into = "mon_frog_dad",
    reproduction = { offspring = { egg = "egg_strange_bigfrog" }, count = 32, interval = 20 },
}

-- Simple wallowing, likes to create deep pits and lay in them.
ccb.content.define_monster {
    id = "mon_odd_megafrog",
    name = ccb.content.plural_text("gargantuan toad", "gargantuan toads"),
    description = ccb.content.text("This toad is of truly enormous stature, larger than many cars.  You can't help but wonder if it could fit as many people inside."),
    copy_from = "mon_proxy_megafrog",
    armor = { bash = 18, cut = 18, bullet = 12, electric = 4 },
    zombify_into = "mon_toad_wart",
    reproduction = { offspring = { egg = "egg_odd_bigfrog" }, count = 32, interval = 20 },
    inheritance = { add = { flags = { "POISON" } } },
}

-- When possible, add ability to dig furrows (lines of shallow pits) and wallow.  NO_BREATHE flag is to prevent gassing by younger of its kind.
ccb.content.define_monster {
    id = "mon_foul_megafrog",
    name = ccb.content.plural_text("great beaked toad", "great beaked toads"),
    description = ccb.content.text("This massive toad's jaw bones have grown out from its lips into a powerful beak, large enough to snap a bicycle in two.  The bony growths extend to its face, ringing its eyes and shielding its parotoid glands, swollen with poison.  Though intimidating, it appears more interested in a soothing mud bath than anything violent."),
    copy_from = "mon_proxy_megafrog",
    volume = "325 L",
    mass = "400 kg",
    hp = 400,
    regenerates = 2,
    speed = 90,
    symbol = "B",
    aggression = 0,
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 8,
    melee_damage = { { type = "cut", amount = 4 } },
    dodge = 1,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_amphibian",
        "prof_wp_skeleton",
    },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog", "wps_amphibian_bone", "wps_bone_armor" },
    grab_strength = 35,
    attacks = {
        {
            id = "bite_grab",
            cooldown = 5,
            accuracy = 5,
            damage = {
                { type = "cut", amount = 26, armor_multiplier = 0.2 },
                { type = "bash", amount = 14, armor_multiplier = 0.2 },
            },
            effects = { { id = "venom_pain", duration = 20, affect_hit_body_part = true } },
            when = "monster_attack_intact_mandibles",
        },
        {
            id = "ranged_pull",
            cooldown = 10,
            range = 4,
            avatar_hit = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_hit = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            avatar_miss = ccb.content.text_without_extraction("%s's tongue lashes out at you, but you dodge!"),
            npc_miss = ccb.content.text_without_extraction("%s's tongue lashes out at <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text_without_extraction("%s catches you with its tongue and pulls you in!"),
            npc_no_damage = ccb.content.text_without_extraction("%s catches <npcname> with its tongue and pulls them in!"),
            when = "allow_proxy_bigfrog_ranged_pull",
        },
        {
            cooldown = 8,
            move_cost = 0,
            maximum_range = 8,
            minimum_target_distance = 2,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    anger_triggers = { "PLAYER_WEAK", "PLAYER_CLOSE", "MATING_SEASON", "FRIEND_ATTACKED" },
    zombify_into = "mon_toad_bone",
    reproduction = { offspring = { egg = "egg_foul_bigfrog" }, count = 32, interval = 20 },
    inheritance = { add = { flags = { "POISON", "NO_BREATHE" } } },
}
