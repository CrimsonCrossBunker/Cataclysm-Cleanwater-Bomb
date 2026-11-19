local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_tawa_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "tawa_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_tawa" },
}

ccb.content.define_monster {
    id = "mon_coelophysis_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "coelophysis_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_coelophysis" },
}

ccb.content.define_monster {
    id = "mon_dilophosaurus_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "dilophosaurus_hatchling",
    mass = "2 kg",
    volume = "2 L",
    upgrade = { grow_at_age = 20, monster = "mon_dilophosaurus_juvenile" },
    inheritance = { add = { flags = { "SWIMS" } } },
}

ccb.content.define_monster {
    id = "mon_ceratosaurus_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "ceratosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_ceratosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_spinosaurus_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "spinosaurus_hatchling",
    mass = "4 kg",
    volume = "4 L",
    upgrade = { grow_at_age = 30, monster = "mon_spinosaurus_juvenile" },
    inheritance = { add = { flags = { "SWIMS" } } },
}

ccb.content.define_monster {
    id = "mon_torvosaurus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    copy_from = "mon_dilophosaurus_hatchling",
    default_faction = "torvosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_torvosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_allosaurus_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "allosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_allosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_acrocanthosaurus_hatchling",
    copy_from = "mon_allosaurus_hatchling",
    default_faction = "acrocanthosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_acrocanthosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_giganotosaurus_hatchling",
    copy_from = "mon_allosaurus_hatchling",
    default_faction = "giganotosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_giganotosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_siats_hatchling",
    copy_from = "mon_allosaurus_hatchling",
    default_faction = "siats_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_siats_juvenile" },
}

ccb.content.define_monster {
    id = "mon_dryptosaurus_hatchling",
    copy_from = "mon_allosaurus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "dryptosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_dryptosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_nanotyrannus_hatchling",
    copy_from = "mon_allosaurus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "nanotyrannus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_nanotyrannus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_appalachiosaurus_hatchling",
    copy_from = "mon_dryptosaurus_hatchling",
    default_faction = "appalachiosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_appalachiosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_gorgosaurus_hatchling",
    copy_from = "mon_dryptosaurus_hatchling",
    default_faction = "gorgosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_gorgosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_albertosaurus_hatchling",
    copy_from = "mon_dryptosaurus_hatchling",
    default_faction = "albertosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_albertosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_qianzhousaurus_hatchling",
    copy_from = "mon_dryptosaurus_hatchling",
    default_faction = "qianzhousaurus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_qianzhousaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_nanuqsaurus_hatchling",
    copy_from = "mon_dryptosaurus_hatchling",
    default_faction = "daspletosaurus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_nanuqsaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_daspletosaurus_hatchling",
    copy_from = "mon_dryptosaurus_hatchling",
    default_faction = "daspletosaurus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_daspletosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_tyrannosaurus_hatchling",
    copy_from = "mon_spinosaurus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "tyrannosaurus_hatchling",
    dissect = "dissect_tyrant_sample_single",
    upgrade = { grow_at_age = 30, monster = "mon_tyrannosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    description = ccb.content.text("A tiny dinosaur hatchling with huge shiny eyes, it could be from a number of different species."),
    default_faction = "compsognathus_hatchling",
    categories = { "DINOSAUR", "WILDLIFE" },
    species = { "DINOSAUR" },
    volume = "50 ml",
    mass = "57 g",
    hp = 2,
    speed = 40,
    materials = { "flesh" },
    symbol = "v",
    color = "green_yellow",
    looks_like = "mon_compsognathus",
    aggression = -99,
    morale = -8,
    melee_skill = 1,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 1,
    upgrade = { grow_at_age = 14, monster = "mon_compsognathus" },
    biosignature = { item = "feces_dino", interval = 3 },
    pet = { food = { "DINOFOOD_B" } },
    flags = {
        "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "WARM", "STUMBLES", "NO_BREED", "CANPLAY",
        "CAN_BE_CULLED", "GUILT_ANIMAL",
    },
    harvest = "bird_tiny",
    death = { outcome = { spell = { id = "death_guilt", min_level = 3 } } },
}

ccb.content.define_monster {
    id = "mon_nedcolbertia_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    default_faction = "herbivore_young",
    color = "light_green_yellow",
    upgrade = { grow_at_age = 20, monster = "mon_nedcolbertia_juvenile" },
    pet = { food = { "DINOFOOD_A", "DINOFOOD_B", "DINOFOOD_C" } },
    flags = {
        "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "WARM", "CANPLAY", "STUMBLES", "NO_BREED",
        "CAN_BE_CULLED", "GUILT_ANIMAL",
    },
    death = { outcome = { spell = { id = "death_guilt", min_level = 3 } } },
}

ccb.content.define_monster {
    id = "mon_gallimimus_hatchling",
    copy_from = "mon_nedcolbertia_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_gallimimus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_struthiomimus_hatchling",
    copy_from = "mon_gallimimus_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_struthiomimus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_ornithomimus_hatchling",
    copy_from = "mon_gallimimus_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_ornithomimus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_albertonykus_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "insectivore_young",
    color = "light_green_yellow",
    upgrade = { grow_at_age = 25, monster = "mon_albertonykus" },
    pet = { food = { "DINOFOOD_A", "DINOFOOD_B" } },
    flags = {
        "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "WARM", "CANPLAY", "STUMBLES", "NO_BREED",
        "CAN_BE_CULLED", "GUILT_ANIMAL",
    },
    death = { outcome = { spell = { id = "death_guilt", min_level = 3 } } },
}

ccb.content.define_monster {
    id = "mon_falcarius_hatchling",
    copy_from = "mon_gallimimus_hatchling",
    name = ccb.content.plural_text("long neck hatchling", "long neck hatchlings"),
    upgrade = { grow_at_age = 35, monster = "mon_falcarius_juvenile" },
}

ccb.content.define_monster {
    id = "mon_therizinosaurus_hatchling",
    copy_from = "mon_gallimimus_hatchling",
    name = ccb.content.plural_text("long neck hatchling", "long neck hatchlings"),
    upgrade = { grow_at_age = 50, monster = "mon_therizinosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_nothronychus_hatchling",
    copy_from = "mon_gallimimus_hatchling",
    name = ccb.content.plural_text("long neck hatchling", "long neck hatchlings"),
    upgrade = { grow_at_age = 40, monster = "mon_nothronychus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_anzu_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("long neck hatchling", "long neck hatchlings"),
    default_faction = "anzu_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_anzu_juvenile" },
    pet = { food = { "DINOFOOD_A", "DINOFOOD_B", "DINOFOOD_C" } },
}

ccb.content.define_monster {
    id = "mon_saurornitholestes_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "saurornitholestes_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_saurornitholestes" },
}

ccb.content.define_monster {
    id = "mon_velociraptor_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "velociraptor_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_velociraptor" },
}

ccb.content.define_monster {
    id = "mon_deinonychus_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "deinonychus_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_deinonychus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_utahraptor_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "utahraptor_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_utahraptor_juvenile" },
}

ccb.content.define_monster {
    id = "mon_dromaeosaurus_hatchling",
    copy_from = "mon_velociraptor_hatchling",
    default_faction = "dromaeosaurus_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_dromaeosaurus" },
}

ccb.content.define_monster {
    id = "mon_stenonychosaurus_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "stenonychosaurus_hatchling",
    upgrade = { grow_at_age = 20, monster = "mon_stenonychosaurus" },
}

ccb.content.define_monster {
    id = "mon_eoraptor_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("predator hatchling", "predator hatchlings"),
    default_faction = "eoraptor",
    pet = { food = { "DINOFOOD_A", "DINOFOOD_B", "DINOFOOD_C" } },
    upgrade = { grow_at_age = 14, monster = "mon_eoraptor" },
}

ccb.content.define_monster {
    id = "mon_sarahsaurus_hatchling",
    name = ccb.content.plural_text("long neck hatchling", "long neck hatchlings"),
    copy_from = "mon_gallimimus_hatchling",
    mass = "2 kg",
    volume = "2 L",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 40, monster = "mon_sarahsaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_anchisaurus_hatchling",
    name = ccb.content.plural_text("long neck hatchling", "long neck hatchlings"),
    copy_from = "mon_gallimimus_hatchling",
    mass = "2 kg",
    volume = "2 L",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 20, monster = "mon_anchisaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_issi_hatchling",
    name = ccb.content.plural_text("long neck hatchling", "long neck hatchlings"),
    copy_from = "mon_gallimimus_hatchling",
    mass = "2 kg",
    volume = "2 L",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 40, monster = "mon_issi_juvenile" },
}

ccb.content.define_monster {
    id = "mon_moabosaurus_hatchling",
    copy_from = "mon_amargasaurus_hatchling",
    upgrade = { grow_at_age = 45, monster = "mon_moabosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_haplocanthosaurus_hatchling",
    copy_from = "mon_amargasaurus_hatchling",
    upgrade = { grow_at_age = 45, monster = "mon_haplocanthosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_amargasaurus_hatchling",
    name = ccb.content.plural_text("long neck hatchling", "long neck hatchlings"),
    copy_from = "mon_gallimimus_hatchling",
    mass = "4 kg",
    volume = "4 L",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 50, monster = "mon_amargasaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_apatosaurus_hatchling",
    copy_from = "mon_amargasaurus_hatchling",
    upgrade = { grow_at_age = 50, monster = "mon_apatosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_brontosaurus_hatchling",
    copy_from = "mon_apatosaurus_hatchling",
    upgrade = { grow_at_age = 50, monster = "mon_brontosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_diplodocus_hatchling",
    copy_from = "mon_apatosaurus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_diplodocus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_barosaurus_hatchling",
    copy_from = "mon_apatosaurus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_barosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_camarasaurus_hatchling",
    copy_from = "mon_apatosaurus_hatchling",
    upgrade = { grow_at_age = 50, monster = "mon_camarasaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_brachiosaurus_hatchling",
    copy_from = "mon_apatosaurus_hatchling",
    upgrade = { grow_at_age = 50, monster = "mon_brachiosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_astrodon_hatchling",
    copy_from = "mon_apatosaurus_hatchling",
    upgrade = { grow_at_age = 50, monster = "mon_astrodon_juvenile" },
}

ccb.content.define_monster {
    id = "mon_alamosaurus_hatchling",
    copy_from = "mon_apatosaurus_hatchling",
    upgrade = { grow_at_age = 50, monster = "mon_alamosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_scutellosaurus_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("stocky hatchling", "stocky hatchlings"),
    default_faction = "herbivore_young",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 30, monster = "mon_scutellosaurus" },
}

ccb.content.define_monster {
    id = "mon_stegosaurus_hatchling",
    copy_from = "mon_gallimimus_hatchling",
    name = ccb.content.plural_text("stocky hatchling", "stocky hatchlings"),
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 30, monster = "mon_stegosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_hesperosaurus_hatchling",
    copy_from = "mon_gallimimus_hatchling",
    name = ccb.content.plural_text("stocky hatchling", "stocky hatchlings"),
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 30, monster = "mon_hesperosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_gastonia_hatchling",
    copy_from = "mon_stegosaurus_hatchling",
    name = ccb.content.plural_text("stocky hatchling", "stocky hatchlings"),
    upgrade = { grow_at_age = 30, monster = "mon_gastonia_juvenile" },
}

ccb.content.define_monster {
    id = "mon_gargoyleosaurus_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_gargoyleosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_sauropelta_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_sauropelta_juvenile" },
}

ccb.content.define_monster {
    id = "mon_nodosaurus_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_nodosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_panoplosaurus_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_panoplosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_edmontonia_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_edmontonia_juvenile" },
}

ccb.content.define_monster {
    id = "mon_zuul_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_zuul_juvenile" },
}

ccb.content.define_monster {
    id = "mon_dyoplosaurus_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_dyoplosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_ankylosaurus_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_ankylosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_euoplocephalus_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_euoplocephalus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_scolosaurus_hatchling",
    copy_from = "mon_gastonia_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_scolosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_tenontosaurus_hatchling",
    copy_from = "mon_scutellosaurus_hatchling",
    name = ccb.content.plural_text("long tailed hatchling", "long tailed hatchlings"),
    upgrade = { grow_at_age = 30, monster = "mon_tenontosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_dryosaurus_hatchling",
    copy_from = "mon_scutellosaurus_hatchling",
    name = ccb.content.plural_text("long tailed hatchling", "long tailed hatchlings"),
    upgrade = { grow_at_age = 30, monster = "mon_dryosaurus" },
}

ccb.content.define_monster {
    id = "mon_camptosaurus_hatchling",
    copy_from = "mon_dyoplosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    upgrade = { grow_at_age = 20, monster = "mon_camptosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_iguanodon_hatchling",
    copy_from = "mon_camptosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    upgrade = { grow_at_age = 30, monster = "mon_iguanodon_juvenile" },
}

ccb.content.define_monster {
    id = "mon_eolambia_hatchling",
    copy_from = "mon_camptosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    upgrade = { grow_at_age = 30, monster = "mon_eolambia_juvenile" },
}

ccb.content.define_monster {
    id = "mon_hadrosaurus_hatchling",
    copy_from = "mon_camptosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    upgrade = { grow_at_age = 30, monster = "mon_hadrosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_maiasaura_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_maiasaura_juvenile" },
}

ccb.content.define_monster {
    id = "mon_gryposaurus_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 25, monster = "mon_gryposaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_prosaurolophus_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_prosaurolophus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_saurolophus_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_saurolophus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_edmontosaurus_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 50, monster = "mon_edmontosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_parasaurolophus_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_parasaurolophus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_lambeosaurus_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_lambeosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_corythosaurus_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_corythosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_hypacrosaurus_hatchling",
    copy_from = "mon_hadrosaurus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_hypacrosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_stegoceras_hatchling",
    copy_from = "mon_scutellosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    upgrade = { grow_at_age = 25, monster = "mon_stegoceras" },
}

ccb.content.define_monster {
    id = "mon_pachycephalosaurus_hatchling",
    copy_from = "mon_edmontosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    upgrade = { grow_at_age = 20, monster = "mon_pachycephalosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_aquilops_hatchling",
    copy_from = "mon_scutellosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    upgrade = { grow_at_age = 30, monster = "mon_aquilops" },
}

ccb.content.define_monster {
    id = "mon_leptoceratops_hatchling",
    copy_from = "mon_pachycephalosaurus_hatchling",
    name = ccb.content.plural_text("beaked hatchling", "beaked hatchlings"),
    dissect = "dissect_horns_sample_single",
    upgrade = { grow_at_age = 30, monster = "mon_leptoceratops_juvenile" },
}

ccb.content.define_monster {
    id = "mon_zuniceratops_hatchling",
    copy_from = "mon_leptoceratops_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_zuniceratops_juvenile" },
}

ccb.content.define_monster {
    id = "mon_lokiceratops_hatchling",
    copy_from = "mon_leptoceratops_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_lokiceratops_juvenile" },
}

ccb.content.define_monster {
    id = "mon_styracosaurus_hatchling",
    copy_from = "mon_leptoceratops_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_styracosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_centrosaurus_hatchling",
    copy_from = "mon_leptoceratops_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_centrosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_einiosaurus_hatchling",
    copy_from = "mon_leptoceratops_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_einiosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_achelousaurus_hatchling",
    copy_from = "mon_leptoceratops_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_achelousaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_pachyrhinosaurus_hatchling",
    copy_from = "mon_leptoceratops_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_pachyrhinosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_chasmosaurus_hatchling",
    copy_from = "mon_pachyrhinosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_chasmosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_pentaceratops_hatchling",
    copy_from = "mon_pachyrhinosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_pentaceratops_juvenile" },
}

ccb.content.define_monster {
    id = "mon_kosmoceratops_hatchling",
    copy_from = "mon_pachyrhinosaurus_hatchling",
    upgrade = { grow_at_age = 56, monster = "mon_kosmoceratops_juvenile" },
}

ccb.content.define_monster {
    id = "mon_torosaurus_hatchling",
    copy_from = "mon_pachyrhinosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_torosaurus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_triceratops_hatchling",
    copy_from = "mon_pachyrhinosaurus_hatchling",
    upgrade = { grow_at_age = 30, monster = "mon_triceratops_juvenile" },
}

ccb.content.define_monster {
    id = "mon_nanosaurus_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("stocky hatchling", "stocky hatchlings"),
    default_faction = "herbivore_young",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 10, monster = "mon_nanosaurus" },
}

ccb.content.define_monster {
    id = "mon_fona_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("stocky hatchling", "stocky hatchlings"),
    default_faction = "herbivore_young",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 30, monster = "mon_fona" },
}

ccb.content.define_monster {
    id = "mon_oryctodromeus_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("stocky hatchling", "stocky hatchlings"),
    default_faction = "herbivore_young",
    pet = { food = { "DINOFOOD_C" } },
    upgrade = { grow_at_age = 30, monster = "mon_oryctodromeus" },
}

ccb.content.define_monster {
    id = "mon_thescelosaurus_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("stocky hatchling", "stocky hatchlings"),
    default_faction = "herbivore_young",
    color = "light_gray",
    upgrade = { grow_at_age = 20, monster = "mon_thescelosaurus_juvenile" },
    pet = { food = { "DINOFOOD_A", "DINOFOOD_B", "DINOFOOD_C" } },
    flags = {
        "SEES", "HEARS", "ANIMAL", "PATH_AVOID_DANGER", "WARM", "CANPLAY", "STUMBLES", "NO_BREED",
        "CAN_BE_CULLED", "GUILT_ANIMAL",
    },
    death = { outcome = { spell = { id = "death_guilt", min_level = 3 } } },
}

-- Adult dimorphodon is only 2 kg, 1.5 L
ccb.content.define_monster {
    id = "mon_dimorphodon_hatchling",
    copy_from = "mon_compsognathus_hatchling",
    name = ccb.content.plural_text("winged hatchling", "winged hatchlings"),
    default_faction = "dimorphodon",
    volume = "1 L",
    mass = "1 kg",
    hp = 1,
    upgrade = { grow_at_age = 20, monster = "mon_dimorphodon" },
}

ccb.content.define_monster {
    id = "mon_pteranodon_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("winged hatchling", "winged hatchlings"),
    default_faction = "pteranodon_young",
    upgrade = { grow_at_age = 30, monster = "mon_pteranodon_juvenile" },
}

ccb.content.define_monster {
    id = "mon_quetzalcoatlus_hatchling",
    copy_from = "mon_dilophosaurus_hatchling",
    name = ccb.content.plural_text("winged hatchling", "winged hatchlings"),
    default_faction = "quetzalcoatlus_hatchling",
    upgrade = { grow_at_age = 40, monster = "mon_quetzalcoatlus_juvenile" },
}

ccb.content.define_monster {
    id = "mon_mosasaurus_hatchling",
    copy_from = "mon_spinosaurus_hatchling",
    name = ccb.content.plural_text("mosasaurus neonate", "mosasaurus neonates"),
    description = ccb.content.text("A tiny aquatic reptile neonate with huge shiny eyes and pointy little teeth."),
    default_faction = "mosasaurus_hatchling",
    harvest = "mammal_tiny",
    upgrade = { grow_at_age = 30, monster = "mon_mosasaurus_juvenile" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "AQUATIC", "WATER_CAMOUFLAGE" } } },
    death = { outcome = { spell = { id = "death_guilt", min_level = 3 } } },
}

ccb.content.define_monster {
    id = "mon_shonisaurus_hatchling",
    copy_from = "mon_spinosaurus_hatchling",
    name = ccb.content.plural_text("shonisaurus neonate", "shonisaurus neonates"),
    description = ccb.content.text("A tiny aquatic reptile neonate with huge shiny eyes and pointy little teeth."),
    default_faction = "shonisaurus_hatchling",
    harvest = "mammal_tiny",
    upgrade = { grow_at_age = 30, monster = "mon_shonisaurus_juvenile" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "AQUATIC", "WATER_CAMOUFLAGE" } } },
    death = { outcome = { spell = { id = "death_guilt", min_level = 3 } } },
}

ccb.content.define_monster {
    id = "mon_plesiosaurus_hatchling",
    copy_from = "mon_spinosaurus_hatchling",
    name = ccb.content.plural_text("plesiosaurus neonate", "plesiosaurus neonates"),
    description = ccb.content.text("A tiny aquatic reptile neonate with huge shiny eyes, a long neck, and pointy little teeth."),
    default_faction = "plesiosaurus",
    harvest = "mammal_tiny",
    upgrade = { grow_at_age = 30, monster = "mon_plesiosaurus_juvenile" },
    pet = { food = { "DINOFOOD_B" } },
    inheritance = { add = { flags = { "AQUATIC", "WATER_CAMOUFLAGE" } } },
    death = { outcome = { spell = { id = "death_guilt", min_level = 3 } } },
}
