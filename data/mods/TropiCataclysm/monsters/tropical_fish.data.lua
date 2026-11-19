local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_fish_crab",
    name = ccb.content.plural_text("crab", "crabs"),
    description = ccb.content.text("A crustacean belonging to either Trichodactylidae or Pseudothelphusidae.  Freshwater crabs are widely spread around Central and South America, some even found in mountain streams."),
    default_faction = "fish",
    body_type = "crab",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "300 ml",
    mass = "100 g",
    hp = 3,
    speed = 150,
    materials = { "flesh" },
    symbol = "f",
    color = "red",
    aggression = -50,
    morale = 5,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 1 } },
    harvest = "shellfish",
    dissect = "dissect_gastropod_sample_single",
    reproduction = { offspring = { monster = "mon_crab_manca" }, count = 1, interval = 21 },
    mating_seasons = { "AUTUMN" },
    fear_triggers = { "PLAYER_CLOSE", "SOUND" },
    flags = { "FISHABLE", "SEES", "SMELLS", "SWIMS", "AQUATIC", "WATER_CAMOUFLAGE", "ARTHROPOD_BLOOD" },
}

ccb.content.define_monster {
    id = "mon_crab_manca",
    name = ccb.content.plural_text("baby crab", "baby crabs"),
    description = ccb.content.text("A crab in its larval stage, incredibly fragile and tiny but produced by a truckload of eggs that have been carried by their mother."),
    copy_from = "mon_fish_crab",
    volume = "30 ml",
    mass = "30 g",
    upgrade = { grow_at_age = 15, monster = "mon_fish_crab" },
    inheritance = { scale = { hp = 0.5, speed = 1.1, morale = 0.67, melee_sides = 0.67 } },
}

ccb.content.define_monster {
    id = "mon_fish_pancora",
    copy_from = "mon_fish_crab",
    name = ccb.content.plural_text("pancora crab", "pancora crabs"),
    reproduction = { offspring = { monster = "mon_pancora_manca" }, count = 1, interval = 21 },
    description = ccb.content.text("A crustacean belonging to the Aeglidae family.  They are among the only living freshwater anomurans, being restricted solely to South America."),
}

ccb.content.define_monster {
    id = "mon_pancora_manca",
    name = ccb.content.plural_text("baby pancora crab", "baby pancora crabs"),
    description = ccb.content.text("A pancora crab in its larval stage, incredibly fragile and tiny but produced by a truckload of eggs that have been carried by their mother."),
    copy_from = "mon_fish_pancora",
    volume = "30 ml",
    mass = "30 g",
    upgrade = { grow_at_age = 15, monster = "mon_fish_pancora" },
    inheritance = { scale = { hp = 0.5, speed = 1.1, morale = 0.67, melee_sides = 0.67 } },
}

ccb.content.define_monster {
    id = "mon_shark",
    name = ccb.content.plural_text("bull shark", "bull sharks"),
    description = ccb.content.text("The bull shark is one of the few known species of shark capable of living in both fresh and salty waters.  With the advent of the Cataclysm many of them have migrated up river to exploit the new food sources in the waters."),
    default_faction = "fish",
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 200,
    speed = 120,
    materials = { "flesh" },
    symbol = "^",
    color = "blue_white",
    aggression = 15,
    morale = 60,
    melee_skill = 5,
    melee_dice = 3,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 7 } },
    dodge = 4,
    harvest = "fish_large",
    zombify_into = "mon_zhark",
    reproduction = { offspring = { monster = "mon_shark_pup" }, count = 8, interval = 364 },
    flags = { "SEES", "HEARS", "SMELLS", "KEENNOSE", "WARM", "SWIMS", "AQUATIC", "WATER_CAMOUFLAGE" },
    armor = { bash = 5, cut = 1, bullet = 1 },
}

ccb.content.define_monster {
    id = "mon_shark_pup",
    name = ccb.content.plural_text("bull shark pup", "bull shark pups"),
    description = ccb.content.text("Unlike other fish bull sharks are viviparous and their pups are as well equipped as their parents."),
    copy_from = "mon_shark",
    volume = "1200 ml",
    mass = "800 g",
    fear_triggers = { "PLAYER_CLOSE", "SOUND", "HURT" },
    upgrade = { grow_at_age = 365, monster = "mon_shark" },
    flags = {
        "FISHABLE",
        "SEES",
        "HEARS",
        "SMELLS",
        "KEENNOSE",
        "WARM",
        "SWIMS",
        "AQUATIC",
        "WATER_CAMOUFLAGE",
    },
    inheritance = { scale = { hp = 0.4, speed = 1.1, morale = 0.67, melee_sides = 0.67 } },
}

ccb.content.define_monster {
    id = "mon_fish_lungfish",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("lungfish", "lungfish"),
    reproduction = { offspring = { egg = "egg_lungfish" }, count = 2, interval = 17 },
    description = ccb.content.text("A lungfish.  This strange fish has relatives in both Africa and Australia, all of them can breathe air and some consider them living fossils."),
}

ccb.content.define_monster {
    id = "mon_fry_lungfish",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_lungfish" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_eel_electric",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("electric eel", "electric eels"),
    description = ccb.content.text("An electric eel.  A strange elongated fish known for its ability to use electricity to hunt prey, despite their name they are not actually eels."),
    defense = { id = "ZAPBACK", chance = 100 },
    reproduction = { offspring = { egg = "egg_eel_electric" }, count = 2, interval = 17 },
    flags = { "FISHABLE", "SEES", "SMELLS", "SWIMS", "AQUATIC", "WATER_CAMOUFLAGE", "ELECTRIC" },
}

ccb.content.define_monster {
    id = "mon_fry_eel_electric",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_eel_electric" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_pacu",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("pacu", "pacus"),
    reproduction = { offspring = { egg = "egg_pacu" }, count = 2, interval = 17 },
    description = ccb.content.text("A pacu.  There are several species of these piranha relatives in the rivers of South America, they are usually small to medium size."),
}

ccb.content.define_monster {
    id = "mon_fry_pacu",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_pacu" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_pacu_giant",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("tambaqui", "tambaquis"),
    reproduction = { offspring = { egg = "egg_tambaqui" }, count = 2, interval = 17 },
    description = ccb.content.text("Also known as black or giant pacu.  This is the largest member of the family and the most known worldwide."),
}

ccb.content.define_monster {
    id = "mon_fry_tambaqui",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_pacu_giant" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_piranha",
    name = ccb.content.plural_text("piranha", "piranhas"),
    description = ccb.content.text("A small to medium fish with a wide diet.  Contrary to popular belief these fish are not vicious predators and instead react to the availability of food in their environment."),
    default_faction = "fish",
    body_type = "fish",
    species = { "FISH" },
    volume = "3200 ml",
    mass = "3200 g",
    hp = 15,
    speed = 180,
    materials = { "flesh" },
    symbol = "t",
    color = "light_green",
    aggression = 15,
    morale = 60,
    melee_skill = 6,
    melee_dice = 1,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 4 } },
    dodge = 6,
    vision_day = 1,
    vision_night = 30,
    harvest = "fish_small",
    reproduction = { offspring = { egg = "egg_piranha" }, count = 2, interval = 17 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN", "WINTER" },
    pathing = { max_distance = 5 },
    flags = { "FISHABLE", "SEES", "SMELLS", "SWIMS", "AQUATIC", "WATER_CAMOUFLAGE" },
}

ccb.content.define_monster {
    id = "mon_fry_piranha",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_piranha" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_arowana",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("arowana", "arowanas"),
    reproduction = { offspring = { egg = "egg_arowana" }, count = 2, interval = 17 },
    description = ccb.content.text("A member of the Osteoglossidade family.  These fish can be found on South America, Asia and Australia."),
}

ccb.content.define_monster {
    id = "mon_fry_arowana",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_arowana" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_arapaima",
    copy_from = "mon_fish_huge",
    name = ccb.content.plural_text("arapaima", "arapaimas"),
    reproduction = { offspring = { egg = "egg_arapaima" }, count = 2, interval = 17 },
    description = ccb.content.text("A member of the Arapaimidae family.  These fish can be found on South America and Africa, some species can grow to truly huge sizes."),
}

ccb.content.define_monster {
    id = "mon_fry_arapaima",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_arapaima" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_piraiba",
    copy_from = "mon_fish_huge",
    name = ccb.content.plural_text("piraiba", "piraibas"),
    reproduction = { offspring = { egg = "egg_piraiba" }, count = 2, interval = 17 },
    description = ccb.content.text("A huge species of South American catfish native to the Amazon and Orinoco rivers, they can reach almost 3 meters in length."),
}

ccb.content.define_monster {
    id = "mon_fry_piraiba",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_piraiba" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_pleco",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("pleco", "plecos"),
    reproduction = { offspring = { egg = "egg_pleco" }, count = 2, interval = 17 },
    description = ccb.content.text("A catfish species native to South America, Panama and even Costa Rica.  They are distinguished by their bony spines and suction adapted mouths."),
}

ccb.content.define_monster {
    id = "mon_fry_pleco",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_pleco" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_stingray",
    name = ccb.content.plural_text("river stingray", "river stingray"),
    description = ccb.content.text("A fish of the Potamotrygonidae family.  These freshwater stingrays are found mostly in South America with a few bred in other parts of the world."),
    default_faction = "fish",
    body_type = "fish",
    categories = { "WILDLIFE" },
    species = { "FISH" },
    volume = "2 L",
    mass = "1500 g",
    hp = 6,
    speed = 150,
    dodge = 8,
    materials = { "flesh" },
    symbol = "f",
    color = "white",
    aggression = -50,
    morale = 60,
    melee_skill = 5,
    melee_dice = 1,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 4 } },
    anger_triggers = { "HURT", "PLAYER_CLOSE" },
    fear_triggers = { "PLAYER_CLOSE" },
    placate_triggers = { "PLAYER_WEAK" },
    reproduction = { offspring = { monster = "mon_fry_stingray" }, count = 8, interval = 364 },
    harvest = "fish_small",
    dissect = "dissect_fish_sample_single",
    flags = { "FISHABLE", "SEES", "SMELLS", "SWIMS", "AQUATIC", "WATER_CAMOUFLAGE", "BADVENOM" },
}

ccb.content.define_monster {
    id = "mon_fry_stingray",
    name = ccb.content.plural_text("stingray fry", "stingray fries"),
    copy_from = "mon_fish_stingray",
    description = ccb.content.text("A baby stingray.  Like many other cartilaginous fish, river stingrays are ovoviviparous and carry the eggs until the fries are ready to get out in to the world."),
    volume = "10 ml",
    mass = "1 g",
    upgrade = { half_life = 56, monster = "mon_fish_stingray" },
    inheritance = { scale = { hp = 0.4, speed = 1.1, morale = 0.67, melee_sides = 0.67 } },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s is smashed to non-recognizable pieces."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_fish_gar",
    copy_from = "mon_fish_huge",
    name = ccb.content.plural_text("gar", "gars"),
    reproduction = { offspring = { egg = "egg_gar" }, count = 2, interval = 17 },
    description = ccb.content.text("A fish belonging to the Lepisosteidae family.  These enormous fish can be found from North America to the Caribbean and are well known for their prehistoric appearance."),
}

ccb.content.define_monster {
    id = "mon_fry_gar",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_gar" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_tucunare",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("tucunaré", "tucunarés"),
    reproduction = { offspring = { egg = "egg_tucunare" }, count = 2, interval = 17 },
    description = ccb.content.text("A vicious predatory cichlid found along the northern tributaries of South America from Panama to the Amazon.  Very sought among sport fishing enthusiasts."),
}

ccb.content.define_monster {
    id = "mon_fry_tucunare",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_tucunare" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_discus",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("discus", "discuses"),
    reproduction = { offspring = { egg = "egg_discus" }, count = 2, interval = 17 },
    description = ccb.content.text("A round and colorful genus of fish native to the Amazon river basin.  Very popular in aquariums but expensive to maintain in captivity."),
}

ccb.content.define_monster {
    id = "mon_fry_discus",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_discus" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_angelfish",
    copy_from = "mon_fish_tiny",
    name = ccb.content.plural_text("angelfish", "angelfish"),
    reproduction = { offspring = { egg = "egg_angelfish" }, count = 2, interval = 17 },
    description = ccb.content.text("A genus of freshwater fish with a triangular shape native to South America.  Unrelated to the marine angel fish and known to be semi-aggressive in captivity."),
}

ccb.content.define_monster {
    id = "mon_fry_angelfish",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_angelfish" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_koi",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("koi", "koi"),
    reproduction = { offspring = { egg = "egg_koi" }, count = 2, interval = 17 },
    description = ccb.content.text("A domestic variant of the Amur carp originally bred in Japan for its color variations.  These fish are known to devolve quickly to feral status if left to escape."),
}

ccb.content.define_monster {
    id = "mon_fry_koi",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_koi" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_tilapia",
    copy_from = "mon_fish_medium",
    name = ccb.content.plural_text("tilapia", "tilapias"),
    reproduction = { offspring = { egg = "egg_tilapia" }, count = 2, interval = 17 },
    description = ccb.content.text("A genus of cichlids native to Africa but bred worldwide for food.  They are adaptable herbivorous fish that can survive well even in salt water."),
}

ccb.content.define_monster {
    id = "mon_fry_tilapia",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_tilapia" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_sabalo",
    copy_from = "mon_fish_large",
    name = ccb.content.plural_text("sabalo", "sabalos"),
    reproduction = { offspring = { egg = "egg_sabalo" }, count = 2, interval = 17 },
    description = ccb.content.text("A fish belonging to the Prochilodontidae family.  They are native to South America and most species can be found feeding on detritus."),
}

ccb.content.define_monster {
    id = "mon_fry_sabalo",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_sabalo" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_oscar",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("oscar", "oscars"),
    reproduction = { offspring = { egg = "egg_oscar" }, count = 2, interval = 17 },
    description = ccb.content.text("A species of omnivorous cichlid native to South America.  Quite popular in aquariums with several different colored breeds."),
}

ccb.content.define_monster {
    id = "mon_fry_oscar",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_oscar" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_guapote",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("guapote", "guapotes"),
    reproduction = { offspring = { egg = "egg_guapote" }, count = 2, interval = 17 },
    description = ccb.content.text("A genus of cichlids found in Central America.  All of the species are predatory with different coloration and sizes."),
}

ccb.content.define_monster {
    id = "mon_fry_guapote",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_guapote" },
    name = ccb.content.plural_text("fry", "fry"),
}

ccb.content.define_monster {
    id = "mon_fish_mayaheros",
    copy_from = "mon_fish_small",
    name = ccb.content.plural_text("mayaheros", "mayaheri"),
    reproduction = { offspring = { egg = "egg_mayaheros" }, count = 2, interval = 17 },
    description = ccb.content.text("A genus of adaptable cichlids native to Central America.  They can survive in marine environments with some populations even reaching Florida."),
}

ccb.content.define_monster {
    id = "mon_fry_mayaheros",
    copy_from = "mon_fry",
    upgrade = { half_life = 56, monster = "mon_fish_mayaheros" },
    name = ccb.content.plural_text("fry", "fry"),
}
