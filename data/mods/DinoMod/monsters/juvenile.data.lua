local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_dilophosaurus_juvenile",
    name = ccb.content.plural_text("dilophosaurus juvenile", "dilophosaurus juveniles"),
    description = ccb.content.text("A small bipedal dinosaur juvenile with large eyes and sharp teeth."),
    default_faction = "dilophosaurus_juvenile",
    copy_from = "mon_dilophosaurus",
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    upgrade = { grow_at_age = 65, monster = "mon_dilophosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = {
        add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } },
        scale = { hp = 0.5, speed = 1.25 },
    },
}

ccb.content.define_monster {
    id = "mon_ceratosaurus_juvenile",
    name = ccb.content.plural_text("ceratosaurus juvenile", "ceratosaurus juveniles"),
    default_faction = "ceratosaurus_juvenile",
    copy_from = "mon_dilophosaurus_juvenile",
    upgrade = { grow_at_age = 90, monster = "mon_ceratosaurus" },
}

ccb.content.define_monster {
    id = "mon_spinosaurus_juvenile",
    name = ccb.content.plural_text("spinosaurus juvenile", "spinosaurus juveniles"),
    description = ccb.content.text("A huge dinosaur juvenile with sharp teeth and a large fan on its back."),
    default_faction = "spinosaurus_juvenile",
    copy_from = "mon_spinosaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    upgrade = { grow_at_age = 1460, monster = "mon_spinosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_torvosaurus_juvenile",
    name = ccb.content.plural_text("torvosaurus juvenile", "torvosaurus juveniles"),
    description = ccb.content.text("A large bipedal dinosaur juvenile with sharp teeth."),
    default_faction = "torvosaurus_juvenile",
    copy_from = "mon_torvosaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    upgrade = { grow_at_age = 1460, monster = "mon_torvosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_allosaurus_juvenile",
    name = ccb.content.plural_text("juvenile allosaurus", "juvenile allosauruses"),
    description = ccb.content.text("A large bipedal meat-eating dinosaur juvenile."),
    default_faction = "allosaurus_juvenile",
    copy_from = "mon_allosaurus",
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_allosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_acrocanthosaurus_juvenile",
    name = ccb.content.plural_text("acrocanthosaurus juvenile", "acrocanthosaurus juveniles"),
    description = ccb.content.text("Large predatory bipedal dinosaur juvenile with a tall ridge running the length of its back covered with heavy muscles."),
    default_faction = "acrocanthosaurus_juvenile",
    copy_from = "mon_acrocanthosaurus",
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_acrocanthosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_giganotosaurus_juvenile",
    name = ccb.content.plural_text("giganotosaurus juvenile", "giganotosaurus juveniles"),
    description = ccb.content.text("Large predatory bipedal dinosaur juvenile with a wide, flat head."),
    default_faction = "giganotosaurus_juvenile",
    copy_from = "mon_giganotosaurus",
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_giganotosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_siats_juvenile",
    name = ccb.content.plural_text("siats juvenile", "siats juveniles"),
    description = ccb.content.text("Large predatory bipedal dinosaur juvenile with long claws and strong arms for grappling."),
    default_faction = "siats_juvenile",
    copy_from = "mon_siats",
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_siats" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_dryptosaurus_juvenile",
    name = ccb.content.plural_text("dryptosaurus juvenile", "dryptosaurus juveniles"),
    description = ccb.content.text("Large teeth, fierce eyes, and a powerful frame to drive this juvenile forward, with claws and a feathered mullet and tail."),
    default_faction = "dryptosaurus_juvenile",
    copy_from = "mon_dryptosaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_dryptosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_nanotyrannus_juvenile",
    name = ccb.content.plural_text("nanotyrannus juvenile", "nanotyrannus juveniles"),
    description = ccb.content.text("Large teeth, fierce eyes, and long legs to drive this juvenile forward, with claws and a feathered mullet and tail."),
    default_faction = "nanotyrannus_juvenile",
    copy_from = "mon_nanotyrannus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "350 L",
    mass = "350 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_nanotyrannus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_appalachiosaurus_juvenile",
    name = ccb.content.plural_text("appalachiosaurus juvenile", "appalachiosaurus juveniles"),
    description = ccb.content.text("Large teeth, fierce eyes, and a powerful frame to drive this juvenile forward, with two small arms and a feathered mullet and tail."),
    default_faction = "appalachiosaurus_juvenile",
    copy_from = "mon_appalachiosaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_appalachiosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_gorgosaurus_juvenile",
    name = ccb.content.plural_text("gorgosaurus juvenile", "gorgosaurus juveniles"),
    description = ccb.content.text("Enormous teeth, fierce eyes, and a powerful frame to drive this juvenile forward, with two small arms and a feathered mullet and tail."),
    default_faction = "gorgosaurus_juvenile",
    copy_from = "mon_gorgosaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_gorgosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_albertosaurus_juvenile",
    name = ccb.content.plural_text("albertosaurus juvenile", "albertosaurus juveniles"),
    description = ccb.content.text("Enormous teeth, fierce eyes, and a powerful frame to drive this juvenile forward, with short strong arms and a feathered mullet and tail."),
    default_faction = "albertosaurus_juvenile",
    copy_from = "mon_albertosaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_albertosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_qianzhousaurus_juvenile",
    name = ccb.content.plural_text("qianzhousaurus juvenile", "qianzhousaurus juveniles"),
    description = ccb.content.text("This large, bipedal, feather-covered dinosaur juvenile has a long, gator-like mouth with sharp teeth."),
    default_faction = "qianzhousaurus_juvenile",
    copy_from = "mon_qianzhousaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_qianzhousaurus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_nanuqsaurus_juvenile",
    name = ccb.content.plural_text("nanuqsaurus juvenile", "nanuqsaurus juveniles"),
    description = ccb.content.text("This large, bipedal dinosaur juvenile has long, sharp teeth and fluffy white feathers."),
    default_faction = "nanuqsaurus_juvenile",
    copy_from = "mon_nanuqsaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_nanuqsaurus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_daspletosaurus_juvenile",
    name = ccb.content.plural_text("daspletosaurus juvenile", "daspletosaurus juveniles"),
    description = ccb.content.text("This large, bipedal dinosaur juvenile has long, sharp teeth."),
    default_faction = "daspletosaurus_juvenile",
    copy_from = "mon_daspletosaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_daspletosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_tyrannosaurus_juvenile",
    name = ccb.content.plural_text("tyrannosaurus juvenile", "tyrannosaurus juveniles"),
    description = ccb.content.text("A large predatory dinosaur juvenile with large sharp teeth."),
    default_faction = "tyrannosaurus_juvenile",
    copy_from = "mon_tyrannosaurus",
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    volume = "750 L",
    mass = "750 kg",
    upgrade = { grow_at_age = 1460, monster = "mon_tyrannosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    dissect = "dissect_tyrant_sample_small",
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.25 } },
}

ccb.content.define_monster {
    id = "mon_nedcolbertia_juvenile",
    name = ccb.content.plural_text("nedcolbertia juvenile", "nedcolbertia juveniles"),
    description = ccb.content.text("A small two-legged dinosaur juvenile with feathers, it could be from a number of different species."),
    default_faction = "herbivore_young",
    categories = { "DINOSAUR", "WILDLIFE" },
    species = { "DINOSAUR" },
    volume = "25 L",
    mass = "25 kg",
    hp = 40,
    speed = 100,
    materials = { "flesh" },
    symbol = "v",
    color = "light_gray",
    looks_like = "mon_eoraptor",
    aggression = -99,
    morale = 5,
    melee_skill = 2,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 6,
    upgrade = { grow_at_age = 70, monster = "mon_nedcolbertia" },
    biosignature = { item = "feces_dino", interval = 3 },
    pet = { food = { "DINOFOOD_A", "DINOFOOD_B", "DINOFOOD_C" } },
    flags = {
        "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "PET_MOUNTABLE", "WARM", "NO_BREED", "CANPLAY",
        "CAN_BE_CULLED", "EATS",
    },
    harvest = "dino_feather_leather",
}

ccb.content.define_monster {
    id = "mon_gallimimus_juvenile",
    name = ccb.content.plural_text("gallimimus juvenile", "gallimimus juveniles"),
    copy_from = "mon_nedcolbertia_juvenile",
    description = ccb.content.text("A small bipedal dinosaur juvenile with feathers and a beak, it could be from a number of different species."),
    volume = "220 L",
    mass = "220 kg",
    hp = 55,
    upgrade = { grow_at_age = 70, monster = "mon_gallimimus" },
    zombify_into = "mon_zallimimus_juvenile",
}

ccb.content.define_monster {
    id = "mon_struthiomimus_juvenile",
    name = ccb.content.plural_text("struthiomimus juvenile", "struthiomimus juveniles"),
    copy_from = "mon_gallimimus_juvenile",
    upgrade = { grow_at_age = 70, monster = "mon_struthiomimus" },
    zombify_into = "mon_ztruthiomimus_juvenile",
}

ccb.content.define_monster {
    id = "mon_ornithomimus_juvenile",
    name = ccb.content.plural_text("ornithomimus juvenile", "ornithomimus juveniles"),
    copy_from = "mon_gallimimus_juvenile",
    upgrade = { grow_at_age = 70, monster = "mon_ornithomimus" },
    zombify_into = "mon_zornithomimus_juvenile",
}

ccb.content.define_monster {
    id = "mon_falcarius_juvenile",
    name = ccb.content.plural_text("falcarius juvenile", "falcarius juveniles"),
    description = ccb.content.text("A small bipedal plant-eating dinosaur juvenile."),
    copy_from = "mon_gallimimus_juvenile",
    volume = "50 L",
    mass = "50 kg",
    hp = 75,
    upgrade = { grow_at_age = 50, monster = "mon_falcarius" },
    zombify_into = "mon_zalcarius",
}

ccb.content.define_monster {
    id = "mon_therizinosaurus_juvenile",
    name = ccb.content.plural_text("therizinosaurus juvenile", "therizinosaurus juveniles"),
    copy_from = "mon_therizinosaurus",
    hp = 250,
    upgrade = { grow_at_age = 365, monster = "mon_therizinosaurus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } } },
}

ccb.content.define_monster {
    id = "mon_nothronychus_juvenile",
    name = ccb.content.plural_text("nothronychus juvenile", "nothronychus juveniles"),
    copy_from = "mon_nothronychus",
    volume = "400 L",
    mass = "400 kg",
    hp = 80,
    upgrade = { grow_at_age = 365, monster = "mon_nothronychus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } } },
}

ccb.content.define_monster {
    id = "mon_anzu_juvenile",
    name = ccb.content.plural_text("anzu juvenile", "anzu juveniles"),
    copy_from = "mon_anzu",
    volume = "250 L",
    mass = "250 kg",
    hp = 60,
    default_faction = "anzu_juvenile",
    upgrade = { grow_at_age = 365, monster = "mon_anzu" },
    pet = { food = { "DINOFOOD_A", "DINOFOOD_B", "DINOFOOD_C" } },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } } },
}

ccb.content.define_monster {
    id = "mon_deinonychus_juvenile",
    name = ccb.content.plural_text("deinonychus juvenile", "deinonychus juveniles"),
    default_faction = "deinonychus_juvenile",
    copy_from = "mon_deinonychus",
    volume = "50 L",
    mass = "50 kg",
    hp = 30,
    upgrade = { grow_at_age = 100, monster = "mon_deinonychus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } } },
}

ccb.content.define_monster {
    id = "mon_utahraptor_juvenile",
    name = ccb.content.plural_text("utahraptor juvenile", "utahraptor juveniles"),
    default_faction = "utahraptor_juvenile",
    copy_from = "mon_utahraptor",
    volume = "250 L",
    mass = "250 kg",
    hp = 75,
    upgrade = { grow_at_age = 100, monster = "mon_utahraptor" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } } },
}

ccb.content.define_monster {
    id = "mon_sarahsaurus_juvenile",
    name = ccb.content.plural_text("sarahsaurus juvenile", "sarahsaurus juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    description = ccb.content.text("A large, two-legged, plant-eating juvenile sauropod with a long neck and tail."),
    zombify_into = "mon_zarahsaurus_juvenile",
    upgrade = { grow_at_age = 365, monster = "mon_sarahsaurus" },
    volume = "100 L",
    mass = "100 kg",
    body_type = "ostrich",
    hp = 65,
    speed = 100,
    attacks = {
        { id = "stomp_DinoMod", cooldown = 10, damage = { { type = "bash", amount = 8 } } },
        { reference = "EAT_CROP", cooldown = 10 },
    },
    inheritance = { add = { flags = { "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_anchisaurus_juvenile",
    name = ccb.content.plural_text("anchisaurus juvenile", "anchisaurus juveniles"),
    copy_from = "mon_issi_juvenile",
    description = ccb.content.text("A four-legged, plant-eating juvenile sauropod with a long neck."),
    zombify_into = "mon_zanchisaurus",
    upgrade = { grow_at_age = 5, monster = "mon_anchisaurus" },
    volume = "15 L",
    mass = "15 kg",
    body_type = "bear",
    hp = 25,
    attacks = { { reference = "EAT_CROP", cooldown = 50 } },
}

ccb.content.define_monster {
    id = "mon_issi_juvenile",
    name = ccb.content.plural_text("issi juvenile", "issi juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    description = ccb.content.text("A large, two-legged, plant-eating juvenile sauropod with a long neck and tail."),
    zombify_into = "mon_zissi_juvenile",
    upgrade = { grow_at_age = 365, monster = "mon_issi" },
    volume = "500 L",
    mass = "500 kg",
    body_type = "ostrich",
    hp = 100,
    speed = 100,
    attacks = {
        { id = "stomp_DinoMod", cooldown = 10, damage = { { type = "bash", amount = 8 } } },
        { reference = "EAT_CROP", cooldown = 10 },
    },
    inheritance = { add = { flags = { "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_moabosaurus_juvenile",
    name = ccb.content.plural_text("moabosaurus juvenile", "moabosaurus juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    zombify_into = "mon_zoabosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_moabosaurus" },
}

ccb.content.define_monster {
    id = "mon_haplocanthosaurus_juvenile",
    name = ccb.content.plural_text("haplocanthosaurus juvenile", "haplocanthosaurus juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    zombify_into = "mon_zaplocanthosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_haplocanthosaurus" },
}

ccb.content.define_monster {
    id = "mon_amargasaurus_juvenile",
    name = ccb.content.plural_text("amargasaurus juvenile", "amargasaurus juveniles"),
    copy_from = "mon_gallimimus_juvenile",
    looks_like = "mon_apatosaurus",
    default_faction = "herbivore_dino",
    aggressive_to_characters = false,
    description = ccb.content.text("A huge, four-legged, plant-eating juvenile sauropod with a long neck and tail, it could be from a number of different species."),
    volume = "1000 L",
    mass = "1000 kg",
    body_type = "elephant",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_dino" },
    weakpoint_sets = { "wps_sauropod_body" },
    hp = 200,
    aggression = -10,
    morale = 90,
    speed = 80,
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 4,
    zombify_into = "mon_zamargasaurus_juvenile",
    attacks = {
        { id = "stomp_DinoMod", cooldown = 10, damage = { { type = "bash", amount = 8 } } },
        { reference = "tailsmash_DinoMod", cooldown = 30 },
        { reference = "EAT_CROP", cooldown = 5 },
    },
    harvest = "dino_sauropod",
    anger_triggers = { "HURT", "FRIEND_ATTACKED" },
    fear_triggers = { "FRIEND_DIED" },
    upgrade = { grow_at_age = 1460, monster = "mon_amargasaurus" },
    pet = { food = { "DINOFOOD_C" } },
    flags = {
        "SEES",
        "HEARS",
        "ANIMAL",
        "PATH_AVOID_DANGER",
        "WARM",
        "NO_BREED",
        "CANPLAY",
        "GROUP_MORALE",
    },
}

ccb.content.define_monster {
    id = "mon_apatosaurus_juvenile",
    name = ccb.content.plural_text("apatosaurus juvenile", "apatosaurus juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    zombify_into = "mon_zapatosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_apatosaurus" },
}

ccb.content.define_monster {
    id = "mon_brontosaurus_juvenile",
    name = ccb.content.plural_text("brontosaurus juvenile", "brontosaurus juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    zombify_into = "mon_zrontosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_brontosaurus" },
}

ccb.content.define_monster {
    id = "mon_diplodocus_juvenile",
    name = ccb.content.plural_text("diplodocus juvenile", "diplodocus juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    zombify_into = "mon_ziplodocus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_diplodocus" },
}

ccb.content.define_monster {
    id = "mon_barosaurus_juvenile",
    name = ccb.content.plural_text("barosaurus juvenile", "barosaurus juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    zombify_into = "mon_zarosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_barosaurus" },
}

ccb.content.define_monster {
    id = "mon_camarasaurus_juvenile",
    name = ccb.content.plural_text("camarasaurus juvenile", "camarasaurus juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    attacks = {
        { id = "stomp_DinoMod", cooldown = 10, damage = { { type = "bash", amount = 8 } } },
        { reference = "tailsmash_long_DinoMod", cooldown = 30 },
        { reference = "EAT_CROP", cooldown = 5 },
    },
    zombify_into = "mon_zamarasaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_camarasaurus" },
}

ccb.content.define_monster {
    id = "mon_brachiosaurus_juvenile",
    name = ccb.content.plural_text("brachiosaurus juvenile", "brachiosaurus juveniles"),
    copy_from = "mon_camarasaurus_juvenile",
    zombify_into = "mon_zrachiosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_brachiosaurus" },
}

ccb.content.define_monster {
    id = "mon_astrodon_juvenile",
    name = ccb.content.plural_text("astrodon juvenile", "astrodon juveniles"),
    copy_from = "mon_amargasaurus_juvenile",
    zombify_into = "mon_zastrodon_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_astrodon" },
}

ccb.content.define_monster {
    id = "mon_alamosaurus_juvenile",
    name = ccb.content.plural_text("alamosaurus juvenile", "alamosaurus juveniles"),
    copy_from = "mon_camarasaurus_juvenile",
    zombify_into = "mon_zalamosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_alamosaurus" },
    armor = { bash = 7, cut = 9 },
}

ccb.content.define_monster {
    id = "mon_stegosaurus_juvenile",
    name = ccb.content.plural_text("stegosaurus juvenile", "stegosaurus juveniles"),
    description = ccb.content.text("A four-legged plant-eating dinosaur juvenile larger than a cow."),
    copy_from = "mon_gallimimus_juvenile",
    hp = 200,
    volume = "1000 L",
    mass = "1000 kg",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 1460, monster = "mon_stegosaurus" },
    flags = {
        "SEES",
        "HEARS",
        "ANIMAL",
        "PATH_AVOID_DANGER",
        "WARM",
        "NO_BREED",
        "CANPLAY",
        "CAN_BE_CULLED",
    },
}

ccb.content.define_monster {
    id = "mon_hesperosaurus_juvenile",
    name = ccb.content.plural_text("hesperosaurus juvenile", "hesperosaurus juveniles"),
    copy_from = "mon_stegosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_hesperosaurus" },
}

ccb.content.define_monster {
    id = "mon_gastonia_juvenile",
    name = ccb.content.plural_text("gastonia juvenile", "gastonia juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_gastonia" },
}

ccb.content.define_monster {
    id = "mon_gargoyleosaurus_juvenile",
    name = ccb.content.plural_text("gargoyleosaurus juvenile", "gargoyleosaurus juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_gargoyleosaurus" },
}

ccb.content.define_monster {
    id = "mon_sauropelta_juvenile",
    name = ccb.content.plural_text("sauropelta juvenile", "sauropelta juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_sauropelta" },
}

ccb.content.define_monster {
    id = "mon_nodosaurus_juvenile",
    name = ccb.content.plural_text("nodosaurus juvenile", "nodosaurus juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_nodosaurus" },
}

ccb.content.define_monster {
    id = "mon_panoplosaurus_juvenile",
    name = ccb.content.plural_text("panoplosaurus juvenile", "panoplosaurus juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_panoplosaurus" },
}

ccb.content.define_monster {
    id = "mon_edmontonia_juvenile",
    name = ccb.content.plural_text("edmontonia juvenile", "edmontonia juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_edmontonia" },
}

ccb.content.define_monster {
    id = "mon_zuul_juvenile",
    name = ccb.content.plural_text("zuul juvenile", "zuul juveniles"),
    copy_from = "mon_stegosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_zuul" },
}

ccb.content.define_monster {
    id = "mon_dyoplosaurus_juvenile",
    name = ccb.content.plural_text("dyoplosaurus juvenile", "dyoplosaurus juveniles"),
    copy_from = "mon_stegosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_dyoplosaurus" },
}

ccb.content.define_monster {
    id = "mon_ankylosaurus_juvenile",
    name = ccb.content.plural_text("ankylosaurus juvenile", "ankylosaurus juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_ankylosaurus" },
}

ccb.content.define_monster {
    id = "mon_euoplocephalus_juvenile",
    name = ccb.content.plural_text("euoplocephalus juvenile", "euoplocephalus juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_euoplocephalus" },
}

ccb.content.define_monster {
    id = "mon_scolosaurus_juvenile",
    name = ccb.content.plural_text("scolosaurus juvenile", "scolosaurus juveniles"),
    copy_from = "mon_dyoplosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_scolosaurus" },
}

ccb.content.define_monster {
    id = "mon_tenontosaurus_juvenile",
    name = ccb.content.plural_text("tenontosaurus juvenile", "tenontosaurus juveniles"),
    copy_from = "mon_stegosaurus_juvenile",
    volume = "400 L",
    mass = "400 kg",
    color = "yellow",
    hp = 100,
    upgrade = { grow_at_age = 1460, monster = "mon_tenontosaurus" },
    inheritance = { add = { flags = { "SWIMS", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_camptosaurus_juvenile",
    name = ccb.content.plural_text("camptosaurus juvenile", "camptosaurus juveniles"),
    copy_from = "mon_tenontosaurus_juvenile",
    volume = "425 L",
    mass = "425 kg",
    color = "yellow",
    upgrade = { grow_at_age = 1460, monster = "mon_camptosaurus" },
}

ccb.content.define_monster {
    id = "mon_iguanodon_juvenile",
    name = ccb.content.plural_text("iguanodon juvenile", "iguanodon juveniles"),
    copy_from = "mon_camptosaurus_juvenile",
    volume = "1000 L",
    mass = "1000 kg",
    hp = 220,
    description = ccb.content.text("A two-legged plant-eating dinosaur juvenile larger than a cow, it could be from a number of different species."),
    color = "yellow",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 1460, monster = "mon_iguanodon" },
    flags = {
        "SEES",
        "HEARS",
        "ANIMAL",
        "PATH_AVOID_DANGER",
        "WARM",
        "NO_BREED",
        "CANPLAY",
        "CAN_BE_CULLED",
        "SWIMS",
    },
}

ccb.content.define_monster {
    id = "mon_eolambia_juvenile",
    name = ccb.content.plural_text("eolambia juvenile", "eolambia juveniles"),
    copy_from = "mon_iguanodon_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_eolambia" },
}

ccb.content.define_monster {
    id = "mon_hadrosaurus_juvenile",
    name = ccb.content.plural_text("hadrosaurus juvenile", "hadrosaurus juveniles"),
    copy_from = "mon_iguanodon_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_hadrosaurus" },
}

ccb.content.define_monster {
    id = "mon_maiasaura_juvenile",
    name = ccb.content.plural_text("maiasaura juvenile", "maiasaura juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_maiasaura" },
}

ccb.content.define_monster {
    id = "mon_gryposaurus_juvenile",
    name = ccb.content.plural_text("gryposaurus juvenile", "gryposaurus juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_gryposaurus" },
}

ccb.content.define_monster {
    id = "mon_prosaurolophus_juvenile",
    name = ccb.content.plural_text("prosaurolophus juvenile", "prosaurolophus juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_prosaurolophus" },
}

ccb.content.define_monster {
    id = "mon_saurolophus_juvenile",
    name = ccb.content.plural_text("saurolophus juvenile", "saurolophus juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_saurolophus" },
}

ccb.content.define_monster {
    id = "mon_edmontosaurus_juvenile",
    name = ccb.content.plural_text("edmontosaurus juvenile", "edmontosaurus juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_edmontosaurus" },
}

ccb.content.define_monster {
    id = "mon_parasaurolophus_juvenile",
    name = ccb.content.plural_text("parasaurolophus juvenile", "parasaurolophus juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_parasaurolophus" },
}

ccb.content.define_monster {
    id = "mon_lambeosaurus_juvenile",
    name = ccb.content.plural_text("lambeosaurus juvenile", "lambeosaurus juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_lambeosaurus" },
}

ccb.content.define_monster {
    id = "mon_corythosaurus_juvenile",
    name = ccb.content.plural_text("corythosaurus juvenile", "corythosaurus juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_corythosaurus" },
}

ccb.content.define_monster {
    id = "mon_hypacrosaurus_juvenile",
    name = ccb.content.plural_text("hypacrosaurus juvenile", "hypacrosaurus juveniles"),
    copy_from = "mon_hadrosaurus_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_hypacrosaurus" },
}

ccb.content.define_monster {
    id = "mon_pachycephalosaurus_juvenile",
    name = ccb.content.plural_text("pachycephalosaurus juvenile", "pachycephalosaurus juveniles"),
    copy_from = "mon_stegosaurus_juvenile",
    upgrade = { grow_at_age = 70, monster = "mon_pachycephalosaurus" },
}

ccb.content.define_monster {
    id = "mon_leptoceratops_juvenile",
    name = ccb.content.plural_text("leptoceratops juvenile", "leptoceratops juveniles"),
    description = ccb.content.text("A four-legged plant-eating dinosaur juvenile with a beak and head crest."),
    copy_from = "mon_leptoceratops",
    volume = "50 L",
    mass = "50 kg",
    body_type = "bear",
    hp = 30,
    upgrade = { grow_at_age = 17, monster = "mon_leptoceratops" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } } },
}

ccb.content.define_monster {
    id = "mon_zuniceratops_juvenile",
    name = ccb.content.plural_text("zuniceratops juvenile", "zuniceratops juveniles"),
    description = ccb.content.text("A four-legged plant-eating dinosaur juvenile with a tall thin bony head crest, two brow horns, and a beak."),
    copy_from = "mon_zuniceratops",
    volume = "90 L",
    mass = "90 kg",
    hp = 55,
    upgrade = { grow_at_age = 29, monster = "mon_pachyrhinosaurus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } } },
}

ccb.content.define_monster {
    id = "mon_lokiceratops_juvenile",
    name = ccb.content.plural_text("lokiceratops juvenile", "lokiceratops juveniles"),
    description = ccb.content.text("A four-legged plant-eating dinosaur juvenile with a bony head crest with two horns pointing out and curving down, two brow horns, and a beak."),
    copy_from = "mon_lokiceratops",
    hp = 200,
    upgrade = { grow_at_age = 365, monster = "mon_lokiceratops" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } } },
}

ccb.content.define_monster {
    id = "mon_styracosaurus_juvenile",
    name = ccb.content.plural_text("styracosaurus juvenile", "styracosaurus juveniles"),
    description = ccb.content.text("A huge four-legged plant-eating dinosaur juvenile with a beak, a bony crest with spikes, and a horn above the nose."),
    copy_from = "mon_styracosaurus",
    hp = 90,
    upgrade = { grow_at_age = 1460, monster = "mon_styracosaurus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } } },
}

ccb.content.define_monster {
    id = "mon_centrosaurus_juvenile",
    name = ccb.content.plural_text("centrosaurus juvenile", "centrosaurus juveniles"),
    description = ccb.content.text("A huge four-legged plant-eating dinosaur juvenile with a beak and a horn above the nose."),
    copy_from = "mon_centrosaurus",
    hp = 90,
    upgrade = { grow_at_age = 1460, monster = "mon_centrosaurus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } } },
}

ccb.content.define_monster {
    id = "mon_einiosaurus_juvenile",
    name = ccb.content.plural_text("einiosaurus juvenile", "einiosaurus juveniles"),
    description = ccb.content.text("A four-legged plant-eating dinosaur juvenile with a beak and a horn curved forward above the nose."),
    copy_from = "mon_einiosaurus",
    volume = "650 L",
    mass = "650 kg",
    hp = 75,
    upgrade = { grow_at_age = 1460, monster = "mon_einiosaurus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_achelousaurus_juvenile",
    name = ccb.content.plural_text("achelousaurus juvenile", "achelousaurus juveniles"),
    description = ccb.content.text("A four-legged plant-eating dinosaur juvenile with a tall bony crest with two curved spikes and three rough bosses above the eyes and nose as well as a short tail and hooked beak."),
    copy_from = "mon_achelousaurus",
    hp = 125,
    upgrade = { grow_at_age = 1460, monster = "mon_achelousaurus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } } },
}

ccb.content.define_monster {
    id = "mon_pachyrhinosaurus_juvenile",
    name = ccb.content.plural_text("pachyrhinosaurus juvenile", "pachyrhinosaurus juveniles"),
    description = ccb.content.text("A huge four-legged plant-eating dinosaur juvenile with a beak, two horns, and a broad bony nose."),
    copy_from = "mon_pachyrhinosaurus",
    hp = 200,
    upgrade = { grow_at_age = 1460, monster = "mon_pachyrhinosaurus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } } },
}

ccb.content.define_monster {
    id = "mon_chasmosaurus_juvenile",
    name = ccb.content.plural_text("chasmosaurus juvenile", "chasmosaurus juveniles"),
    copy_from = "mon_triceratops_juvenile",
    hp = 90,
    upgrade = { grow_at_age = 1460, monster = "mon_chasmosaurus" },
}

ccb.content.define_monster {
    id = "mon_pentaceratops_juvenile",
    name = ccb.content.plural_text("pentaceratops juvenile", "pentaceratops juveniles"),
    copy_from = "mon_triceratops_juvenile",
    hp = 115,
    upgrade = { grow_at_age = 1460, monster = "mon_pentaceratops" },
}

ccb.content.define_monster {
    id = "mon_kosmoceratops_juvenile",
    name = ccb.content.plural_text("kosmoceratops juvenile", "kosmoceratops juveniles"),
    copy_from = "mon_kosmoceratops",
    volume = "600 L",
    mass = "600 kg",
    hp = 75,
    upgrade = { grow_at_age = 200, monster = "mon_kosmoceratops" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_torosaurus_juvenile",
    name = ccb.content.plural_text("torosaurus juvenile", "torosaurus juveniles"),
    copy_from = "mon_triceratops_juvenile",
    upgrade = { grow_at_age = 1460, monster = "mon_torosaurus" },
}

ccb.content.define_monster {
    id = "mon_triceratops_juvenile",
    name = ccb.content.plural_text("triceratops juvenile", "triceratops juveniles"),
    description = ccb.content.text("A huge four-legged plant-eating dinosaur juvenile with a bony crest, beak, and horns."),
    copy_from = "mon_triceratops",
    hp = 200,
    upgrade = { grow_at_age = 1460, monster = "mon_triceratops" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED" } } },
}

ccb.content.define_monster {
    id = "mon_thescelosaurus_juvenile",
    name = ccb.content.plural_text("thescelosaurus juvenile", "thescelosaurus juveniles"),
    description = ccb.content.text("A two-legged plant-eating dinosaur juvenile with strong arms and a long toothy beak."),
    copy_from = "mon_thescelosaurus",
    hp = 70,
    upgrade = { grow_at_age = 60, monster = "mon_thescelosaurus" },
    inheritance = { add = { flags = { "CANPLAY", "NO_BREED", "CAN_BE_CULLED" } } },
}

ccb.content.define_monster {
    id = "mon_pteranodon_juvenile",
    name = ccb.content.plural_text("pteranodon juvenile", "pteranodon juveniles"),
    description = ccb.content.text("A small winged dinosaur juvenile with huge shiny eyes, it could be from a number of different species."),
    default_faction = "pteranodon_young",
    copy_from = "mon_gallimimus_juvenile",
    color = "light_gray_yellow",
    upgrade = { grow_at_age = 30, monster = "mon_pteranodon" },
    pet = { food = { "DINOFOOD_B" } },
    flags = {
        "SEES", "HEARS", "FLIES", "ANIMAL", "PATH_AVOID_DANGER", "WARM", "CANPLAY", "NO_BREED",
        "HIT_AND_RUN", "CAN_BE_CULLED",
    },
}

ccb.content.define_monster {
    id = "mon_quetzalcoatlus_juvenile",
    name = ccb.content.plural_text("quetzalcoatlus juvenile", "quetzalcoatlus juveniles"),
    default_faction = "quetzalcoatlus_juvenile",
    copy_from = "mon_pteranodon_juvenile",
    upgrade = { grow_at_age = 40, monster = "mon_quetzalcoatlus" },
}

ccb.content.define_monster {
    id = "mon_mosasaurus_juvenile",
    name = ccb.content.plural_text("mosasaurus juvenile", "mosasaurus juveniles"),
    description = ccb.content.text("A juvenile predatory aquatic reptile with large pointy teeth, but not the largest."),
    default_faction = "mosasaurus_juvenile",
    copy_from = "mon_mosasaurus",
    volume = "750 L",
    mass = "750 kg",
    aggression = 50,
    hp = 100,
    upgrade = { grow_at_age = 365, monster = "mon_mosasaurus" },
    pet = { food = { "DINOFOOD_B" } },
    flags = { "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "CANPLAY", "NO_BREED", "SWIMS", "AQUATIC" },
}

ccb.content.define_monster {
    id = "mon_shonisaurus_juvenile",
    name = ccb.content.plural_text("shonisaurus juvenile", "shonisaurus juveniles"),
    description = ccb.content.text("A juvenile predatory aquatic reptile with large pointy teeth and a long snout."),
    default_faction = "shonisaurus_juvenile",
    copy_from = "mon_shonisaurus",
    volume = "750 L",
    mass = "750 kg",
    aggression = 50,
    hp = 100,
    upgrade = { grow_at_age = 365, monster = "mon_shonisaurus" },
    pet = { food = { "DINOFOOD_B" } },
    flags = { "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "CANPLAY", "NO_BREED", "SWIMS", "AQUATIC" },
}

ccb.content.define_monster {
    id = "mon_plesiosaurus_juvenile",
    name = ccb.content.plural_text("plesiosaurus juvenile", "plesiosaurus juveniles"),
    description = ccb.content.text("A juvenile predatory aquatic reptile with large pointy teeth and a long neck."),
    default_faction = "plesiosaurus",
    copy_from = "mon_plesiosaurus",
    volume = "750 L",
    mass = "750 kg",
    aggression = 50,
    hp = 80,
    upgrade = { grow_at_age = 365, monster = "mon_plesiosaurus" },
    pet = { food = { "DINOFOOD_B" } },
    flags = { "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "CANPLAY", "NO_BREED", "SWIMS", "AQUATIC" },
}
