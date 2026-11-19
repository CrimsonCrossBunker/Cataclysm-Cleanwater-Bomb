local ccb = require("ccb")

-- Clutch sizes are higher, but those are clutch sizes for nests, and nests can contain eggs from multiple females.
ccb.content.define_monster {
    id = "mon_rhea",
    name = ccb.content.plural_text("greater rhea", "greater rheas"),
    description = ccb.content.text("A distant relative of emus and African ostriches.  Found in the grasslands and various other open regions of South America."),
    copy_from = "mon_bird_flightless_base",
    default_faction = "herbivore",
    volume = "42670 ml",
    mass = "32 kg",
    hp = 50,
    speed = 150,
    materials = { "flesh" },
    symbol = "R",
    color = "brown",
    aggression = 0,
    morale = 40,
    melee_dice = 3,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 4 } },
    dodge = 2,
    harvest = "bird_large",
    dissect = "dissect_bird_sample_small",
    anger_triggers = { "PLAYER_NEAR_BABY" },
    reproduction = { offspring = { egg = "egg_rhea" }, count = 10, interval = 40 },
    mating_seasons = { "SUMMER", "AUTUMN" },
    inheritance = { remove = { flags = { "SWARMS", "SMALL_HIDER" } } },
}

-- Sources say day-1 hatchlings weigh around 75% of their egg mass.
-- 6 months to reach adult size.
ccb.content.define_monster {
    id = "mon_rhea_chick",
    copy_from = "mon_generic_chick",
    name = ccb.content.plural_text("greater rhea chick", "greater rhea chicks"),
    description = ccb.content.text("A miniature rhea.  The appearance of it is distinct enough to easily identify."),
    volume = "600 ml",
    mass = "450 g",
    upgrade = { grow_at_age = 180, monster = "mon_rhea" },
}

ccb.content.define_monster {
    id = "mon_toucan",
    name = ccb.content.plural_text("toco toucan", "toco toucans"),
    description = ccb.content.text("The largest species of toucan sporting dark plumage and a bright colored beak.  This bird can be found pretty much all over South America, feeding on fruits and seeds."),
    copy_from = "mon_bird_flying_base",
    volume = "867 ml",
    mass = "650 g",
    color = "brown",
    reproduction = { offspring = { egg = "egg_toucan" }, count = 4, interval = 63 },
}

-- Copied from the vanilla corvids. ~8 weeks to fledge, but couldn't find any info on how long it takes for them to reach adult size. Sexual maturity is a bad metric as they reach it very late, at 3-4 years of age.
ccb.content.define_monster {
    id = "mon_toucan_chick",
    copy_from = "mon_generic_chick",
    upgrade = { grow_at_age = 144, monster = "mon_toucan" },
}

ccb.content.define_monster {
    id = "mon_parrot",
    name = ccb.content.plural_text("white-eyed parakeet", "white-eyed parakeets"),
    description = ccb.content.text("A small bird with bright green-colored plumage and a short hooked beak.  This species is widespread throughout all of South America, on top of being quite intelligent and sometimes kept as pets."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "220 ml",
    mass = "165 g",
    color = "light_green",
    reproduction = { offspring = { egg = "egg_parrot" }, count = 3, interval = 38 },
}

-- 12 days to reach independence. Use a multiplier of 4 to our advantage to get a rough estimate of reaching adult size.
ccb.content.define_monster {
    id = "mon_parrot_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 48, monster = "mon_parrot" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

ccb.content.define_monster {
    id = "mon_macaw",
    name = ccb.content.plural_text("blue-and-yellow macaw", "blue-and-yellow macaws"),
    description = ccb.content.text("A large parrot sporting beautiful blue plumage.  Intelligent and often kept as a pet."),
    copy_from = "mon_bird_flying_base",
    volume = "1800 ml",
    mass = "1350 g",
    hp = 3,
    color = "light_blue",
    reproduction = { offspring = { egg = "egg_macaw" }, count = 3, interval = 116 },
}

-- 3 months to reach independence.
ccb.content.define_monster {
    id = "mon_macaw_chick",
    copy_from = "mon_generic_chick",
    upgrade = { grow_at_age = 90, monster = "mon_macaw" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

-- Values for reproduction and chick growth copied from the cedar waxwing, as no info could be found online.
ccb.content.define_monster {
    id = "mon_finch_saffron",
    name = ccb.content.plural_text("saffron finch", "saffron finches"),
    description = ccb.content.text("A tiny, golden bird bopping around in the canopy of trees.  Its cone-shaped bill tells you it s a seed eater."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    color = "yellow",
    volume = "27 ml",
    mass = "20 g",
    reproduction = { offspring = { egg = "egg_finch_saffron" }, count = 5, interval = 16 },
}

ccb.content.define_monster {
    id = "mon_finch_saffron_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 32, monster = "mon_finch_saffron" },
}

-- Values for reproduction and chick growth copied from the bluejay, as no info could be found online.
ccb.content.define_monster {
    id = "mon_great_kiskadee",
    name = ccb.content.plural_text("great kiskadee", "great kiskadees"),
    description = ccb.content.text("This large flycatcher has a black crown, prominent white eye stripe and a dominantly yellow body.  At almost a foot long, it swoops up a variety of flying insects."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    color = "yellow",
    volume = "80 ml",
    mass = "60 g",
    reproduction = { offspring = { egg = "egg_great_kiskadee" }, count = 5, interval = 18 },
}

ccb.content.define_monster {
    id = "mon_great_kiskadee_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 40, monster = "mon_great_kiskadee" },
}

ccb.content.define_monster {
    id = "mon_rufous_hornero",
    name = ccb.content.plural_text("rufous hornero", "rufous horneros"),
    description = ccb.content.text("A drab, robin-sized ground bird with startling red eyes.  More often spotted are their odd oven shaped nests."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "60 ml",
    mass = "45 g",
    reproduction = { offspring = { egg = "egg_rufous_hornero" }, count = 4, interval = 44 },
}

ccb.content.define_monster {
    id = "mon_rufous_hornero_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 40, monster = "mon_rufous_hornero" },
}

-- 4 broods a year, and we're assuming they're breeding only for half a year. Clutch sizes per nest can reach 16 eggs, but these can be eggs from up to 4 females, so we're taking an average.
ccb.content.define_monster {
    id = "mon_tinamou",
    name = ccb.content.plural_text("small-billed tinamou", "small-billed tinamous"),
    description = ccb.content.text("One of several species of tinamous present in Brazil.  Although these birds converged into shapes similar to domestic fowl, they are more closely related to the extinct moas, though unlike them, tinamous are capable of flight."),
    copy_from = "mon_bird_flying_base",
    default_faction = "bird_tiny_flying",
    volume = "135 ml",
    mass = "100 g",
    reproduction = { offspring = { egg = "egg_tinamou" }, count = 4, interval = 45 },
}

-- 3 weeks to reach independence.
ccb.content.define_monster {
    id = "mon_tinamou_chick",
    copy_from = "mon_generic_chick_tiny",
    upgrade = { grow_at_age = 21, monster = "mon_tinamou" },
}

-- 2-3 eggs. 30 days of incubation + 4-5 months for the chick to reach adult plumage.
ccb.content.define_monster {
    id = "mon_seriema",
    name = ccb.content.plural_text("red-legged seriema", "red-legged seriemas"),
    description = ccb.content.text("A medium sized bird with long legs and a small crest.  It lives on the grasslands of South America and is considered the only living relative of the extinct terror birds."),
    copy_from = "mon_bird_flightless_base",
    volume = "2467 ml",
    mass = "1850 g",
    hp = 5,
    speed = 180,
    symbol = "s",
    color = "brown",
    harvest = "bird_small",
    vision_day = 50,
    reproduction = { offspring = { egg = "egg_seriema" }, count = 3, interval = 150 },
}

-- 4-5 months to reach adult plumage.
ccb.content.define_monster {
    id = "mon_seriema_chick",
    copy_from = "mon_generic_chick",
    upgrade = { grow_at_age = 120, monster = "mon_seriema" },
}

-- 2-4 eggs per clutch. No info I could get on anything else for this species so we're going with plain chachalacas' values instead.
ccb.content.define_monster {
    id = "mon_chachalaca",
    name = ccb.content.plural_text("Chaco chachalaca", "Chaco chachalacas"),
    description = ccb.content.text("Though its face looks oddly like a chicken's, complete with red wattle, this tan bird sounds nothing like one as it lets out raucous cries of 'chata-ra-ta.'"),
    copy_from = "mon_bird_flying_base",
    volume = "767 ml",
    mass = "575 g",
    color = "brown",
    reproduction = { offspring = { egg = "egg_chachalaca" }, count = 4, interval = 175 },
}

-- Nothing about this species specifically, but plain chachalacas' breed between March and September with chicks staying with their parents until October -> we're taking an average of about 5 months to reach independence.
ccb.content.define_monster {
    id = "mon_chachalaca_chick",
    copy_from = "mon_generic_chick",
    upgrade = { grow_at_age = 150, monster = "mon_chachalaca" },
}

ccb.content.define_monster {
    id = "mon_guan",
    name = ccb.content.plural_text("dusky-legged guan", "dusky-legged guans"),
    description = ccb.content.text("A medium-sized speckled bird.  Its bright orange wattle contrasts sharply with the rest of its brown body."),
    copy_from = "mon_bird_flying_base",
    volume = "1600 ml",
    mass = "1200 g",
    hp = 3,
    harvest = "bird_small",
    reproduction = { offspring = { egg = "egg_guan" }, count = 2, interval = 208 },
}

-- Some sources say 6-8 months to reach independence for most guan chicks (others say 2 years, who do I trust?)
ccb.content.define_monster {
    id = "mon_guan_chick",
    copy_from = "mon_generic_chick",
    upgrade = { grow_at_age = 180, monster = "mon_guan" },
}

ccb.content.define_monster {
    id = "mon_curassow",
    name = ccb.content.plural_text("bare-faced curassow", "bare-faced curassows"),
    description = ccb.content.text("This black bird carries itself oddly proudly, despite the ridiculous mohawk-like fringe on the top of its head."),
    copy_from = "mon_bird_flying_base",
    volume = "2667 ml",
    mass = "2 kg",
    hp = 5,
    harvest = "bird_small",
    reproduction = { offspring = { egg = "egg_curassow" }, count = 2, interval = 395 },
}

ccb.content.define_monster {
    id = "mon_curassow_chick",
    copy_from = "mon_generic_chick",
    upgrade = { grow_at_age = 365, monster = "mon_curassow" },
}
