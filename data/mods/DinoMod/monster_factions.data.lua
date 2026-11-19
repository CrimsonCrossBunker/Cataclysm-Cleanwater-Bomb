local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "very_small_predator",
    base = "cat",
    by_mood = { "small_animal", "very_small_predator" },
    hate = { "tiny_animal" },
}

ccb.content.define_monster_faction {
    id = "small_predator",
    base = "cat",
    by_mood = { "small_predator", "cat", "eoraptor" },
    hate = { "small_animal", "very_small_predator" },
}

ccb.content.define_monster_faction {
    id = "medium_predator",
    base = "wolf",
    by_mood = { "wolf", "medium_predator", "zombie_aquatic" },
}

ccb.content.define_monster_faction {
    id = "predator_dino",
    base = "animal",
    neutral = { "small_animal", "fish" },
    by_mood = { "predator_dino", "animal", "zombie_aquatic" },
    hate = { "herbivore", "zombie", "human" },
}

ccb.content.define_monster_faction {
    id = "herbivore_young",
    base = "small_animal",
    neutral = { "small_animal", "herbivore" },
    friendly = { "herbivore_dino" },
}

ccb.content.define_monster_faction {
    id = "herbivore_dino",
    base = "herbivore",
    neutral = { "herbivore", "small_animal" },
    friendly = { "herbivore_young" },
    hate = { "plant" },
}

ccb.content.define_monster_faction {
    id = "hadrosaur",
    base = "herbivore_dino",
    friendly = { "herbivore_young" },
    hate = { "fungus" },
}

ccb.content.define_monster_faction {
    id = "insectivore_young",
    base = "small_animal",
    neutral = { "small_animal" },
    friendly = { "insectivore_dino" },
}

ccb.content.define_monster_faction {
    id = "insectivore_dino",
    base = "very_small_predator",
    neutral = { "herbivore" },
    friendly = { "insectivore_young" },
    hate = { "insect" },
}

ccb.content.define_monster_faction {
    id = "very_small_mixed",
    base = "very_small_predator",
    neutral = { "fishing_dino", "zombie_aquatic", "mixed_dino" },
    by_mood = { "very_small_mixed", "small_fisher" },
    hate = { "fish", "tiny_animal" },
}

ccb.content.define_monster_faction {
    id = "small_fisher",
    base = "fish",
    neutral = { "fishing_dino", "zombie_aquatic", "mixed_dino" },
    by_mood = { "small_fisher", "very_small_mixed" },
    hate = { "fish" },
}

ccb.content.define_monster_faction {
    id = "small_mixed",
    base = "small_predator",
    neutral = { "fishing_dino", "zombie_aquatic", "mixed_dino" },
    by_mood = { "small_mixed", "small_fisher" },
    hate = { "fish", "tiny_animal" },
}

ccb.content.define_monster_faction {
    id = "medium_mixed",
    base = "big_cat",
    by_mood = { "big_cat", "medium_mixed", "tiny_animal", "aquatic_predator" },
    hate = { "fish" },
}

ccb.content.define_monster_faction {
    id = "medium_fisher",
    base = "aquatic_predator",
    by_mood = { "small_fisher", "medium_fisher", "aquatic_predator" },
}

ccb.content.define_monster_faction {
    id = "mixed_dino",
    base = "mutant_piscivores",
    neutral = { "small_animal", "small_fisher" },
    hate = { "herbivore", "zombie", "human", "mutant_piscivores", "aquatic_predator" },
    by_mood = { "mixed_dino", "predator_dino", "herbivore_dino", "fishing_dino" },
}

ccb.content.define_monster_faction {
    id = "fishing_dino",
    base = "aquatic_predator",
    by_mood = { "fishing_dino", "mixed_dino", "aquatic_predator" },
    neutral = { "small_animal", "small_fisher" },
    hate = { "mutant_piscivores" },
}

ccb.content.define_monster_faction {
    id = "compsognathus",
    base = "small_predator",
    friendly = { "compsognathus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "compsognathus_hatchling",
    base = "very_small_predator",
    friendly = { "compsognathus" },
}

ccb.content.define_monster_faction {
    id = "spinosaurus",
    base = "fishing_dino",
    friendly = { "spinosaurus_juvenile", "spinosaurus_hatchling" },
    by_mood = { "spinosaurus" },
}

ccb.content.define_monster_faction {
    id = "spinosaurus_juvenile",
    base = "medium_fisher",
    friendly = { "spinosaurus", "spinosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "spinosaurus_hatchling",
    base = "small_fisher",
    friendly = { "spinosaurus", "spinosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "torvosaurus",
    base = "predator_dino",
    friendly = { "torvosaurus_juvenile", "torvosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "torvosaurus_juvenile",
    base = "small_predator",
    friendly = { "torvosaurus", "torvosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "torvosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "torvosaurus", "torvosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "allosaurus",
    base = "predator_dino",
    friendly = { "allosaurus_juvenile", "allosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "allosaurus_juvenile",
    base = "small_predator",
    friendly = { "allosaurus", "allosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "allosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "allosaurus", "allosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "acrocanthosaurus",
    base = "predator_dino",
    friendly = { "acrocanthosaurus_juvenile", "acrocanthosaurus_hatchling" },
    by_mood = { "acrocanthosaurus" },
}

ccb.content.define_monster_faction {
    id = "acrocanthosaurus_juvenile",
    base = "small_predator",
    friendly = { "acrocanthosaurus", "acrocanthosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "acrocanthosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "acrocanthosaurus", "acrocanthosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "giganotosaurus",
    base = "predator_dino",
    friendly = { "giganotosaurus_juvenile", "giganotosaurus_hatchling" },
    by_mood = { "giganotosaurus" },
}

ccb.content.define_monster_faction {
    id = "giganotosaurus_juvenile",
    base = "small_predator",
    friendly = { "giganotosaurus", "giganotosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "giganotosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "giganotosaurus", "giganotosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "siats",
    base = "predator_dino",
    friendly = { "siats_juvenile", "siats_hatchling" },
    by_mood = { "siats" },
}

ccb.content.define_monster_faction {
    id = "siats_juvenile",
    base = "small_predator",
    friendly = { "siats", "siats_hatchling" },
}

ccb.content.define_monster_faction {
    id = "siats_hatchling",
    base = "very_small_predator",
    friendly = { "siats", "siats_juvenile" },
}

ccb.content.define_monster_faction {
    id = "dryptosaurus",
    base = "predator_dino",
    friendly = { "dryptosaurus_juvenile", "dryptosaurus_hatchling" },
    by_mood = { "dryptosaurus" },
}

ccb.content.define_monster_faction {
    id = "dryptosaurus_juvenile",
    base = "small_predator",
    friendly = { "dryptosaurus", "dryptosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "dryptosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "dryptosaurus", "dryptosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "nanotyrannus",
    base = "predator_dino",
    friendly = { "nanotyrannus_juvenile", "nanotyrannus_hatchling" },
    by_mood = { "nanotyrannus" },
}

ccb.content.define_monster_faction {
    id = "nanotyrannus_juvenile",
    base = "small_predator",
    friendly = { "nanotyrannus", "nanotyrannus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "nanotyrannus_hatchling",
    base = "very_small_predator",
    friendly = { "nanotyrannus", "nanotyrannus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "appalachiosaurus",
    base = "predator_dino",
    friendly = { "appalachiosaurus_juvenile", "appalachiosaurus_hatchling" },
    by_mood = { "appalachiosaurus" },
}

ccb.content.define_monster_faction {
    id = "appalachiosaurus_juvenile",
    base = "small_predator",
    friendly = { "appalachiosaurus", "appalachiosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "appalachiosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "appalachiosaurus", "appalachiosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "gorgosaurus",
    base = "predator_dino",
    friendly = { "gorgosaurus_juvenile", "gorgosaurus_hatchling" },
    by_mood = { "gorgosaurus" },
}

ccb.content.define_monster_faction {
    id = "gorgosaurus_juvenile",
    base = "small_predator",
    friendly = { "gorgosaurus", "gorgosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "gorgosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "gorgosaurus", "gorgosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "albertosaurus",
    base = "predator_dino",
    friendly = { "albertosaurus_juvenile", "albertosaurus_hatchling" },
    by_mood = { "albertosaurus" },
}

ccb.content.define_monster_faction {
    id = "albertosaurus_juvenile",
    base = "small_predator",
    friendly = { "albertosaurus", "albertosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "albertosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "albertosaurus", "albertosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "nanuqsaurus",
    base = "predator_dino",
    hate = { "animal", "zombie", "human" },
    friendly = { "nanuqsaurus_juvenile", "nanuqsaurus_hatchling" },
    by_mood = { "nanuqsaurus" },
}

ccb.content.define_monster_faction {
    id = "nanuqsaurus_juvenile",
    base = "small_predator",
    friendly = { "nanuqsaurus", "nanuqsaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "nanuqsaurus_hatchling",
    base = "very_small_predator",
    friendly = { "nanuqsaurus", "nanuqsaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "daspletosaurus",
    base = "predator_dino",
    hate = { "animal", "zombie", "human" },
    friendly = { "daspletosaurus_juvenile", "daspletosaurus_hatchling" },
    by_mood = { "daspletosaurus" },
}

ccb.content.define_monster_faction {
    id = "daspletosaurus_juvenile",
    base = "small_predator",
    friendly = { "daspletosaurus", "daspletosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "daspletosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "daspletosaurus", "daspletosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "tyrannosaurus",
    base = "predator_dino",
    hate = { "animal", "zombie", "human" },
    friendly = { "tyrannosaurus_juvenile", "tyrannosaurus_hatchling" },
    by_mood = { "tyrannosaurus" },
}

ccb.content.define_monster_faction {
    id = "tyrannosaurus_juvenile",
    base = "small_predator",
    friendly = { "tyrannosaurus", "tyrannosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "tyrannosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "tyrannosaurus", "tyrannosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "saurornitholestes",
    base = "small_predator",
    friendly = { "saurornitholestes_hatchling" },
}

ccb.content.define_monster_faction {
    id = "saurornitholestes_hatchling",
    base = "very_small_predator",
    friendly = { "saurornitholestes" },
}

ccb.content.define_monster_faction {
    id = "velociraptor",
    base = "small_predator",
    friendly = { "velociraptor_hatchling" },
}

ccb.content.define_monster_faction {
    id = "velociraptor_hatchling",
    base = "very_small_predator",
    friendly = { "velociraptor" },
}

ccb.content.define_monster_faction {
    id = "deinonychus",
    base = "medium_predator",
    hate = { "herbivore", "zombie", "human" },
    friendly = { "deinonychus_juvenile", "deinonychus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "deinonychus_juvenile",
    base = "small_predator",
    friendly = { "deinonychus", "deinonychus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "deinonychus_hatchling",
    base = "very_small_predator",
    friendly = { "deinonychus", "deinonychus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "utahraptor",
    base = "predator_dino",
    friendly = { "utahraptor_juvenile", "utahraptor_hatchling" },
}

ccb.content.define_monster_faction {
    id = "utahraptor_juvenile",
    base = "small_predator",
    friendly = { "utahraptor", "utahraptor_hatchling" },
}

ccb.content.define_monster_faction {
    id = "utahraptor_hatchling",
    base = "very_small_predator",
    friendly = { "utahraptor", "utahraptor_juvenile" },
}

ccb.content.define_monster_faction {
    id = "dromaeosaurus",
    base = "small_predator",
    friendly = { "dromaeosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "dromaeosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "dromaeosaurus" },
}

ccb.content.define_monster_faction {
    id = "stenonychosaurus",
    base = "small_predator",
    friendly = { "stenonychosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "stenonychosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "stenonychosaurus" },
}

ccb.content.define_monster_faction {
    id = "dimorphodon",
    base = "small_fisher",
}

ccb.content.define_monster_faction {
    id = "pteranodon",
    base = "medium_fisher",
    friendly = { "pteranodon_young" },
}

ccb.content.define_monster_faction {
    id = "pteranodon_young",
    base = "small_fisher",
    friendly = { "pteranodon" },
}

ccb.content.define_monster_faction {
    id = "quetzalcoatlus",
    base = "medium_mixed",
    friendly = { "quetzalcoatlus_hatchling", "quetzalcoatlus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "quetzalcoatlus_juvenile",
    base = "small_mixed",
    friendly = { "quetzalcoatlus", "quetzalcoatlus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "quetzalcoatlus_hatchling",
    base = "very_small_mixed",
    friendly = { "quetzalcoatlus", "quetzalcoatlus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "anzu",
    base = "medium_mixed",
    friendly = { "anzu_hatchling", "anzu_juvenile" },
}

ccb.content.define_monster_faction {
    id = "anzu_juvenile",
    base = "small_mixed",
    friendly = { "anzu", "anzu_hatchling" },
}

ccb.content.define_monster_faction {
    id = "anzu_hatchling",
    base = "very_small_mixed",
    friendly = { "anzu", "anzu_juvenile" },
}

-- omnivore
ccb.content.define_monster_faction {
    id = "eoraptor",
    base = "very_small_predator",
}

ccb.content.define_monster_faction {
    id = "tawa",
    base = "small_predator",
    friendly = { "tawa", "tawa_hatchling" },
}

ccb.content.define_monster_faction {
    id = "tawa_hatchling",
    base = "very_small_predator",
    friendly = { "tawa", "tawa_hatchling" },
}

ccb.content.define_monster_faction {
    id = "coelophysis",
    base = "small_predator",
    friendly = { "coelophysis", "coelophysis_hatchling" },
}

ccb.content.define_monster_faction {
    id = "coelophysis_hatchling",
    base = "very_small_predator",
    friendly = { "coelophysis", "coelophysis_hatchling" },
}

ccb.content.define_monster_faction {
    id = "dilophosaurus",
    base = "mixed_dino",
    friendly = { "dilophosaurus_juvenile", "dilophosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "dilophosaurus_juvenile",
    base = "small_mixed",
    friendly = { "dilophosaurus", "dilophosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "dilophosaurus_hatchling",
    base = "very_small_mixed",
    friendly = { "dilophosaurus", "dilophosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "mosasaurus",
    base = "mixed_dino",
    friendly = { "mosasaurus_juvenile", "mosasaurus_hatchling" },
    by_mood = { "mosasaurus" },
}

ccb.content.define_monster_faction {
    id = "mosasaurus_juvenile",
    base = "small_mixed",
    friendly = { "mosasaurus", "mosasaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "mosasaurus_hatchling",
    base = "very_small_mixed",
    friendly = { "mosasaurus", "mosasaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "shonisaurus",
    base = "mixed_dino",
    friendly = { "shonisaurus_juvenile", "shonisaurus_hatchling" },
    by_mood = { "shonisaurus" },
}

ccb.content.define_monster_faction {
    id = "shonisaurus_juvenile",
    base = "small_mixed",
    friendly = { "shonisaurus", "shonisaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "shonisaurus_hatchling",
    base = "very_small_mixed",
    friendly = { "shonisaurus", "shonisaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "plesiosaurus",
    base = "fishing_dino",
    friendly = { "plesiosaurus" },
}

ccb.content.define_monster_faction {
    id = "ceratosaurus",
    base = "mixed_dino",
    friendly = { "ceratosaurus_juvenile", "ceratosaurus_hatchling" },
    by_mood = { "fish" },
}

ccb.content.define_monster_faction {
    id = "ceratosaurus_juvenile",
    base = "small_predator",
    friendly = { "ceratosaurus", "ceratosaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "ceratosaurus_hatchling",
    base = "very_small_predator",
    friendly = { "ceratosaurus", "ceratosaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "qianzhousaurus",
    base = "predator_dino",
    friendly = { "qianzhousaurus_juvenile", "qianzhousaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "qianzhousaurus_juvenile",
    base = "small_predator",
    friendly = { "qianzhousaurus", "qianzhousaurus_hatchling" },
}

ccb.content.define_monster_faction {
    id = "qianzhousaurus_hatchling",
    base = "very_small_predator",
    friendly = { "qianzhousaurus", "qianzhousaurus_juvenile" },
}

ccb.content.define_monster_faction {
    id = "small_animal",
    copy_from = "small_animal",
    neutral = {
        "predator_dino",
        "mixed_dino",
        "fishing_dino",
        "insectivore_young",
        "herbivore_young",
        "herbivore_dino",
    },
}

ccb.content.define_monster_faction {
    id = "herbivore",
    copy_from = "herbivore",
    neutral = { "herbivore_dino", "insectivore_dino", "herbivore_young" },
}

ccb.content.define_monster_faction {
    id = "cat",
    copy_from = "cat",
    by_mood = { "small_predator", "very_small_predator" },
}

ccb.content.define_monster_faction {
    id = "wolf",
    copy_from = "wolf",
    by_mood = { "medium_predator", "herbivore_dino" },
}

ccb.content.define_monster_faction {
    id = "big_cat",
    copy_from = "big_cat",
    by_mood = { "medium_mixed", "herbivore_dino" },
}

ccb.content.define_monster_faction {
    id = "zombie_aquatic",
    copy_from = "zombie_aquatic",
    by_mood = { "mixed_dino" },
    neutral = { "small_fisher" },
}

ccb.content.define_monster_faction {
    id = "fish",
    copy_from = "fish",
    by_mood = { "mixed_dino", "aquatic_predator", "small_mixed", "small_fisher", "very_small_mixed" },
}

ccb.content.define_monster_faction {
    id = "aquatic_predator",
    copy_from = "aquatic_predator",
    by_mood = { "medium_fisher", "fishing_dino", "mixed_dino", "medium_mixed" },
}
