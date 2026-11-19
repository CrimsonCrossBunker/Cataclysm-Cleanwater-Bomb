local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "forest_spirit_faction",
    base = "animal",
    friendly = { "animal", "herbivore", "arvore" },
    hate = { "zombie", "fungus", "nether_player_hate", "jabberwock" },
}

ccb.content.define_monster_faction {
    id = "arvore",
    copy_from = "arvore",
    friendly = { "forest_spirit_faction" },
}

ccb.content.define_monster_faction {
    id = "undead",
    base = "nether_hate_humans",
    neutral = { "zombie", "nether" },
}

ccb.content.define_monster_faction {
    id = "zombie",
    copy_from = "zombie",
    extend = { neutral = { "undead" } },
}

ccb.content.define_monster_faction {
    id = "eldritch_being",
}

ccb.content.define_monster_faction {
    id = "chirurgeon",
}

ccb.content.define_monster_faction {
    id = "hollow_civilian",
    base = "human",
    friendly = { "hollow_warrior, hollow_hunter" },
    by_mood = { "player" },
}

ccb.content.define_monster_faction {
    id = "hollow_warrior",
    base = "human",
    friendly = { "hollow_civilian", "hollow_hunter" },
    hate = { "zombie" },
    by_mood = { "player" },
}

ccb.content.define_monster_faction {
    id = "hollow_hunter",
    base = "human",
    friendly = { "hollow_civilian, hollow_warrior" },
    hate = { "small_animal", "vermin", "zombie" },
    by_mood = { "player" },
}

ccb.content.define_monster_faction {
    id = "very_small_predator",
    base = "cat",
    by_mood = { "small_animal", "very_small_predator" },
    hate = { "tiny_animal" },
}

ccb.content.define_monster_faction {
    id = "small_predator",
    base = "cat",
    by_mood = { "small_predator", "cat" },
    hate = { "small_animal" },
}

ccb.content.define_monster_faction {
    id = "predator_dino",
    base = "animal",
    neutral = { "small_animal", "fish" },
    by_mood = { "predator_dino", "animal", "zombie_aquatic" },
    hate = { "herbivore", "zombie", "human" },
}

ccb.content.define_monster_faction {
    id = "snakes",
    base = "animal",
    neutral = { "snakes" },
    by_mood = { "animal", "zombie_aquatic" },
    hate = { "herbivore" },
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
    id = "lizardfolk_nonhostile",
    hate = { "lizardfolk_hostile" },
}

ccb.content.define_monster_faction {
    id = "lizardfolk_hostile",
    hate = { "lizardfolk_nonhostile" },
}
