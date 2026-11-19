local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- ~0.75g/ml density for most wild birds
ccb.content.define_monster {
    id = "mon_bird_flying_base",
    abstract = true,
    name = ccb.content.text_without_extraction("flying bird abstract"),
    description = ccb.content.text_without_extraction("This is an abstract monster for other flying birds to copy from, so that we have some common foundation to work with.  If it appears in the game that's a bug.  Use this when your bird can fly, but cannot swim."),
    body_type = "bird",
    default_faction = "bird_small_flying",
    categories = { "WILDLIFE" },
    species = { "BIRD" },
    volume = "467 ml",
    mass = "350 g",
    hp = 1,
    speed = 200,
    materials = { "flesh" },
    symbol = "v",
    color = "dark_gray",
    aggression = -99,
    morale = 5,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 0 } },
    dodge = 4,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_flying",
        "prof_wp_basic_bird",
    },
    weakpoint_sets = { "wps_bird_body" },
    harvest = "bird_tiny",
    dissect = "dissect_bird_sample_single",
    mating_seasons = { "SPRING", "SUMMER" },
    fear_triggers = { "SOUND", "PLAYER_CLOSE", "FRIEND_ATTACKED", "FRIEND_DIED", "FIRE", "HURT" },
    biosignature = { item = "feces_bird", interval = 4 },
    flags = {
        "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "WARM", "FLIES", "SWARMS", "CANPLAY",
        "CAN_BE_CULLED", "PET_WONT_FOLLOW", "SMALL_HIDER",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_bird_flightless_base",
    abstract = true,
    name = ccb.content.text_without_extraction("flightless bird abstract"),
    description = ccb.content.text_without_extraction("This is an abstract monster for other flightless birds to copy from, so that we have some common foundation to work with.  If it appears in the game that's a bug.  Use this when your bird can neither fly nor swim."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_small_flightless",
    speed = 105,
    inheritance = { remove = { flags = { "FLIES" } } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_bird_water_base",
    abstract = true,
    name = ccb.content.text_without_extraction("water bird abstract"),
    description = ccb.content.text_without_extraction("This is an abstract monster for other water birds to copy from, so that we have some common foundation to work with.  If it appears in the game that's a bug.  Use this when your bird can both fly and swim."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_small_waterfowl",
    speed = 85,
    inheritance = { add = { move_skills = { swim = 4 } } },
}

-- Grows up into a standard chicken as a fallback
ccb.content.define_monster {
    id = "mon_generic_chick",
    abstract = true,
    name = ccb.content.plural_text("brown chick", "brown chicks"),
    description = ccb.content.text("A tiny darkly-colored chick, it could be from a number of different species."),
    default_faction = "bird_tiny_flightless",
    body_type = "bird",
    categories = { "WILDLIFE" },
    species = { "BIRD" },
    volume = "80 ml",
    mass = "60 g",
    hp = 1,
    speed = 40,
    materials = { "flesh" },
    symbol = "v",
    color = "yellow",
    aggression = -99,
    morale = -8,
    melee_skill = 1,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 0 } },
    dodge = 1,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_bird" },
    harvest = "bird_tiny",
    upgrade = { grow_at_age = 14, monster = "mon_chicken" },
    fear_triggers = { "SOUND", "PLAYER_CLOSE", "FRIEND_ATTACKED", "FRIEND_DIED", "FIRE", "HURT" },
    flags = {
        "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "PATH_AVOID_FIRE", "WARM", "SWARMS",
        "CAN_BE_CULLED", "CANPLAY", "SMALL_HIDER",
    },
}

-- Grows up into a sparrow as a fallback
ccb.content.define_monster {
    id = "mon_generic_chick_tiny",
    abstract = true,
    name = ccb.content.plural_text("gray chick", "gray chicks"),
    description = ccb.content.text("A tiny dull-colored chick, it could be from a number of different species."),
    copy_from = "mon_generic_chick",
    looks_like = "mon_generic_chick_tiny",
    volume = "7 ml",
    mass = "5 g",
    upgrade = { grow_at_age = 14, monster = "mon_sparrow" },
}

-- Grows up into a duck as a fallback
ccb.content.define_monster {
    id = "mon_generic_chick_water",
    abstract = true,
    name = ccb.content.plural_text("waterfowl chick", "waterfowl chicks"),
    description = ccb.content.text("A tiny yellow and brown waterfowl chick, it could be from a number of different species."),
    copy_from = "mon_generic_chick",
    default_faction = "bird_tiny_waterfowl",
    upgrade = { grow_at_age = 14, monster = "mon_duck" },
    inheritance = { add = { move_skills = { swim = 4 } } },
}

ccb.content.define_monster {
    id = "mon_chicken",
    name = ccb.content.plural_text("chicken", "chickens"),
    description = ccb.content.text("A domesticated descendant of junglefowl, it may still be the most numerous bird in the world.  Before the Cataclysm, it was raised by humans as a source of meat, eggs, and early morning wakeup calls."),
    copy_from = "mon_bird_flightless_base",
    volume = "2667 ml",
    mass = "2 kg",
    harvest = "bird_small",
    hp = 5,
    speed = 95,
    color = "white",
    reproduction = { offspring = { egg = "egg_chicken" }, count = 1, interval = 2 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN", "WINTER" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

ccb.content.define_monster {
    id = "mon_grouse",
    name = ccb.content.plural_text("ruffed grouse", "ruffed grouses"),
    description = ccb.content.text("A very common game bird, these creatures remind you of what a wild chicken must have been like."),
    copy_from = "mon_bird_flying_base",
    volume = "860 ml",
    mass = "645 g",
    speed = 140,
    color = "brown",
    reproduction = { offspring = { egg = "egg_grouse" }, count = 11, interval = 35 },
}

ccb.content.define_monster {
    id = "mon_crow",
    name = ccb.content.plural_text("American crow", "American crows"),
    description = ccb.content.text("Sleek and glossy feathers cover this dark bird.  Its pointed bill and more streamlined body distinguish it from the larger, stouter raven.  They call with loud caws and if captured can be taught to mimic human speech."),
    copy_from = "mon_bird_flying_base",
    volume = "600 ml",
    mass = "450 g",
    color = "dark_gray",
    attacks = { { reference = "EAT_CARRION", cooldown = 40 }, { reference = "EAT_FOOD", cooldown = 120 } },
    reproduction = { offspring = { egg = "egg_crow" }, count = 4, interval = 18 },
    inheritance = { add = { flags = { "EATS" } } },
}

ccb.content.define_monster {
    id = "mon_raven",
    name = ccb.content.plural_text("raven", "ravens"),
    description = ccb.content.text("Slightly smaller than a chicken, this glossy black bird has a heavy beak and dark, sparkly eyes.  It emits a variety of sounds including croaks and a knocking sound."),
    copy_from = "mon_bird_flying_base",
    volume = "1960 ml",
    mass = "1470 g",
    harvest = "bird_small",
    hp = 4,
    color = "dark_gray",
    attacks = { { reference = "EAT_CARRION", cooldown = 40 }, { reference = "EAT_FOOD", cooldown = 120 } },
    reproduction = { offspring = { egg = "egg_raven" }, count = 5, interval = 18 },
    inheritance = { add = { flags = { "EATS" } } },
}

ccb.content.define_monster {
    id = "mon_bluejay",
    name = ccb.content.plural_text("blue jay", "blue jays"),
    description = ccb.content.text("A small, noisy bird with distinctive blue feathers."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "120 ml",
    mass = "90 g",
    color = "light_blue",
    reproduction = { offspring = { egg = "egg_bluejay" }, count = 5, interval = 18 },
}

ccb.content.define_monster {
    id = "mon_cardinal",
    name = ccb.content.plural_text("cardinal", "cardinals"),
    description = ccb.content.text("A small songbird, famous for its distinctive crest and facial markings.  A well-known example of sexual dimorphism, the males are colored much more vibrantly than the females."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "60 ml",
    mass = "45 g",
    color = "red",
    reproduction = { offspring = { egg = "egg_cardinal" }, count = 3, interval = 16 },
}

ccb.content.define_monster {
    id = "mon_robin",
    name = ccb.content.plural_text("American robin", "American robins"),
    description = ccb.content.text("A brown songbird with a reddish-orange breast.  Their eggs are a distinctive shade of blue."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "103 ml",
    mass = "77 g",
    color = "brown",
    reproduction = { offspring = { egg = "egg_robin" }, count = 5, interval = 16 },
}

ccb.content.define_monster {
    id = "mon_sparrow",
    name = ccb.content.plural_text("house sparrow", "house sparrows"),
    description = ccb.content.text("A small bird with brown and gray feathers.  Introduced to North America in the 1850s, it is now one of the most abundant birds in the continent."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "40 ml",
    mass = "30 g",
    reproduction = { offspring = { egg = "egg_sparrow" }, count = 5, interval = 16 },
}

ccb.content.define_monster {
    id = "mon_chickadee",
    name = ccb.content.plural_text("black-capped chickadee", "black-capped chickadees"),
    description = ccb.content.text("A tiny species of tit native to North America, with a distinctive black cap on its head."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "16 ml",
    mass = "12 g",
    reproduction = { offspring = { egg = "egg_chickadee" }, count = 8, interval = 14 },
}

ccb.content.define_monster {
    id = "mon_chickadee_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 28, monster = "mon_chickadee" },
}

ccb.content.define_monster {
    id = "mon_waxwing",
    name = ccb.content.plural_text("cedar waxwing", "cedar waxwings"),
    description = ccb.content.text("A small species of waxwing with a distinctive feathered crest and a black mask pattern on its face."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "40 ml",
    mass = "30 g",
    reproduction = { offspring = { egg = "egg_waxwing" }, count = 5, interval = 16 },
}

ccb.content.define_monster {
    id = "mon_waxwing_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 32, monster = "mon_waxwing" },
}

ccb.content.define_monster {
    id = "mon_duck",
    name = ccb.content.plural_text("mallard", "mallards"),
    description = ccb.content.text("A common species of duck often seen around rivers and other bodies of water.  It feeds primarily on insects, seeds, roots, and, pre-Cataclysm, bread scraps."),
    copy_from = "mon_bird_water_base",
    volume = "1387 ml",
    mass = "1040 g",
    harvest = "bird_small",
    hp = 2,
    color = "brown",
    reproduction = { offspring = { egg = "egg_duck" }, count = 13, interval = 88 },
    mating_seasons = { "SPRING" },
}

-- A year to reach sexual maturity, so lets assume 2/3 of that time to reach roughly adult size.
ccb.content.define_monster {
    id = "mon_duck_chick",
    copy_from = "mon_generic_chick_water",
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    upgrade = { grow_at_age = 240, monster = "mon_duck" },
}

ccb.content.define_monster {
    id = "mon_duck_domestic",
    name = ccb.content.plural_text("domestic duck", "domestic ducks"),
    description = ccb.content.text("A domestic variety of the common mallard sporting while plumage."),
    copy_from = "mon_bird_water_base",
    looks_like = "mon_duck",
    volume = "2400 ml",
    mass = "1800 g",
    harvest = "bird_small",
    hp = 4,
    color = "white",
    reproduction = { offspring = { egg = "egg_duck_domestic" }, count = 8, interval = 14 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

-- 28 weeks to start laying eggs for pekins.
ccb.content.define_monster {
    id = "mon_duck_domestic_chick",
    copy_from = "mon_generic_chick_water",
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    upgrade = { grow_at_age = 196, monster = "mon_duck_domestic" },
}

ccb.content.define_monster {
    id = "mon_goose_canadian",
    name = ccb.content.plural_text("Canada goose", "Canada geese"),
    description = ccb.content.text("A common type of waterfowl that regrets leaving Canada."),
    copy_from = "mon_bird_water_base",
    volume = "5333 ml",
    mass = "4 kg",
    harvest = "bird_small",
    hp = 11,
    aggression = 0,
    morale = 15,
    anger_triggers = { "PLAYER_CLOSE", "FRIEND_ATTACKED" },
    fear_triggers = { "FRIEND_DIED", "FIRE", "HURT" },
    reproduction = { offspring = { egg = "egg_goose_canadian" }, count = 10, interval = 350 },
    mating_seasons = { "SPRING" },
}

-- 3.6-5.4kg for females, 6.8-11kg for males. We don't differentiate genders, so lets take a rough middle ground.
ccb.content.define_monster {
    id = "mon_turkey",
    name = ccb.content.plural_text("wild turkey", "wild turkeys"),
    description = ccb.content.text("A large and colorful game bird native to the forests of North America.  Its head and beak are covered in fleshy protuberances."),
    copy_from = "mon_bird_flying_base",
    volume = "8 L",
    mass = "6 kg",
    harvest = "bird_small",
    hp = 16,
    speed = 140,
    color = "brown",
    reproduction = { offspring = { egg = "egg_turkey" }, count = 17, interval = 151 },
}

ccb.content.define_monster {
    id = "mon_turkey_chick",
    copy_from = "mon_generic_chick",
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    upgrade = { grow_at_age = 300, monster = "mon_turkey" },
}

ccb.content.define_monster {
    id = "mon_turkey_domestic",
    name = ccb.content.plural_text("domestic turkey", "domestic turkeys"),
    description = ccb.content.text("A domesticated relative of the common wild turkey.  Lost most of its colors and the ability to fly, but at least it got bigger!"),
    copy_from = "mon_bird_flightless_base",
    looks_like = "mon_turkey",
    volume = "10667 ml",
    mass = "8 kg",
    harvest = "bird_small",
    hp = 20,
    color = "white",
    reproduction = { offspring = { egg = "egg_turkey_domestic" }, count = 10, interval = 21 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

ccb.content.define_monster {
    id = "mon_turkey_domestic_chick",
    copy_from = "mon_generic_chick",
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    upgrade = { grow_at_age = 300, monster = "mon_turkey_domestic" },
}

-- 0.9kg for females, 1.2kg for males. We don't differentiate genders, so lets take a rough middle ground.
ccb.content.define_monster {
    id = "mon_pheasant",
    name = ccb.content.plural_text("ring-necked pheasant", "ring-necked pheasants"),
    description = ccb.content.text("A medium-sized game bird that can have bright feathers depending on the sex.  Introduced from Asia to New England."),
    copy_from = "mon_bird_flying_base",
    volume = "1467 ml",
    mass = "1100 g",
    harvest = "bird_small",
    hp = 3,
    speed = 140,
    reproduction = { offspring = { egg = "egg_pheasant" }, count = 15, interval = 108 },
    mating_seasons = { "SPRING" },
}

ccb.content.define_monster {
    id = "mon_chicken_chick",
    copy_from = "mon_generic_chick",
    name = ccb.content.plural_text("yellow chick", "yellow chicks"),
    description = ccb.content.text("A tiny yellow and brown chick, it could be from a number of different species."),
    upgrade = { grow_at_age = 56, monster = "mon_chicken" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

ccb.content.define_monster {
    id = "mon_grouse_chick",
    copy_from = "mon_generic_chick",
    upgrade = { grow_at_age = 120, monster = "mon_grouse" },
}

ccb.content.define_monster {
    id = "mon_crow_chick",
    copy_from = "mon_generic_chick",
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    volume = "67 ml",
    mass = "50 g",
    upgrade = { grow_at_age = 144, monster = "mon_crow" },
}

ccb.content.define_monster {
    id = "mon_raven_chick",
    copy_from = "mon_crow_chick",
    upgrade = { grow_at_age = 140, monster = "mon_raven" },
}

ccb.content.define_monster {
    id = "mon_bluejay_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 40, monster = "mon_bluejay" },
}

ccb.content.define_monster {
    id = "mon_cardinal_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 40, monster = "mon_cardinal" },
}

ccb.content.define_monster {
    id = "mon_robin_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 28, monster = "mon_robin" },
}

ccb.content.define_monster {
    id = "mon_sparrow_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 28, monster = "mon_sparrow" },
}

-- A year to reach sexual maturity, but only 80 days to reach independence, so lets get an average from that.
ccb.content.define_monster {
    id = "mon_pheasant_chick",
    copy_from = "mon_generic_chick",
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    upgrade = { grow_at_age = 222, monster = "mon_pheasant" },
}

-- A year to reach independence, 2-3 years to reach sexual maturity, so lets assume 1.5 years to reach full size.
ccb.content.define_monster {
    id = "mon_goose_canadian_chick",
    copy_from = "mon_generic_chick_water",
    upgrade = { grow_at_age = 547, monster = "mon_goose_canadian" },
}

ccb.content.define_monster {
    id = "mon_crow_mutant_small",
    name = ccb.content.plural_text("oversized crow", "oversized crows"),
    description = ccb.content.text("A horrible bird grown three or four times bigger than ought to be possible and sporting a swollen gut that might look comical if it weren't for the razor sharp beak and the madness in its beady eyes."),
    body_type = "bird",
    default_faction = "corvid",
    categories = { "WILDLIFE" },
    species = { "BIRD" },
    volume = "3000 ml",
    mass = "4000 g",
    hp = 8,
    speed = 110,
    materials = { "flesh" },
    symbol = "v",
    color = "dark_gray",
    aggression = 80,
    morale = 90,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 2 } },
    melee_skill = 2,
    dodge = 1,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_flying",
        "prof_wp_basic_bird",
    },
    weakpoint_sets = { "wps_bird_body" },
    harvest = "mutant_bird",
    dissect = "dissect_bird_sample_single",
    fear_triggers = { "PLAYER_CLOSE" },
    attacks = {
        { reference = "SHRIEK", cooldown = 10 },
        { reference = "EAT_CARRION", cooldown = 40 },
        { reference = "EAT_FOOD", cooldown = 120 },
    },
    biosignature = { item = "feces_bird", interval = 8 },
    upgrade = { half_life = 84, monster_group = "GROUP_CROW_MUTANT" },
    flags = { "SEES", "HEARS", "SMELLS", "PATH_AVOID_DANGER", "WARM", "FLIES", "EATS", "SMALL_HIDER" },
}

ccb.content.define_monster {
    id = "mon_crow_mutant",
    name = ccb.content.plural_text("bloated corvid", "bloated corvids"),
    description = ccb.content.text("This may have once been a crow or a raven, but now it's a deformed monstrosity nearly the size of a man.  It heaves its sable bulk awkwardly along the ground, too overfed on carrion to fly."),
    body_type = "bird",
    default_faction = "corvid",
    species = { "MUTANT" },
    difficulty_adjustment = 2,
    volume = "35000 ml",
    mass = "40000 g",
    hp = 35,
    speed = 70,
    materials = { "flesh" },
    symbol = "v",
    color = "dark_gray",
    aggression = 90,
    morale = 105,
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 3 } },
    vision_night = 4,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_basic_bird" },
    weakpoint_sets = { "wps_bird_body" },
    harvest = "mutant_bird_flightless",
    dissect = "dissect_bird_sample_small",
    fear_triggers = { "FIRE" },
    attacks = {
        { reference = "SHRIEK", cooldown = 10 },
        { reference = "LUNGE", cooldown = 8 },
        { cooldown = 10, maximum_range = 3, kind = "leap" },
        { reference = "EAT_CARRION", cooldown = 40 },
        { reference = "EAT_FOOD", cooldown = 120 },
    },
    zombify_into = "mon_meat_cocoon_small",
    flags = { "SEES", "HEARS", "SMELLS", "PATH_AVOID_DANGER", "STUMBLES", "WARM", "EATS" },
}

ccb.content.define_monster {
    id = "mon_pigeon",
    name = ccb.content.plural_text("feral pigeon", "feral pigeons"),
    description = ccb.content.text("A gentle, plump, small-billed bird with a skin saddle, or cere, between its bill and forehead.  On the ground, it struts about with a characteristic bobbing of the head.  It is a strong, swift flier thanks to its long wings and powerful flight muscles."),
    copy_from = "mon_bird_flying_base",
    reproduction = { offspring = { egg = "egg_pigeon" }, count = 3, interval = 32 },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

ccb.content.define_monster {
    id = "mon_pigeon_chick",
    copy_from = "mon_generic_chick",
    upgrade = { grow_at_age = 10, monster = "mon_pigeon" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

ccb.content.define_monster {
    id = "mon_goose",
    name = ccb.content.plural_text("domestic goose", "domestic geese"),
    description = ccb.content.text("A type of waterfowl well known for its loud honking and relatively aggressive behavior."),
    copy_from = "mon_bird_water_base",
    volume = "5 L",
    mass = "3750 g",
    harvest = "bird_small",
    hp = 10,
    looks_like = "mon_goose_canadian",
    aggression = 1,
    morale = 15,
    fear_triggers = { "FRIEND_ATTACKED", "FRIEND_DIED", "FIRE", "HURT" },
    reproduction = { offspring = { egg = "egg_goose" }, count = 15, interval = 35 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

ccb.content.define_monster {
    id = "mon_goose_chick",
    copy_from = "mon_generic_chick_water",
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    upgrade = { grow_at_age = 212, monster = "mon_goose" },
}

ccb.content.define_monster {
    id = "mon_hummingbird",
    name = ccb.content.plural_text("ruby-throated hummingbird", "ruby-throated hummingbirds"),
    description = ccb.content.text("A very small hummingbird of varied colorful feathers.  It flies at incredible speeds while seeking nectar among flowers."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "5 ml",
    mass = "3600 mg",
    color = "light_green",
    reproduction = { offspring = { egg = "egg_hummingbird" }, count = 3, interval = 36 },
    mating_seasons = { "SPRING" },
}

ccb.content.define_monster {
    id = "mon_woodpecker",
    name = ccb.content.plural_text("downy woodpecker", "downy woodpeckers"),
    description = ccb.content.text("A small bird with woody colors and a colored crest on its head.  Well known for its ability to poke holes on trees while looking for grubs."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "35 ml",
    mass = "26 g",
    reproduction = { offspring = { egg = "egg_woodpecker" }, count = 5, interval = 30 },
}

ccb.content.define_monster {
    id = "mon_hummingbird_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 24, monster = "mon_hummingbird" },
}

ccb.content.define_monster {
    id = "mon_woodpecker_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 24, monster = "mon_woodpecker" },
}

ccb.content.define_monster {
    id = "mon_coot",
    name = ccb.content.plural_text("American coot", "American coots"),
    description = ccb.content.text("A bird belonging to the same family as rails.  Its relatives can be found worldwide in freshwater habitats."),
    copy_from = "mon_bird_water_base",
    volume = "733 ml",
    mass = "550 g",
    reproduction = { offspring = { egg = "egg_coot" }, count = 10, interval = 83 },
}

ccb.content.define_monster {
    id = "mon_cormorant",
    name = ccb.content.plural_text("double-crested cormorant", "double-crested cormorants"),
    description = ccb.content.text("An aquatic bird with a long snake-like neck.  While often considered coastal birds, they feel just as at home in freshwater habitats."),
    copy_from = "mon_bird_water_base",
    default_faction = "bird_small_waterfowl_predator",
    volume = "2467 ml",
    mass = "1850 g",
    harvest = "bird_small",
    hp = 5,
    speed = 110,
    reproduction = { offspring = { egg = "egg_cormorant" }, count = 7, interval = 98 },
}

ccb.content.define_monster {
    id = "mon_moorhen",
    name = ccb.content.plural_text("common gallinule", "common gallinules"),
    description = ccb.content.text("A bird belonging to the same family as rails.  A relative of the coot with a distinctive red coloration on its heads and brownish plumage."),
    copy_from = "mon_bird_water_base",
    volume = "511 ml",
    mass = "383 g",
    speed = 110,
    reproduction = { offspring = { egg = "egg_moorhen" }, count = 8, interval = 78 },
}

ccb.content.define_monster {
    id = "mon_grebe",
    name = ccb.content.plural_text("horned grebe", "horned grebes"),
    description = ccb.content.text("A medium-sized aquatic bird with a long neck.  They can be distinguished by their strange leg placement which makes them great at diving."),
    copy_from = "mon_bird_water_base",
    default_faction = "bird_small_waterfowl_predator",
    volume = "580 ml",
    mass = "435 g",
    color = "brown",
    reproduction = { offspring = { egg = "egg_grebe" }, count = 8, interval = 49 },
}

ccb.content.define_monster {
    id = "mon_coot_chick",
    copy_from = "mon_generic_chick_water",
    upgrade = { grow_at_age = 92, monster = "mon_coot" },
}

-- 2 years to reach sexual maturity, but only 10 weeks to reach independence, so lets get an average from that.
ccb.content.define_monster {
    id = "mon_cormorant_chick",
    copy_from = "mon_generic_chick_water",
    upgrade = { grow_at_age = 400, monster = "mon_cormorant" },
}

ccb.content.define_monster {
    id = "mon_moorhen_chick",
    copy_from = "mon_generic_chick_water",
    upgrade = { grow_at_age = 88, monster = "mon_moorhen" },
}

-- A year to reach sexual maturity, so lets assume 2/3 of that time to reach roughly adult size.
ccb.content.define_monster {
    id = "mon_grebe_chick",
    copy_from = "mon_generic_chick_water",
    upgrade = { grow_at_age = 240, monster = "mon_grebe" },
}

-- Seasons taken from other domesticated birds that aren't chickens, egg count based on the fact that most sources claim domestic guineafowl lay ~100 eggs over 9 months (270 days) - this here reaches us 100 eggs over 280 days, so slightly below the estimate.
ccb.content.define_monster {
    id = "mon_guinea_fowl",
    name = ccb.content.plural_text("domestic guineafowl", "domestic guineafowl"),
    description = ccb.content.text("A domestic bird that originated from Africa.  Easily recognizable for the strange helmet on its head and its white-gray plumage."),
    copy_from = "mon_bird_flightless_base",
    volume = "1735 ml",
    mass = "1300 g",
    harvest = "bird_small",
    hp = 3,
    reproduction = { offspring = { egg = "egg_guinea_fowl" }, count = 5, interval = 14 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

-- 16 weeks to develop adult plumage and reach maturity.
ccb.content.define_monster {
    id = "mon_guinea_fowl_chick",
    copy_from = "mon_chicken_chick",
    upgrade = { grow_at_age = 112, monster = "mon_guinea_fowl" },
}
