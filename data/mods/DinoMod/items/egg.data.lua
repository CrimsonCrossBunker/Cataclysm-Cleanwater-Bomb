local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_dino",
    name = ccb.content.text("dinosaur egg"),
    looks_like = "egg_chicken",
    mass = "2 kg",
    color = "green",
    symbol = "o",
    description = ccb.content.text("Pale, round egg laid by a dinosaur."),
    price = "125 cent",
    materials = { "egg" },
    volume = "1700 ml",
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "32 days",
        kind = "FOOD",
        quench = 4,
        calories = 2600,
        fun = -6,
        rot_spawn = { group = "GROUP_EGG_DINO", chance = 70 },
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "egg_dino_small",
    name = ccb.content.text("small dinosaur egg"),
    copy_from = "egg_dino",
    mass = "57 g",
    description = ccb.content.text("Pale, round egg laid by a smaller dinosaur."),
    materials = { "egg" },
    volume = "12 ml",
    comestible = {
        shelf_life = "16 days",
        kind = "FOOD",
        quench = 4,
        healthy = 1,
        calories = 80,
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_DINO_SMALL" } } },
}

ccb.content.define_item {
    id = "egg_dino_large",
    name = ccb.content.text("large dinosaur egg"),
    copy_from = "egg_dino",
    mass = "4 kg",
    description = ccb.content.text("Pale, round egg laid by a larger dinosaur."),
    materials = { "egg" },
    volume = "3400 ml",
    comestible = {
        shelf_life = "64 days",
        kind = "FOOD",
        calories = 5200,
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_DINO_LARGE" } } },
}

ccb.content.define_item {
    id = "egg_dino_theropod",
    name = ccb.content.text("dinosaur egg"),
    looks_like = "egg_chicken",
    mass = "2 kg",
    color = "green",
    symbol = "O",
    description = ccb.content.text("Pale, football-shaped egg laid by a dinosaur."),
    price = "125 cent",
    materials = { "egg" },
    volume = "1700 ml",
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "32 days",
        kind = "FOOD",
        quench = 4,
        healthy = 1,
        calories = 2600,
        fun = -6,
        rot_spawn = { group = "GROUP_EGG_THEROPOD", chance = 70 },
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "egg_dino_theropod_small",
    name = ccb.content.text("small dinosaur egg"),
    copy_from = "egg_dino_small",
    looks_like = "egg_chicken",
    description = ccb.content.text("Pale, football-shaped egg laid by a smaller dinosaur."),
    materials = { "egg" },
    comestible = { kind = "FOOD", vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_THEROPOD_SMALL" } } },
}

ccb.content.define_item {
    id = "egg_dino_theropod_large",
    name = ccb.content.text("large dinosaur egg"),
    copy_from = "egg_dino",
    looks_like = "egg_chicken",
    mass = "4 kg",
    description = ccb.content.text("Pale, football-shaped egg laid by a larger dinosaur."),
    materials = { "egg" },
    volume = "3400 ml",
    comestible = { kind = "FOOD", calories = 5200, vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_THEROPOD_LARGE" } } },
}

ccb.content.define_item {
    id = "egg_tawa",
    name = ccb.content.text("tawa egg"),
    copy_from = "egg_dino_theropod_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_tawa_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_coelophysis",
    name = ccb.content.text("coelophysis egg"),
    copy_from = "egg_dino_theropod_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_coelophysis_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_dilophosaurus",
    name = ccb.content.text("dilophosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_dilophosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_ceratosaurus",
    name = ccb.content.text("ceratosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_ceratosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_spinosaurus",
    name = ccb.content.text("spinosaurus egg"),
    copy_from = "egg_dino_theropod_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_spinosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_torvosaurus",
    name = ccb.content.text("torvosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_torvosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_allosaurus",
    name = ccb.content.text("allosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_allosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_acrocanthosaurus",
    name = ccb.content.text("acrocanthosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_acrocanthosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_giganotosaurus",
    name = ccb.content.text("giganotosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_giganotosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_siats",
    name = ccb.content.text("siats egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_siats_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_dryptosaurus",
    name = ccb.content.text("dryptosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_dryptosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_nanotyrannus",
    name = ccb.content.text("nanotyrannus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_nanotyrannus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_appalachiosaurus",
    name = ccb.content.text("appalachiosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_appalachiosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_gorgosaurus",
    name = ccb.content.text("gorgosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_gorgosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_albertosaurus",
    name = ccb.content.text("albertosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_albertosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_qianzhousaurus",
    name = ccb.content.text("qianzhousaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_qianzhousaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_nanuqsaurus",
    name = ccb.content.text("nanuqsaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_nanuqsaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_daspletosaurus",
    name = ccb.content.text("daspletosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_daspletosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_tyrannosaurus",
    name = ccb.content.text("tyrannosaurus egg"),
    copy_from = "egg_dino_theropod_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_tyrannosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_compsognathus",
    name = ccb.content.text("compsognathus egg"),
    copy_from = "egg_dino_theropod_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_compsognathus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_nedcolbertia",
    name = ccb.content.text("nedcolbertia egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_nedcolbertia_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_gallimimus",
    name = ccb.content.text("gallimimus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_gallimimus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_struthiomimus",
    name = ccb.content.text("struthiomimus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_struthiomimus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_ornithomimus",
    name = ccb.content.text("ornithomimus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_ornithomimus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_albertonykus",
    name = ccb.content.text("albertonykus egg"),
    copy_from = "egg_dino_theropod_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_albertonykus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_falcarius",
    name = ccb.content.text("falcarius egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_falcarius_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_therizinosaurus",
    name = ccb.content.text("therizinosaurus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_therizinosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_nothronychus",
    name = ccb.content.text("nothronychus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_nothronychus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_anzu",
    name = ccb.content.text("anzu egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_anzu_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_saurornitholestes",
    name = ccb.content.text("saurornitholestes egg"),
    copy_from = "egg_dino_theropod_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_saurornitholestes_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_velociraptor",
    name = ccb.content.text("velociraptor egg"),
    copy_from = "egg_dino_theropod_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_velociraptor_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_deinonychus",
    name = ccb.content.text("deinonychus egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_deinonychus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_utahraptor",
    name = ccb.content.text("utahraptor egg"),
    copy_from = "egg_dino_theropod",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_utahraptor_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_dromaeosaurus",
    name = ccb.content.text("dromaeosaurus egg"),
    copy_from = "egg_dino_theropod_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_dromaeosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_stenonychosaurus",
    name = ccb.content.text("stenonychosaurus egg"),
    copy_from = "egg_dino_theropod_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_stenonychosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_eoraptor",
    name = ccb.content.text("eoraptor egg"),
    copy_from = "egg_dino_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_eoraptor_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_sarahsaurus",
    name = ccb.content.text("sarahsaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_sarahsaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_anchisaurus",
    name = ccb.content.text("anchisaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_anchisaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_issi",
    name = ccb.content.text("issi egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_issi_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_moabosaurus",
    name = ccb.content.text("moabosaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_moabosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_haplocanthosaurus",
    name = ccb.content.text("haplocanthosaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_haplocanthosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_amargasaurus",
    name = ccb.content.text("amargasaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_amargasaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_apatosaurus",
    name = ccb.content.text("apatosaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_apatosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_brontosaurus",
    name = ccb.content.text("brontosaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_brontosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_diplodocus",
    name = ccb.content.text("diplodocus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_diplodocus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_barosaurus",
    name = ccb.content.text("barosaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_barosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_camarasaurus",
    name = ccb.content.text("camarasaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_camarasaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_brachiosaurus",
    name = ccb.content.text("brachiosaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_brachiosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_astrodon",
    name = ccb.content.text("astrodon egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_astrodon_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_alamosaurus",
    name = ccb.content.text("alamosaurus egg"),
    copy_from = "egg_dino_large",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_alamosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_scutellosaurus",
    name = ccb.content.text("scutellosaurus egg"),
    copy_from = "egg_dino_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_scutellosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_stegosaurus",
    name = ccb.content.text("stegosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_stegosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_hesperosaurus",
    name = ccb.content.text("hesperosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_hesperosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_gastonia",
    name = ccb.content.text("gastonia egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_gastonia_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_gargoyleosaurus",
    name = ccb.content.text("gargoyleosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_gargoyleosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_sauropelta",
    name = ccb.content.text("sauropelta egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_sauropelta_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_nodosaurus",
    name = ccb.content.text("nodosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_nodosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_panoplosaurus",
    name = ccb.content.text("panoplosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_panoplosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_edmontonia",
    name = ccb.content.text("edmontonia egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_edmontonia_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_zuul",
    name = ccb.content.text("zuul egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_zuul_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_dyoplosaurus",
    name = ccb.content.text("dyoplosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_dyoplosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_ankylosaurus",
    name = ccb.content.text("ankylosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_ankylosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_euoplocephalus",
    name = ccb.content.text("euoplocephalus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_euoplocephalus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_scolosaurus",
    name = ccb.content.text("scolosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_scolosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_tenontosaurus",
    name = ccb.content.text("tenontosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_tenontosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_dryosaurus",
    name = ccb.content.text("dryosaurus egg"),
    copy_from = "egg_dino_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_dryosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_camptosaurus",
    name = ccb.content.text("camptosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_camptosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_iguanodon",
    name = ccb.content.text("iguanodon egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_iguanodon_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_eolambia",
    name = ccb.content.text("eolambia egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_eolambia_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_hadrosaurus",
    name = ccb.content.text("hadrosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_hadrosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_maiasaura",
    name = ccb.content.text("maiasaura egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_maiasaura_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_gryposaurus",
    name = ccb.content.text("gryposaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_gryposaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_prosaurolophus",
    name = ccb.content.text("prosaurolophus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_prosaurolophus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_saurolophus",
    name = ccb.content.text("saurolophus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_saurolophus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_edmontosaurus",
    name = ccb.content.text("edmontosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_edmontosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_parasaurolophus",
    name = ccb.content.text("parasaurolophus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_parasaurolophus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_lambeosaurus",
    name = ccb.content.text("lambeosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_lambeosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_corythosaurus",
    name = ccb.content.text("corythosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_corythosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_hypacrosaurus",
    name = ccb.content.text("hypacrosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_hypacrosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_stegoceras",
    name = ccb.content.text("stegoceras egg"),
    copy_from = "egg_dino_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_stegoceras_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_pachycephalosaurus",
    name = ccb.content.text("pachycephalosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_pachycephalosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_aquilops",
    name = ccb.content.text("aquilops egg"),
    copy_from = "egg_dino_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_aquilops_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_leptoceratops",
    name = ccb.content.text("leptoceratops egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_leptoceratops_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_zuniceratops",
    name = ccb.content.text("zuniceratops egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_zuniceratops_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_lokiceratops",
    name = ccb.content.text("lokiceratops egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_lokiceratops_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_styracosaurus",
    name = ccb.content.text("styracosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_styracosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_centrosaurus",
    name = ccb.content.text("centrosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_centrosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_einiosaurus",
    name = ccb.content.text("einiosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_einiosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_achelousaurus",
    name = ccb.content.text("achelousaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_achelousaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_pachyrhinosaurus",
    name = ccb.content.text("pachyrhinosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_pachyrhinosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_chasmosaurus",
    name = ccb.content.text("chasmosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_chasmosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_pentaceratops",
    name = ccb.content.text("pentaceratops egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_pentaceratops_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_kosmoceratops",
    name = ccb.content.text("kosmoceratops egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_kosmoceratops_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_torosaurus",
    name = ccb.content.text("torosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_torosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_triceratops",
    name = ccb.content.text("triceratops egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_triceratops_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_nanosaurus",
    name = ccb.content.text("nanosaurus egg"),
    copy_from = "egg_dino_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_nanosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_fona",
    name = ccb.content.text("fona egg"),
    copy_from = "egg_dino_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fona_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_oryctodromeus",
    name = ccb.content.text("oryctodromeus egg"),
    copy_from = "egg_dino_small",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_oryctodromeus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_thescelosaurus",
    name = ccb.content.text("thescelosaurus egg"),
    copy_from = "egg_dino",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_thescelosaurus_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_dimorphodon",
    name = ccb.content.text("dimorphodon egg"),
    copy_from = "egg_chicken",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_dimorphodon_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_pteranodon",
    name = ccb.content.text("pteranodon egg"),
    copy_from = "egg_chicken",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_pteranodon_hatchling" } } },
}

ccb.content.define_item {
    id = "egg_quetzalcoatlus",
    name = ccb.content.text("quetzalcoatlus egg"),
    copy_from = "egg_chicken",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_quetzalcoatlus_hatchling" } } },
}

ccb.content.define_item {
    id = "boiled_egg_dino_small",
    name = ccb.content.text("small boiled dinosaur egg"),
    copy_from = "egg_dino_small",
    color = "white",
    symbol = "o",
    description = ccb.content.text("A smaller hard-boiled dinosaur egg, still in its shell.  Portable and nutritious!"),
    price = "95 cent",
    survival_price = "50 cent",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = { quench = -1, fun = 2, vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { group = "GROUP_NULL", chance = 0 } } },
}

ccb.content.define_item {
    id = "boiled_egg_dino",
    name = ccb.content.text("boiled dinosaur egg"),
    copy_from = "egg_dino",
    color = "white",
    symbol = "o",
    description = ccb.content.text("A hard-boiled dinosaur egg, still in its shell.  Portable and nutritious!"),
    price = "3 USD 95 cent",
    survival_price = "2 USD",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = { quench = -10, fun = 10, vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { group = "GROUP_NULL", chance = 0 } } },
}

ccb.content.define_item {
    id = "boiled_egg_dino_large",
    name = ccb.content.text("large boiled dinosaur egg"),
    copy_from = "egg_dino_large",
    color = "white",
    symbol = "o",
    description = ccb.content.text("A large hard-boiled dinosaur egg, still in its shell.  It may be wise to disassemble it into two pieces to eat."),
    price = "5 USD 95 cent",
    survival_price = "3 USD",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = { quench = -15, fun = 20, vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { group = "GROUP_NULL", chance = 0 } } },
}
