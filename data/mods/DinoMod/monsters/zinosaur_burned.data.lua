local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zilophosaurus_scorched",
    name = ccb.content.plural_text("scorched dilophosaurus zombie", "scorched dilophosaurus zombies"),
    copy_from = "mon_zallimimus_scorched",
    looks_like = "mon_zilophosaurus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    volume = "400 L",
    mass = "400 kg",
    speed = 65,
    attack_cost = 65,
    melee_skill = 2,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 2 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 60,
    fungalize_into = "mon_zilophosaurus_fungus",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 35,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "STUMBLES", "POISON", "GRABS", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 6, cut = 13, acid = 3, heat = 15, bullet = 9 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeratosaurus_scorched",
    name = ccb.content.plural_text("scorched ceratosaurus zombie", "scorched ceratosaurus zombies"),
    copy_from = "mon_zilophosaurus_scorched",
    looks_like = "mon_ceratosaurus",
    volume = "540 L",
    mass = "540 kg",
    speed = 55,
    attack_cost = 55,
    hp = 70,
    fungalize_into = "mon_zeratosaurus_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell studded with bony spikes."),
    armor = { bash = 6, acid = 3, heat = 15, bullet = 9, cut = 14 },
}

-- When large volumes are fixed this should be 15000 L
ccb.content.define_monster {
    id = "mon_zpinosaurus_scorched",
    name = ccb.content.plural_text("scorched spinosaurus zombie", "scorched spinosaurus zombies"),
    looks_like = "mon_spinosaurus",
    description = ccb.content.text("A heavily-burned zombie dinosaur predator with a row of blackened bone spikes along its spine; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "1000 L",
    mass = "15000 kg",
    body_type = "elephant",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 35,
    attack_cost = 35,
    melee_skill = 2,
    melee_dice = 4,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 4 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 215,
    fungalize_into = "mon_zpinosaurus_fungus",
    vision_night = 3,
    harvest = "zed_dino_leather",
    dissect = "dissect_dino_large_pred",
    categories = { "DINOSAUR" },
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 50,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    flags = {
        "SEES", "HEARS", "STUMBLES", "GRABS", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 8, cut = 17, acid = 3, heat = 15, bullet = 7 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zorvosaurus_scorched",
    name = ccb.content.plural_text("scorched torvosaurus zombie", "scorched torvosaurus zombies"),
    copy_from = "mon_zpinosaurus_scorched",
    looks_like = "mon_torvosaurus",
    description = ccb.content.text("A heavily-burned zombie dinosaur predator with a large head and long, sharp teeth; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    body_type = "ostrich",
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 12 } },
    hp = 130,
    fungalize_into = "mon_zorvosaurus_fungus",
    color = "i_brown",
    armor = { acid = 3, heat = 15, bash = 6, cut = 12, bullet = 9 },
}

ccb.content.define_monster {
    id = "mon_zallosaurus_scorched",
    name = ccb.content.plural_text("scorched allosaurus zombie", "scorched allosaurus zombies"),
    copy_from = "mon_zyrannosaurus_scorched",
    looks_like = "mon_zallosaurus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    speed = 75,
    attack_cost = 75,
    melee_dice = 2,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 2 } },
    hp = 95,
    fungalize_into = "mon_zallosaurus_fungus",
    armor = { acid = 3, heat = 15, bash = 6, cut = 13, bullet = 9 },
}

ccb.content.define_monster {
    id = "mon_zacrocanthosaurus_scorched",
    name = ccb.content.plural_text("scorched acrocanthosaurus zombie", "scorched acrocanthosaurus zombies"),
    copy_from = "mon_zallosaurus_scorched",
    looks_like = "mon_zacrocanthosaurus",
    speed = 50,
    attack_cost = 50,
    melee_dice = 4,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 4 } },
    hp = 135,
    fungalize_into = "mon_zacrocanthosaurus_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, cut = 13, bullet = 9, bash = 13 },
}

ccb.content.define_monster {
    id = "mon_ziganotosaurus_scorched",
    name = ccb.content.plural_text("scorched acrocanthosaurus zombie", "scorched acrocanthosaurus zombies"),
    copy_from = "mon_zallosaurus_scorched",
    looks_like = "mon_ziganotosaurus",
    speed = 90,
    attack_cost = 90,
    melee_dice = 4,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 4 } },
    hp = 350,
    fungalize_into = "mon_ziganotosaurus_fungus",
    armor = { acid = 3, heat = 15, cut = 13, bullet = 9, bash = 6 },
}

ccb.content.define_monster {
    id = "mon_ziats_scorched",
    name = ccb.content.plural_text("scorched siats zombie", "scorched siats zombies"),
    copy_from = "mon_zacrocanthosaurus_scorched",
    looks_like = "mon_ziats",
    melee_dice = 2,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 2 } },
    hp = 180,
    fungalize_into = "mon_ziats_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator with long claws that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, cut = 13, bullet = 9, bash = 6 },
}

ccb.content.define_monster {
    id = "mon_zryptosaurus_scorched",
    name = ccb.content.plural_text("scorched dryptosaurus zombie", "scorched dryptosaurus zombies"),
    copy_from = "mon_zappalachiosaurus_scorched",
    looks_like = "mon_zryptosaurus",
    hp = 100,
    fungalize_into = "mon_zryptosaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zanotyrannus_scorched",
    name = ccb.content.plural_text("scorched nanotyrannus zombie", "scorched nanotyrannus zombies"),
    copy_from = "mon_zappalachiosaurus_scorched",
    looks_like = "mon_zanotyrannus",
    hp = 90,
    fungalize_into = "mon_zanotyrannus_fungus",
}

ccb.content.define_monster {
    id = "mon_zappalachiosaurus_scorched",
    name = ccb.content.plural_text("scorched appalachiosaurus zombie", "scorched appalachiosaurus zombies"),
    copy_from = "mon_zorgosaurus_scorched",
    looks_like = "mon_zappalachiosaurus",
    speed = 85,
    attack_cost = 85,
    melee_damage = { { type = "cut", amount = 14 } },
    hp = 110,
    fungalize_into = "mon_zappalachiosaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zorgosaurus_scorched",
    name = ccb.content.plural_text("scorched gorgosaurus zombie", "scorched gorgosaurus zombies"),
    copy_from = "mon_zalbertosaurus_scorched",
    looks_like = "mon_zorgosaurus",
    speed = 40,
    attack_cost = 40,
    melee_damage = { { type = "cut", amount = 13 } },
    hp = 125,
    fungalize_into = "mon_zorgosaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zalbertosaurus_scorched",
    name = ccb.content.plural_text("scorched albertosaurus zombie", "scorched albertosaurus zombies"),
    copy_from = "mon_zyrannosaurus_scorched",
    looks_like = "mon_zalbertosaurus",
    melee_dice = 3,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 14 } },
    hp = 135,
    fungalize_into = "mon_zalbertosaurus_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 7, cut = 12, bullet = 10 },
}

ccb.content.define_monster {
    id = "mon_zianzhousaurus_scorched",
    name = ccb.content.plural_text("scorched qianzhousaurus zombie", "scorched qianzhousaurus zombies"),
    copy_from = "mon_zanuqsaurus_scorched",
    looks_like = "mon_zianzhousaurus",
    volume = "550 L",
    mass = "770 kg",
    speed = 50,
    attack_cost = 50,
    melee_dice = 3,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 13 } },
    hp = 80,
    fungalize_into = "mon_zianzhousaurus_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 7, cut = 14, bullet = 10 },
}

ccb.content.define_monster {
    id = "mon_zanuqsaurus_scorched",
    name = ccb.content.plural_text("scorched nanuqsaurus zombie", "scorched nanuqsaurus zombies"),
    copy_from = "mon_zaspletosaurus_scorched",
    looks_like = "mon_zanuqsaurus",
    color = "white",
    hp = 135,
    fungalize_into = "mon_zanuqsaurus_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a pale leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zaspletosaurus_scorched",
    name = ccb.content.plural_text("scorched daspletosaurus zombie", "scorched daspletosaurus zombies"),
    copy_from = "mon_zyrannosaurus_scorched",
    looks_like = "mon_zaspletosaurus",
    melee_dice = 4,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 4 } },
    hp = 150,
    fungalize_into = "mon_zaspletosaurus_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

-- When large volumes are fixed this should be 2000 L
ccb.content.define_monster {
    id = "mon_zyrannosaurus_scorched",
    name = ccb.content.plural_text("scorched tyrannosaurus zombie", "scorched tyrannosaurus zombies"),
    looks_like = "mon_zyrannosaurus",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "1000 L",
    mass = "2000 kg",
    body_type = "ostrich",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 35,
    attack_cost = 35,
    melee_skill = 3,
    melee_dice = 5,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 10 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_lg_theropod_body" },
    hp = 200,
    fungalize_into = "mon_zyrannosaurus_fungus",
    vision_night = 3,
    dissect = "dissect_dino_large_pred",
    categories = { "DINOSAUR" },
    description = ccb.content.text("Enormous heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 50,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "GRABS", "STUMBLES", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY", "PET_MOUNTABLE",
    },
    armor = { bash = 8, cut = 17, acid = 3, heat = 15, bullet = 7 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zedcolbertia_scorched",
    name = ccb.content.plural_text("scorched nedcolbertia zombie", "scorched nedcolbertia zombies"),
    looks_like = "mon_zallimimus",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "50 L",
    mass = "50 kg",
    body_type = "ostrich",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 120,
    attack_cost = 120,
    melee_skill = 1,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 2 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 60,
    fungalize_into = "mon_zallimimus_fungus",
    vision_night = 3,
    categories = { "DINOSAUR" },
    description = ccb.content.text("A heavily-burned zombie dinosaur looking a bit like an overcooked ostrich - it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 35,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "GRABS", "STUMBLES", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY", "PET_MOUNTABLE",
    },
    armor = { bash = 4, cut = 13, acid = 3, heat = 15, bullet = 9 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zallimimus_scorched",
    name = ccb.content.plural_text("scorched gallimimus zombie", "scorched gallimimus zombie"),
    copy_from = "mon_zedcolbertia_scorched",
    fungalize_into = "mon_zallimimus_fungus",
    volume = "440 L",
    mass = "440 kg",
    speed = 115,
    attack_cost = 115,
}

ccb.content.define_monster {
    id = "mon_ztruthiomimus_scorched",
    name = ccb.content.plural_text("scorched struthiomimus zombie", "scorched struthiomimus zombie"),
    copy_from = "mon_zallimimus_scorched",
    fungalize_into = "mon_ztruthiomimus_fungus",
    volume = "420 L",
    mass = "420 kg",
    speed = 125,
    attack_cost = 125,
}

ccb.content.define_monster {
    id = "mon_zornithomimus_scorched",
    name = ccb.content.plural_text("scorched ornithomimus zombie", "scorched ornithomimus zombie"),
    copy_from = "mon_zallimimus_scorched",
    fungalize_into = "mon_zornithomimus_fungus",
    volume = "170 L",
    mass = "170 kg",
    speed = 115,
    attack_cost = 115,
    inheritance = { add = { flags = { "CLIMBS" } } },
}

ccb.content.define_monster {
    id = "mon_zalcarius_scorched",
    name = ccb.content.plural_text("scorched falcarius zombie", "scorched falcarius zombies"),
    copy_from = "mon_zeinonychus_scorched",
    looks_like = "mon_zalcarius",
    volume = "100 L",
    mass = "100 kg",
    speed = 70,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 5,
    hp = 120,
    fungalize_into = "mon_zalcarius_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with long blackened claws; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { bash = 6, cut = 13, bullet = 9 },
}

-- When large volumes are fixed this should be 4000 L
ccb.content.define_monster {
    id = "mon_zerizinosaurus_scorched",
    name = ccb.content.plural_text("scorched therizinosaurus zombie", "scorched therizinosaurus zombies"),
    copy_from = "mon_zalcarius_scorched",
    looks_like = "mon_zerizinosaurus",
    volume = "1000 L",
    mass = "4000 kg",
    speed = 100,
    melee_dice = 4,
    hp = 280,
    fungalize_into = "mon_zerizinosaurus_fungus",
    description = ccb.content.text("A large heavily-burned zombie dinosaur with long blackened claws; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zothronychus_scorched",
    name = ccb.content.plural_text("scorched nothronychus zombie", "scorched nothronychus zombies"),
    copy_from = "mon_zalcarius_scorched",
    looks_like = "mon_zothronychus",
    volume = "800 L",
    mass = "800 kg",
    speed = 40,
    attack_cost = 40,
    melee_dice = 4,
    melee_sides = 3,
    hp = 80,
    fungalize_into = "mon_zothronychus_fungus",
    description = ccb.content.text("A large heavily-burned zombie dinosaur with sharp, curved claws; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zanzu_scorched",
    name = ccb.content.plural_text("scorched anzu zombie", "scorched anzu zombies"),
    copy_from = "mon_zalcarius_scorched",
    looks_like = "mon_zanzu",
    volume = "250 L",
    mass = "250 kg",
    speed = 85,
    attack_cost = 85,
    melee_dice = 4,
    melee_sides = 3,
    hp = 60,
    fungalize_into = "mon_zanzu_fungus",
    description = ccb.content.text("A large heavily-burned zombie dinosaur with long claws; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zeinonychus_scorched",
    name = ccb.content.plural_text("scorched deinonychus zombie", "scorched deinonychus zombies"),
    looks_like = "mon_zeinonychus",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "70 L",
    mass = "70 kg",
    body_type = "ostrich",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 55,
    attack_cost = 55,
    melee_skill = 3,
    melee_dice = 1,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 4 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 20,
    fungalize_into = "mon_zeinonychus_fungus",
    vision_night = 10,
    categories = { "DINOSAUR" },
    description = ccb.content.text("Heavily-burned zombie dinosaur predator that still reeks of charred meat.  Its flesh has mended into a leathery shell.  Both feet brandish a large sickle-like claw."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 20,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "GRABS", "STUMBLES", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 4, cut = 13, acid = 3, heat = 15, bullet = 9 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zutahraptor_scorched",
    name = ccb.content.plural_text("scorched utahraptor zombie", "scorched utahraptor zombies"),
    copy_from = "mon_zeinonychus_scorched",
    looks_like = "mon_zutahraptor",
    volume = "500 L",
    mass = "500 kg",
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 8 } },
    hp = 65,
    fungalize_into = "mon_zutahraptor_fungus",
    armor = { cut = 13, acid = 3, heat = 15, bullet = 9, bash = 5 },
}

ccb.content.define_monster {
    id = "mon_zarahsaurus_scorched",
    name = ccb.content.plural_text("scorched sarahsaurus zombie", "scorched sarahsaurus zombies"),
    copy_from = "mon_zissi_scorched",
    looks_like = "mon_zarahsaurus",
    volume = "200 L",
    mass = "200 kg",
    hp = 90,
    fungalize_into = "mon_zarahsaurus_fungus",
    description = ccb.content.text("Heavily-burned two-legged zombie dinosaur sauropod that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zanchisaurus_scorched",
    name = ccb.content.plural_text("scorched anchisaurus zombie", "scorched anchisaurus zombies"),
    copy_from = "mon_zissi_scorched",
    looks_like = "mon_zanchisaurus",
    melee_sides = 4,
    melee_damage = { { type = "bash", amount = 1 } },
    hp = 30,
    fungalize_into = "mon_zanchisaurus_fungus",
    description = ccb.content.text("Heavily-burned four-legged zombie dinosaur sauropod that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zissi_scorched",
    name = ccb.content.plural_text("scorched issi zombie", "scorched issi zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zissi",
    speed = 45,
    attack_cost = 45,
    melee_sides = 6,
    melee_damage = { { type = "bash", amount = 4 } },
    hp = 90,
    fungalize_into = "mon_zissi_fungus",
    attacks = {
        { id = "bite_grab", cooldown = 20 },
        { reference = "scratch", cooldown = 10 },
        { id = "stomp_DinoMod", cooldown = 20, damage = { { type = "bash", amount = 12 } } },
    },
    description = ccb.content.text("Heavily-burned two-legged zombie dinosaur sauropod that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "white",
}

ccb.content.define_monster {
    id = "mon_zoabosaurus_scorched",
    name = ccb.content.plural_text("scorched moabosaurus zombie", "scorched moabosaurus zombies"),
    copy_from = "mon_zamarasaurus_scorched",
    looks_like = "mon_zoabosaurus",
    fungalize_into = "mon_zoabosaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zaplocanthosaurus_scorched",
    name = ccb.content.plural_text("scorched haplocanthosaurus zombie", "scorched haplocanthosaurus zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zaplocanthosaurus",
    fungalize_into = "mon_zaplocanthosaurus_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur sauropod with a long neck that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zamargasaurus_scorched",
    name = ccb.content.plural_text("scorched amargasaurus zombie", "scorched amargasaurus zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zamargasaurus",
    speed = 45,
    attack_cost = 45,
    melee_sides = 6,
    melee_damage = { { type = "bash", amount = 4 } },
    hp = 165,
    fungalize_into = "mon_zamargasaurus_fungus",
    description = ccb.content.text("Heavily-burned zombie dinosaur sauropod that still reeks of charred meat.  Its flesh has mended into a leathery shell studded with two rows of tall spines."),
    armor = { acid = 3, heat = 15, bash = 10, cut = 17, bullet = 13 },
}

-- When large volumes are fixed this should be 20000 L
ccb.content.define_monster {
    id = "mon_zapatosaurus_scorched",
    name = ccb.content.plural_text("scorched apatosaurus zombie", "scorched apatosaurus zombies"),
    copy_from = "mon_zamptosaurus_scorched",
    looks_like = "mon_zapatosaurus",
    volume = "1000 L",
    mass = "20000 kg",
    body_type = "elephant",
    speed = 55,
    attack_cost = 55,
    melee_dice = 4,
    melee_sides = 3,
    weakpoint_sets = { "wps_sauropod_body" },
    hp = 250,
    fungalize_into = "mon_zapatosaurus_fungus",
    attacks = {
        {
            spell = { id = "zapatosaurus_control", min_level = 1, hit_self = true },
            allow_no_target = true,
            casting_message = "",
            cooldown = 3,
            kind = "spell",
        },
        { reference = "tailsmash_long_DinoMod", cooldown = 30 },
    },
    description = ccb.content.text("Heavily-burned zombie dinosaur sauropod with a long neck that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 8, cut = 13, bullet = 9 },
}

ccb.content.define_monster {
    id = "mon_zrontosaurus_scorched",
    name = ccb.content.plural_text("scorched brontosaurus zombie", "scorched brontosaurus zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zrontosaurus",
    fungalize_into = "mon_zrontosaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_ziplodocus_scorched",
    name = ccb.content.plural_text("scorched diplodocus zombie", "scorched diplodocus zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_ziplodocus",
    speed = 40,
    attack_cost = 40,
    hp = 245,
    fungalize_into = "mon_ziplodocus_fungus",
    armor = { acid = 3, heat = 15, cut = 13, bullet = 9, bash = 7 },
}

ccb.content.define_monster {
    id = "mon_zarosaurus_scorched",
    name = ccb.content.plural_text("scorched barosaurus zombie", "scorched barosaurus zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zarosaurus",
    speed = 40,
    attack_cost = 40,
    hp = 250,
    fungalize_into = "mon_zarosaurus_fungus",
    armor = { acid = 3, heat = 15, cut = 13, bullet = 9, bash = 7 },
}

ccb.content.define_monster {
    id = "mon_zamarasaurus_scorched",
    name = ccb.content.plural_text("scorched camarasaurus zombie", "scorched camarasaurus zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zamarasaurus",
    speed = 40,
    attack_cost = 40,
    hp = 225,
    fungalize_into = "mon_zamarasaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zrachiosaurus_scorched",
    name = ccb.content.plural_text("scorched brachiosaurus zombie", "scorched brachiosaurus zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zrachiosaurus",
    speed = 35,
    attack_cost = 35,
    melee_dice = 6,
    hp = 285,
    fungalize_into = "mon_zrachiosaurus_fungus",
    armor = { acid = 3, heat = 15, bash = 10, cut = 17, bullet = 10 },
}

ccb.content.define_monster {
    id = "mon_zastrodon_scorched",
    name = ccb.content.plural_text("scorched astrodon zombie", "scorched astrodon zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zrachiosaurus",
    speed = 40,
    attack_cost = 40,
    melee_dice = 6,
    hp = 270,
    fungalize_into = "mon_zastrodon_fungus",
    armor = { acid = 3, heat = 15, bash = 10, cut = 17, bullet = 10 },
}

ccb.content.define_monster {
    id = "mon_zalamosaurus_scorched",
    name = ccb.content.plural_text("scorched alamosaurus zombie", "scorched alamosaurus zombies"),
    copy_from = "mon_zapatosaurus_scorched",
    looks_like = "mon_zalamosaurus",
    melee_dice = 5,
    hp = 250,
    fungalize_into = "mon_zalamosaurus_fungus",
    armor = { acid = 3, heat = 15, bash = 17, cut = 28, bullet = 10 },
}

-- When large volumes are fixed this should be 3170 L
ccb.content.define_monster {
    id = "mon_ztegosaurus_scorched",
    name = ccb.content.plural_text("scorched stegosaurus zombie", "scorched stegosaurus zombies"),
    copy_from = "mon_zamptosaurus_scorched",
    looks_like = "mon_ztegosaurus",
    volume = "1000 L",
    mass = "3800 kg",
    body_type = "elephant",
    speed = 10,
    attack_cost = 10,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 3,
    melee_damage = { { type = "stab", amount = 1 } },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_nat_armored",
    },
    weakpoint_sets = { "wps_ankylosaurid_body" },
    hp = 140,
    fungalize_into = "mon_ztegosaurus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with prominent bony back plates; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 6, cut = 13, bullet = 9 },
}

ccb.content.define_monster {
    id = "mon_zesperosaurus_scorched",
    name = ccb.content.plural_text("scorched hesperosaurus zombie", "scorched hesperosaurus zombies"),
    copy_from = "mon_ztegosaurus_scorched",
    looks_like = "mon_zesperosaurus",
    hp = 200,
    fungalize_into = "mon_zesperosaurus_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bullet = 9, bash = 7, cut = 15 },
}

ccb.content.define_monster {
    id = "mon_zastonia_scorched",
    name = ccb.content.plural_text("scorched gastonia zombie", "scorched gastonia zombies"),
    copy_from = "mon_zankylosaurus_scorched",
    looks_like = "mon_zastonia",
    hp = 150,
    fungalize_into = "mon_zastonia_fungus",
    description = ccb.content.text("A heavily-burned, armored four legged zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zargoyleosaurus_scorched",
    name = ccb.content.plural_text("scorched gargoyleosaurus zombie", "scorched gargoyleosaurus zombies"),
    copy_from = "mon_zankylosaurus_scorched",
    looks_like = "mon_zargoyleosaurus",
    volume = "415 L",
    mass = "500 kg",
    hp = 120,
    speed = 30,
    attack_cost = 30,
    fungalize_into = "mon_zargoyleosaurus_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 13, cut = 22, bullet = 13 },
}

ccb.content.define_monster {
    id = "mon_zauropelta_scorched",
    name = ccb.content.plural_text("scorched sauropelta zombie", "scorched sauropelta zombies"),
    copy_from = "mon_zodosaurus_scorched",
    looks_like = "mon_zauropelta",
    hp = 150,
    fungalize_into = "mon_zauropelta_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zodosaurus_scorched",
    name = ccb.content.plural_text("scorched nodosaurus zombie", "scorched nodosaurus zombies"),
    copy_from = "mon_zankylosaurus_scorched",
    looks_like = "mon_zodosaurus",
    hp = 135,
    fungalize_into = "mon_zodosaurus_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 23, cut = 32, bullet = 18 },
}

ccb.content.define_monster {
    id = "mon_zanoplosaurus_scorched",
    name = ccb.content.plural_text("scorched panoplosaurus zombie", "scorched panoplosaurus zombies"),
    copy_from = "mon_zankylosaurus_scorched",
    looks_like = "mon_zanoplosaurus",
    hp = 135,
    fungalize_into = "mon_zanoplosaurus_fungus",
    description = ccb.content.text("A heavily-burned, four legged armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 23, cut = 32, bullet = 18 },
}

ccb.content.define_monster {
    id = "mon_zedmontonia_scorched",
    name = ccb.content.plural_text("scorched edmontonia zombie", "scorched edmontonia zombies"),
    copy_from = "mon_zankylosaurus_scorched",
    looks_like = "mon_zedmontonia",
    hp = 140,
    melee_damage = { { type = "stab", amount = 10 } },
    fungalize_into = "mon_zedmontonia_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 23, cut = 32, bullet = 18 },
}

ccb.content.define_monster {
    id = "mon_zzuul_scorched",
    name = ccb.content.plural_text("scorched zuul zombie", "scorched zuul zombies"),
    copy_from = "mon_zyoplosaurus_scorched",
    looks_like = "mon_zuul",
    hp = 100,
    fungalize_into = "mon_zzuul_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur studded with spikes that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zyoplosaurus_scorched",
    name = ccb.content.plural_text("scorched dyoplosaurus zombie", "scorched dyoplosaurus zombies"),
    copy_from = "mon_zankylosaurus_scorched",
    looks_like = "mon_zyoplosaurus",
    hp = 95,
    fungalize_into = "mon_zyoplosaurus_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
}

-- When large volumes are fixed this should be 5000 L
ccb.content.define_monster {
    id = "mon_zankylosaurus_scorched",
    name = ccb.content.plural_text("scorched ankylosaurus zombie", "scorched ankylosaurus zombies"),
    looks_like = "mon_zankylosaurus",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "1000 L",
    mass = "6000 kg",
    body_type = "elephant",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 15,
    attack_cost = 15,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 3,
    melee_damage = { { type = "stab", amount = 1 } },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_nat_armored",
    },
    weakpoint_sets = { "wps_ankylosaurid_body" },
    hp = 190,
    fungalize_into = "mon_zankylosaurus_fungus",
    vision_night = 3,
    categories = { "DINOSAUR" },
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 50,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "STUMBLES", "GRABS", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 18, cut = 30, acid = 3, heat = 15, bullet = 14 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zuoplocephalus_scorched",
    name = ccb.content.plural_text("scorched euoplocephalus zombie", "scorched euoplocephalus zombies"),
    copy_from = "mon_zankylosaurus_scorched",
    looks_like = "mon_zuoplocephalus",
    hp = 200,
    fungalize_into = "mon_zuoplocephalus_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zcolosaurus_scorched",
    name = ccb.content.plural_text("scorched scolosaurus zombie", "scorched scolosaurus zombies"),
    copy_from = "mon_zankylosaurus_scorched",
    looks_like = "mon_zcolosaurus",
    hp = 200,
    fungalize_into = "mon_zcolosaurus_fungus",
    description = ccb.content.text("A heavily-burned, armored zombie dinosaur that still reeks of charred meat.  What little flesh is exposed has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zenontosaurus_scorched",
    name = ccb.content.plural_text("scorched tenontosaurus zombie", "scorched tenontosaurus zombies"),
    looks_like = "mon_zenontosaurus",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "800 L",
    mass = "800 kg",
    body_type = "bear",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 100,
    attack_cost = 100,
    melee_skill = 3,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "bash", amount = 2 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 80,
    fungalize_into = "mon_zamptosaurus_fungus",
    vision_night = 3,
    categories = { "DINOSAUR" },
    description = ccb.content.text("A heavily-burned zombie dinosaur with a pointed beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 50,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "GRABS", "STUMBLES", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 7, cut = 13, acid = 3, heat = 15, bullet = 9 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zryosaurus_scorched",
    name = ccb.content.plural_text("scorched dryosaurus zombie", "scorched dryosaurus zombies"),
    looks_like = "mon_zryosaurus",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "45 L",
    mass = "45 kg",
    body_type = "ostrich",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 100,
    attack_cost = 100,
    melee_skill = 3,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "bash", amount = 2 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 30,
    fungalize_into = "mon_zryosaurus_fungus",
    vision_night = 3,
    categories = { "DINOSAUR" },
    description = ccb.content.text("A heavily-burned zombie dinosaur with a pointed beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 10,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "GRABS", "STUMBLES", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 7, cut = 13, acid = 3, heat = 15, bullet = 9 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zamptosaurus_scorched",
    name = ccb.content.plural_text("scorched camptosaurus zombie", "scorched camptosaurus zombies"),
    looks_like = "mon_zamptosaurus",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "850 L",
    mass = "850 kg",
    body_type = "bear",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 50,
    attack_cost = 50,
    melee_skill = 3,
    melee_dice = 1,
    melee_sides = 3,
    melee_damage = { { type = "bash", amount = 2 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 85,
    fungalize_into = "mon_zamptosaurus_fungus",
    vision_night = 3,
    categories = { "DINOSAUR" },
    description = ccb.content.text("A heavily-burned zombie dinosaur with a pointed beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 50,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "GRABS", "STUMBLES", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 7, cut = 13, acid = 3, heat = 15, bullet = 9 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

-- When large weights and volumes are fixed this should be 4500 L
ccb.content.define_monster {
    id = "mon_ziguanodon_scorched",
    name = ccb.content.plural_text("scorched iguanodon zombie", "scorched iguanodon zombies"),
    copy_from = "mon_zamptosaurus_scorched",
    looks_like = "mon_ziguanodon",
    volume = "1000 L",
    mass = "4500 kg",
    speed = 70,
    attack_cost = 70,
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 2 } },
    hp = 150,
    fungalize_into = "mon_ziguanodon_fungus",
    description = ccb.content.text("A heavily-burned bulky zombie dinosaur with a beak and sharp pointed thumbs; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { bash = 7, acid = 3, heat = 15, cut = 16, bullet = 11 },
}

ccb.content.define_monster {
    id = "mon_zeolambia_scorched",
    name = ccb.content.plural_text("scorched eolambia zombie", "scorched eolambia zombies"),
    copy_from = "mon_ziguanodon_scorched",
    looks_like = "mon_zeolambia",
    speed = 80,
    attack_cost = 80,
    melee_damage = { { type = "bash", amount = 2 } },
    hp = 100,
    fungalize_into = "mon_zeolambia_fungus",
    description = ccb.content.text("A heavily-burned slender zombie dinosaur with a beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zadrosaurus_scorched",
    name = ccb.content.plural_text("scorched hadrosaurus zombie", "scorched hadrosaurus zombies"),
    copy_from = "mon_ziguanodon_scorched",
    looks_like = "mon_zadrosaurus",
    speed = 55,
    attack_cost = 55,
    melee_damage = { { type = "bash", amount = 2 } },
    hp = 110,
    fungalize_into = "mon_zadrosaurus_fungus",
    description = ccb.content.text("A heavily-burned bulky zombie dinosaur with a beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zaiasaura_scorched",
    name = ccb.content.plural_text("scorched maiasaura zombie", "scorched maiasaura zombies"),
    copy_from = "mon_zarasaurolophus_scorched",
    looks_like = "mon_zaiasaura",
    hp = 100,
    fungalize_into = "mon_zaiasaura_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a pointed beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zryposaurus_scorched",
    name = ccb.content.plural_text("scorched gryposaurus zombie", "scorched gryposaurus zombies"),
    copy_from = "mon_zedmontosaurus_scorched",
    looks_like = "mon_zryposaurus",
    hp = 250,
    fungalize_into = "mon_zryposaurus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a pointed beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zrosaurolophus_scorched",
    name = ccb.content.plural_text("scorched prosaurolophus zombie", "scorched prosaurolophus zombies"),
    copy_from = "mon_zedmontosaurus_scorched",
    looks_like = "mon_zrosaurolophus",
    hp = 250,
    fungalize_into = "mon_zrosaurolophus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a short beak and tall head crest; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zaurolophus_scorched",
    name = ccb.content.plural_text("scorched saurolophus zombie", "scorched saurolophus zombies"),
    copy_from = "mon_zedmontosaurus_scorched",
    looks_like = "mon_zaurolophus",
    hp = 250,
    fungalize_into = "mon_zaurolophus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a broad beak and spiky head crest; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zedmontosaurus_scorched",
    name = ccb.content.plural_text("scorched edmontosaurus zombie", "scorched edmontosaurus zombies"),
    copy_from = "mon_zarasaurolophus_scorched",
    looks_like = "mon_zedmontosaurus",
    speed = 55,
    attack_cost = 55,
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "bash", amount = 2 } },
    hp = 180,
    fungalize_into = "mon_zedmontosaurus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a pointed beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { bash = 7, acid = 3, heat = 15, cut = 15, bullet = 11 },
}

ccb.content.define_monster {
    id = "mon_zarasaurolophus_scorched",
    name = ccb.content.plural_text("scorched parasaurolophus zombie", "scorched parasaurolophus zombies"),
    copy_from = "mon_zadrosaurus_scorched",
    looks_like = "mon_zarasaurolophus",
    hp = 170,
    fungalize_into = "mon_zarasaurolophus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a pointed beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zambeosaurus_scorched",
    name = ccb.content.plural_text("scorched lambeosaurus zombie", "scorched lambeosaurus zombies"),
    copy_from = "mon_zarasaurolophus_scorched",
    looks_like = "mon_zambeosaurus",
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "bash", amount = 2 } },
    hp = 180,
    fungalize_into = "mon_zambeosaurus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a long stiff tail, hooves, a narrow beak and a tall head crest; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { bash = 7, acid = 3, heat = 15, cut = 15, bullet = 11 },
}

ccb.content.define_monster {
    id = "mon_zorythosaurus_scorched",
    name = ccb.content.plural_text("scorched corythosaurus zombie", "scorched corythosaurus zombies"),
    copy_from = "mon_zarasaurolophus_scorched",
    looks_like = "mon_zorythosaurus",
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "bash", amount = 2 } },
    hp = 180,
    fungalize_into = "mon_zorythosaurus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a pointed beak and tall head crest; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { bash = 7, acid = 3, heat = 15, cut = 15, bullet = 11 },
}

ccb.content.define_monster {
    id = "mon_zypacrosaurus_scorched",
    name = ccb.content.plural_text("scorched hypacrosaurus zombie", "scorched hypacrosaurus zombies"),
    copy_from = "mon_zarasaurolophus_scorched",
    looks_like = "mon_zypacrosaurus",
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "bash", amount = 2 } },
    hp = 180,
    fungalize_into = "mon_zypacrosaurus_fungus",
    description = ccb.content.text("A heavily-burned zombie dinosaur with a tall ridge down the back, a tail, hooves, a short beak and a wide, rounded head crest; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { bash = 7, acid = 3, heat = 15, cut = 15, bullet = 11 },
}

ccb.content.define_monster {
    id = "mon_zachycephalosaurus_scorched",
    name = ccb.content.plural_text("scorched pachycephalosaurus zombie", "scorched pachycephalosaurus zombies"),
    looks_like = "mon_pachycephalosaurus",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "450 L",
    mass = "450 kg",
    body_type = "ostrich",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 85,
    attack_cost = 85,
    melee_skill = 3,
    melee_dice = 1,
    melee_sides = 3,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 60,
    fungalize_into = "mon_zachycephalosaurus_fungus",
    vision_night = 3,
    categories = { "DINOSAUR" },
    description = ccb.content.text("A heavily-burned zombie dinosaur with a domed head; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 50,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "GRABS", "STUMBLES", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 5, cut = 13, acid = 3, heat = 15, bullet = 7 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeptoceratops_scorched",
    name = ccb.content.plural_text("scorched leptoceratops zombie", "scorched leptoceratops zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zeptoceratops",
    volume = "100 L",
    mass = "100 kg",
    body_type = "bear",
    speed = 75,
    attack_cost = 75,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 0 } },
    dodge = 5,
    hp = 50,
    grab_strength = 20,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    fungalize_into = "mon_zeptoceratops_fungus",
    description = ccb.content.text("A heavily-burned, four-legged zombie dinosaur corpse with a bony crest and sharp beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zzuniceratops_scorched",
    name = ccb.content.plural_text("scorched zuniceratops zombie", "scorched zuniceratops zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zzuniceratops",
    volume = "175 L",
    mass = "175 kg",
    speed = 75,
    attack_cost = 75,
    melee_skill = 3,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 5 } },
    hp = 90,
    description = ccb.content.text("A massive, heavily-burned four-legged dinosaur with a tall bony head crest, two long brow horns, and a beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    fungalize_into = "mon_zzuniceratops_fungus",
}

ccb.content.define_monster {
    id = "mon_zokiceratops_scorched",
    name = ccb.content.plural_text("scorched lokiceratops zombie", "scorched lokiceratops zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zokiceratops",
    melee_skill = 3,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 12 } },
    hp = 280,
    description = ccb.content.text("A massive, heavily-burned four-legged dinosaur with a bony head crest with two horns that curve out and down, two long brow horns, and a beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    fungalize_into = "mon_zokiceratops_fungus",
}

ccb.content.define_monster {
    id = "mon_ztyracosaurus_scorched",
    name = ccb.content.plural_text("scorched styracosaurus zombie", "scorched styracosaurus zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_ztyracosaurus",
    hp = 100,
    description = ccb.content.text("A massive, shambling, rhino-like dinosaur corpse with a bony crest with several long spikes and one large horn above the beak and a short tail.  Its flesh has mended into a leathery shell."),
    fungalize_into = "mon_zentrosaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zentrosaurus_scorched",
    name = ccb.content.plural_text("scorched centrosaurus zombie", "scorched centrosaurus zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zentrosaurus",
    hp = 100,
    description = ccb.content.text("A massive, shambling, rhino-like dinosaur corpse with a beak and long horn above the nose.  Its flesh has mended into a leathery shell."),
    fungalize_into = "mon_zentrosaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zeiniosaurus_scorched",
    name = ccb.content.plural_text("scorched einiosaurus zombie", "scorched einiosaurus zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zeiniosaurus",
    hp = 90,
    description = ccb.content.text("A massive, shambling, four-legged dinosaur corpse with a tall bony crest and one large horn above the nose curving forward towards the beak.  Its flesh has mended into a leathery shell."),
    fungalize_into = "mon_zeiniosaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zachelousaurus_scorched",
    name = ccb.content.plural_text("scorched achelousaurus zombie", "scorched achelousaurus zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zachelousaurus",
    hp = 100,
    fungalize_into = "mon_zachelousaurus_fungus",
    description = ccb.content.text("A heavily-burned, four-legged dinosaur corpse with a tall bony crest with two long curved spikes and three rough bosses above the eyes and nose as well as a hooked beak.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zachyrhinosaurus_scorched",
    name = ccb.content.plural_text("scorched pachyrhinosaurus zombie", "scorched pachyrhinosaurus zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zachyrhinosaurus",
    hp = 120,
    fungalize_into = "mon_zachyrhinosaurus_fungus",
    description = ccb.content.text("A heavily-burned, four-legged dinosaur corpse with a broad bony nose; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zasmosaurus_scorched",
    name = ccb.content.plural_text("scorched chasmosaurus zombie", "scorched chasmosaurus zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zasmosaurus",
    hp = 150,
    fungalize_into = "mon_zasmosaurus_fungus",
    description = ccb.content.text("A heavily-burned, four-legged zombie dinosaur with a tall bony crest from which three short horns emerge above the eyes and beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bullet = 10, bash = 10, cut = 18 },
}

ccb.content.define_monster {
    id = "mon_zentaceratops_scorched",
    name = ccb.content.plural_text("scorched pentaceratops zombie", "scorched pentaceratops zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zentaceratops",
    hp = 190,
    fungalize_into = "mon_zentaceratops_fungus",
    description = ccb.content.text("A heavily-burned, four-legged zombie dinosaur with four long horns and a short nose horn; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bullet = 10, bash = 10, cut = 18 },
}

ccb.content.define_monster {
    id = "mon_zosmoceratops_scorched",
    name = ccb.content.plural_text("scorched kosmoceratops zombie", "scorched kosmoceratops zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zosmoceratops",
    speed = 60,
    attack_cost = 60,
    melee_dice = 5,
    melee_sides = 7,
    melee_damage = { { type = "bash", amount = 10 } },
    hp = 125,
    fungalize_into = "mon_zosmoceratops_fungus",
    description = ccb.content.text("A heavily-burned, four-legged zombie dinosaur with a bony crest and two wavy side horns; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 8, cut = 16, bullet = 11 },
}

ccb.content.define_monster {
    id = "mon_zorosaurus_scorched",
    name = ccb.content.plural_text("scorched torosaurus zombie", "scorched torosaurus zombies"),
    copy_from = "mon_zriceratops_scorched",
    looks_like = "mon_zorosaurus",
    fungalize_into = "mon_zorosaurus_fungus",
    description = ccb.content.text("A heavily-burned, four-legged zombie dinosaur with a bony crest and two wicked-looking horns; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bullet = 10, bash = 10, cut = 18 },
}

-- When large volumes are fixed this should be 7000 L
ccb.content.define_monster {
    id = "mon_zriceratops_scorched",
    name = ccb.content.plural_text("scorched triceratops zombie", "scorched triceratops zombies"),
    copy_from = "mon_zamptosaurus_scorched",
    looks_like = "mon_zriceratops",
    volume = "1000 L",
    mass = "7000 kg",
    body_type = "elephant",
    speed = 55,
    attack_cost = 55,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 7,
    melee_damage = { { type = "stab", amount = 15 } },
    weakpoint_sets = { "wps_lg_ceratopsian_body" },
    hp = 200,
    fungalize_into = "mon_zriceratops_fungus",
    description = ccb.content.text("A heavily-burned, four-legged zombie dinosaur with a bony crest and three wicked-looking horns; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 7, cut = 16, bullet = 10 },
}

ccb.content.define_monster {
    id = "mon_zona_scorched",
    name = ccb.content.plural_text("scorched fona zombie", "scorched fona zombies"),
    copy_from = "mon_zescelosaurus_scorched",
    looks_like = "mon_zallimimus",
    volume = "50 L",
    mass = "50 kg",
    speed = 70,
    attack_cost = 70,
    hp = 70,
    fungalize_into = "mon_zona_fungus",
    description = ccb.content.text("A heavily-burned, two-legged zombie dinosaur with claws and a long tail; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zescelosaurus_scorched",
    name = ccb.content.plural_text("scorched thescelosaurus zombie", "scorched thescelosaurus zombies"),
    copy_from = "mon_zallimimus_scorched",
    looks_like = "mon_zallimimus",
    volume = "250 L",
    mass = "250 kg",
    speed = 110,
    attack_cost = 110,
    melee_skill = 3,
    melee_dice = 1,
    melee_sides = 6,
    melee_damage = { { type = "stab", amount = 1 } },
    hp = 100,
    fungalize_into = "mon_zescelosaurus_fungus",
    description = ccb.content.text("A heavily-burned, two-legged zombie dinosaur with strong arms and a long toothy beak; it still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    armor = { acid = 3, heat = 15, bash = 7, cut = 16, bullet = 10 },
}

ccb.content.define_monster {
    id = "mon_zteranodon_scorched",
    name = ccb.content.plural_text("scorched pteranodon zombie", "scorched pteranodon zombies"),
    looks_like = "mon_pteranodon",
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    volume = "38 L",
    mass = "50 kg",
    body_type = "bird",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    speed = 125,
    attack_cost = 125,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 0 } },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_flying",
    },
    weakpoint_sets = { "wps_pterosaur_body" },
    hp = 15,
    fungalize_into = "mon_zteranodon_fungus",
    vision_night = 3,
    categories = { "DINOSAUR" },
    description = ccb.content.text("A heavily-burned, birdlike zombie pterosaur that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 10,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "STUMBLES", "GRABS", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY",
    },
    armor = { bash = 6, cut = 13, acid = 3, heat = 15, bullet = 7 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zuetzalcoatlus_scorched",
    name = ccb.content.plural_text("scorched quetzalcoatlus zombie", "scorched quetzalcoatlus zombies"),
    copy_from = "mon_zteranodon_scorched",
    volume = "190 L",
    mass = "250 kg",
    speed = 100,
    attack_cost = 100,
    hp = 40,
    fungalize_into = "mon_zuetzalcoatlus_fungus",
    description = ccb.content.text("A heavily-burned, birdlike zombie pterosaur that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
}

ccb.content.define_monster {
    id = "mon_zosasaurus_scorched",
    name = ccb.content.plural_text("scorched mosasaurus zombie", "scorched mosasaurus zombies"),
    copy_from = "mon_zyrannosaurus_scorched",
    looks_like = "mon_zhark",
    body_type = "fish",
    speed = 12,
    attack_cost = 12,
    melee_skill = 3,
    melee_dice = 3,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 16 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_mosasaur_body" },
    hp = 165,
    fungalize_into = "mon_zosasaurus_fungus",
    description = ccb.content.text("A heavily-burned, aquatic zombie reptile that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 50,
    attacks = { { id = "bite_grab", cooldown = 7 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "STUMBLES", "GRABS", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY", "SWIMS", "AQUATIC",
    },
    armor = { bash = 7, cut = 16, acid = 3, heat = 15, bullet = 14 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_zonisaurus_scorched",
    name = ccb.content.plural_text("scorched shonisaurus zombie", "scorched shonisaurus zombies"),
    copy_from = "mon_zosasaurus_scorched",
    speed = 15,
    attack_cost = 15,
    melee_dice = 2,
    melee_damage = { { type = "stab", amount = 10 } },
    fungalize_into = "mon_zonisaurus_fungus",
}

ccb.content.define_monster {
    id = "mon_zlesiosaurus_scorched",
    name = ccb.content.plural_text("scorched plesiosaurus zombie", "scorched plesiosaurus zombies"),
    copy_from = "mon_zosasaurus_scorched",
    looks_like = "mon_zhark",
    body_type = "gator",
    speed = 10,
    attack_cost = 10,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 6 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    weakpoint_sets = { "wps_mosasaur_body" },
    hp = 115,
    fungalize_into = "mon_zosasaurus_fungus",
    description = ccb.content.text("A heavily-burned, aquatic zombie reptile that still reeks of charred meat.  Its flesh has mended into a leathery shell."),
    color = "i_brown",
    bleed_rate = 0,
    vision_day = 10,
    grab_strength = 10,
    attacks = { { id = "bite_grab", cooldown = 50 } },
    harvest = "zed_dino_leather",
    flags = {
        "SEES", "HEARS", "STUMBLES", "GRABS", "POISON", "NO_BREATHE", "REVIVES", "REVIVES_HEALTHY",
        "NO_NECRO", "FILTHY", "SWIMS", "AQUATIC",
    },
    armor = { bash = 7, cut = 16, acid = 3, heat = 15, bullet = 14 },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}
