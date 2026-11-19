local ccb = require("ccb")

-- After changing this file, you might want to run the 'generate_monfactions_attitude_matrix' on-demand test
ccb.content.define_monster_faction {
    id = "",
    base = "",
    by_mood = { "" },
}

ccb.content.define_monster_faction {
    id = "factionless",
    by_mood = { "factionless" },
}

-- Should be friendly to everything, this faction only attacks and is attacked by the player/NPCs
ccb.content.define_monster_faction {
    id = "attack_player_only",
    friendly = {
        "slime",
        "zombie",
        "animal",
        "mutant",
        "insect",
        "bot",
        "nether",
        "spider",
        "stag_beetle",
        "small_animal",
        "plant",
        "triffid",
    },
    by_mood = { "attack_player_only" },
    hate = { "player", "human" },
}

ccb.content.define_monster_faction {
    id = "human",
    neutral = { "mech_bot", "passive_machine" },
    by_mood = { "exodii", "isolated_artisans", "yrax" },
}

ccb.content.define_monster_faction {
    id = "player",
    base = "human",
    neutral = { "robofac_spy", "passive_machine" },
}

ccb.content.define_monster_faction {
    id = "zombie",
    friendly = { "slime", "attack_player_only" },
    neutral = { "cult", "small_animal", "fish", "aquatic_predator", "passive_machine", "nether_player_hate" },
}

ccb.content.define_monster_faction {
    id = "zombie_aquatic",
    base = "zombie",
    hate = { "aquatic_predator", "kraken", "fish_large", "fish_mutant_passive", "beaver" },
}

ccb.content.define_monster_faction {
    id = "kraken",
    hate = { "aquatic_predator", "zombie_aquatic" },
    by_mood = { "fish_medium", "fish_large", "fish_mutant_passive" },
}

ccb.content.define_monster_faction {
    id = "zombie_dusted",
    base = "zombie",
    friendly = { "slime", "attack_player_only", "fungus" },
}

ccb.content.define_monster_faction {
    id = "science",
    base = "zombie",
    neutral = { "defense_bot", "mech_bot", "passive_machine" },
}

ccb.content.define_monster_faction {
    id = "feral_police",
    base = "zombie",
    friendly = { "cop_bot", "passive_machine" },
}

ccb.content.define_monster_faction {
    id = "cult",
    base = "zombie",
    neutral = { "slime", "zombie", "nether", "vortex", "passive_machine" },
    by_mood = { "leech_plant" },
}

ccb.content.define_monster_faction {
    id = "animal",
    friendly = { "attack_player_only" },
    neutral = {
        "small_animal",
        "fish",
        "bot",
        "aquatic_predator",
        "robofac",
        "passive_machine",
        "nether_player_hate",
    },
    by_mood = { "animal" },
}

-- Base faction for animals roughly the size of a rabbit. Avoid giving this specific faction to monsters, instead check if there's a baby faction from this one that suits the monster better.
ccb.content.define_monster_faction {
    id = "small_animal",
    base = "animal",
    neutral = { "zombie", "exodii", "isolated_artisans", "nether", "animal", "yrax" },
    by_mood = { "bear", "fox", "big_cat", "dog", "coyote", "wolf" },
}

ccb.content.define_monster_faction {
    id = "mammal_small",
    base = "small_animal",
    by_mood = "snake_small",
}

ccb.content.define_monster_faction {
    id = "mammal_small_predator",
    base = "mammal_small",
    hate = { "tiny_animal" },
}

ccb.content.define_monster_faction {
    id = "opossum",
    base = "mammal_small_predator",
}

ccb.content.define_monster_faction {
    id = "skunk",
    base = "mammal_small_predator",
}

ccb.content.define_monster_faction {
    id = "shrew",
    base = "mammal_small_predator",
}

ccb.content.define_monster_faction {
    id = "mole",
    base = "mammal_small_predator",
}

ccb.content.define_monster_faction {
    id = "porcupine",
    base = "mammal_small_predator",
}

ccb.content.define_monster_faction {
    id = "raccoon",
    base = "mammal_small_predator",
}

ccb.content.define_monster_faction {
    id = "ferret",
    base = "mammal_small_predator",
}

ccb.content.define_monster_faction {
    id = "dog_small",
    base = "mammal_small_predator",
    friendly = { "dog" },
}

ccb.content.define_monster_faction {
    id = "cat",
    base = "mammal_small_predator",
}

ccb.content.define_monster_faction {
    id = "otter",
    base = "mammal_small",
    neutral = "snake_small",
    hate = { "fish_tiny", "fish_small", "fish_medium", "amphibian_tiny", "reptile_tiny_aquatic" },
}

ccb.content.define_monster_faction {
    id = "bird_small_flying",
    base = "small_animal",
}

ccb.content.define_monster_faction {
    id = "bird_small_flightless",
    base = "small_animal",
}

ccb.content.define_monster_faction {
    id = "bird_small_waterfowl",
    base = "small_animal",
}

ccb.content.define_monster_faction {
    id = "bird_small_waterfowl_predator",
    base = "bird_small_waterfowl",
    hate = { "amphibian_tiny", "fish_tiny", "fish_small", "snake_tiny_aquatic" },
}

ccb.content.define_monster_faction {
    id = "reptile_small",
    base = "small_animal",
}

ccb.content.define_monster_faction {
    id = "snake_small",
    base = "reptile_small",
    neutral = { "small_animal", "bird_tiny_flying", "otter" },
    hate = { "tiny_animal", "mammal_small" },
}

ccb.content.define_monster_faction {
    id = "reptile_small_aquatic",
    base = "small_animal",
}

ccb.content.define_monster_faction {
    id = "turtle_small",
    base = "reptile_small_aquatic",
}

ccb.content.define_monster_faction {
    id = "turtle_small_predator",
    base = "turtle_small",
    neutral = { "bird_tiny_flying" },
    hate = { "tiny_animal", "fish_tiny", "fish_small" },
}

-- Base faction for animals roughly the size of a rat or a squirrel. Avoid giving this specific faction to monsters, instead check if there's a baby faction from this one that suits the monster better.
ccb.content.define_monster_faction {
    id = "tiny_animal",
    base = "small_animal",
    neutral = { "small_animal", "bear", "big_cat", "razorclaw", "mantis", "frog" },
    by_mood = {
        "mammal_small_predator",
        "weasel",
        "snake_tiny_aquatic",
        "snake_small",
        "turtle_small_predator",
    },
}

ccb.content.define_monster_faction {
    id = "mammal_tiny",
    base = "tiny_animal",
}

ccb.content.define_monster_faction {
    id = "weasel",
    base = "mammal_tiny",
    hate = { "tiny_animal", "mammal_tiny" },
}

ccb.content.define_monster_faction {
    id = "bird_tiny_flying",
    base = "tiny_animal",
    neutral = { "snake_tiny_aquatic", "snake_small", "turtle_small_predator" },
}

ccb.content.define_monster_faction {
    id = "bird_tiny_flightless",
    base = "tiny_animal",
}

ccb.content.define_monster_faction {
    id = "bird_tiny_waterfowl",
    base = "tiny_animal",
}

ccb.content.define_monster_faction {
    id = "amphibian_tiny",
    base = "tiny_animal",
    by_mood = { "otter", "bird_small_waterfowl_predator" },
}

ccb.content.define_monster_faction {
    id = "reptile_tiny",
    base = "tiny_animal",
}

ccb.content.define_monster_faction {
    id = "lizard_tiny",
    base = "reptile_tiny",
}

ccb.content.define_monster_faction {
    id = "reptile_tiny_aquatic",
    base = "tiny_animal",
    neutral = { "snake_tiny_aquatic" },
    by_mood = { "otter" },
}

ccb.content.define_monster_faction {
    id = "snake_tiny_aquatic",
    base = "reptile_tiny_aquatic",
    neutral = { "bird_tiny_flying", "reptile_tiny_aquatic" },
    by_mood = { "bird_small_waterfowl_predator" },
    hate = { "tiny_animal", "fish_tiny" },
}

ccb.content.define_monster_faction {
    id = "herbivore",
    base = "animal",
    neutral = { "small_animal", "fish", "exodii", "isolated_artisans", "yrax", "passive_machine" },
    by_mood = { "herbivore_domestic" },
}

ccb.content.define_monster_faction {
    id = "herbivore_domestic",
    base = "herbivore",
    by_mood = { "herbivore" },
    neutral = { "pig" },
}

ccb.content.define_monster_faction {
    id = "beaver",
    base = "herbivore",
    neutral = { "herbivore" },
    by_mood = { "zombie_aquatic" },
}

-- Hunts small things, can't resist honey
ccb.content.define_monster_faction {
    id = "bear",
    base = "animal",
    neutral = { "tiny_animal" },
    hate = { "small_animal", "bee" },
    by_mood = { "fish" },
}

ccb.content.define_monster_faction {
    id = "fox",
    base = "animal",
    hate = { "small_animal" },
}

ccb.content.define_monster_faction {
    id = "big_cat",
    base = "animal",
    neutral = { "tiny_animal" },
    hate = { "small_animal", "herbivore" },
    by_mood = { "fish" },
}

ccb.content.define_monster_faction {
    id = "dog",
    base = "animal",
    friendly = { "dog_small" },
    neutral = { "pig" },
    hate = { "small_animal" },
}

ccb.content.define_monster_faction {
    id = "coyote",
    base = "animal",
    hate = { "small_animal" },
}

ccb.content.define_monster_faction {
    id = "pig",
    base = "herbivore",
    neutral = { "herbivore", "herbivore_domestic", "dog" },
}

ccb.content.define_monster_faction {
    id = "wolf",
    base = "animal",
    hate = { "small_animal", "herbivore" },
}

ccb.content.define_monster_faction {
    id = "rat",
    base = "mammal_tiny",
    neutral = { "ratkin" },
}

ccb.content.define_monster_faction {
    id = "fish",
    base = "animal",
    by_mood = {
        "bear",
        "big_cat",
        "aquatic_predator",
        "mutant_piscivores",
        "crayfish",
        "strider",
        "beetle_diving",
        "water_scorpion",
    },
    neutral = {
        "zombie",
        "bot",
        "animal",
        "small_animal",
        "exodii",
        "isolated_artisans",
        "plant",
        "nether",
        "jabberwock",
        "flesh_abberation",
        "insect",
        "mutant",
        "fungus",
        "yrax",
        "passive_machine",
    },
}

ccb.content.define_monster_faction {
    id = "fish_tiny",
    base = "fish",
    by_mood = { "otter", "turtle_small_predator", "snake_tiny_aquatic", "bird_small_waterfowl_predator" },
}

ccb.content.define_monster_faction {
    id = "fish_small",
    base = "fish",
    by_mood = { "otter", "turtle_small_predator", "bird_small_waterfowl_predator" },
}

ccb.content.define_monster_faction {
    id = "fish_medium",
    base = "fish",
    by_mood = { "otter", "kraken" },
}

ccb.content.define_monster_faction {
    id = "fish_large",
    base = "fish",
    by_mood = { "kraken", "zombie_aquatic" },
}

-- This is for fish mutants that are either herbivores or carnivores not aggressive enough to attack fish of similar size as them.
ccb.content.define_monster_faction {
    id = "fish_mutant_passive",
    base = "fish",
    by_mood = { "kraken", "zombie_aquatic" },
}

ccb.content.define_monster_faction {
    id = "nether",
    friendly = { "attack_player_only" },
    neutral = { "cult", "small_animal", "fish", "slime", "passive_machine" },
    by_mood = { "leech_plant", "vortex", "mi-go" },
}

ccb.content.define_monster_faction {
    id = "nether_hate_humans",
    base = "nether",
    hate = { "player", "human" },
}

ccb.content.define_monster_faction {
    id = "spearfisher",
    base = "nether",
    by_mood = { "nether_fish_symbiote" },
}

ccb.content.define_monster_faction {
    id = "nether_fish_symbiote",
    base = "nether",
    by_mood = { "spearfisher" },
}

-- These creatures aren't necessarily sentient in and of themselves or are drawn to sentient life in and around dimensional breaches.
ccb.content.define_monster_faction {
    id = "nether_player_hate",
    base = "nether",
    friendly = { "zombie" },
    neutral = { "animal" },
    hate = { "player" },
}

ccb.content.define_monster_faction {
    id = "vortex",
    base = "nether",
    by_mood = { "nether", "slime", "mi-go" },
    neutral = { "mutant_with_vortex", "passive_machine" },
}

ccb.content.define_monster_faction {
    id = "slime",
    base = "nether",
    neutral = { "nether", "mi-go", "passive_machine" },
    friendly = { "zombie", "attack_player_only" },
}

ccb.content.define_monster_faction {
    id = "leech_plant",
    base = "nether",
    by_mood = { "cult", "nether", "slime", "mi-go" },
}

-- Assorted mutated wildlife, more aggressive
-- Primarily meant as a base_faction;
-- if used as a faction, they may attack each other.
ccb.content.define_monster_faction {
    id = "mutant",
    friendly = { "attack_player_only" },
    neutral = { "fish", "passive_machine" },
    by_mood = { "mutant", "mutant_piscivores" },
    hate = { "insect", "animal" },
}

-- Protect their nest, grumpy
ccb.content.define_monster_faction {
    id = "razorclaw",
    base = "mutant",
    neutral = { "tiny_animal" },
    by_mood = { "small_animal" },
}

ccb.content.define_monster_faction {
    id = "frog",
    base = "mutant",
    neutral = { "tiny_animal" },
    by_mood = { "animal" },
    hate = { "small_animal", "insect" },
}

ccb.content.define_monster_faction {
    id = "slug",
    base = "mutant",
}

-- Primarily meant as a base_faction;
-- if used as a faction, they may attack each other.
ccb.content.define_monster_faction {
    id = "mutant_piscivores",
    base = "mutant",
    by_mood = { "mutant", "mutant_piscivores" },
    hate = { "fish" },
}

ccb.content.define_monster_faction {
    id = "amigara",
    base = "mutant",
    neutral = { "amigara" },
}

ccb.content.define_monster_faction {
    id = "mutant_with_vortex",
    base = "mutant",
    neutral = { "vortex" },
}

ccb.content.define_monster_faction {
    id = "corvid",
    base = "mutant",
}

ccb.content.define_monster_faction {
    id = "ratkin",
    base = "mutant",
    neutral = { "rat" },
}

ccb.content.define_monster_faction {
    id = "lab_mutant",
    base = "mutant",
}

ccb.content.define_monster_faction {
    id = "bot",
    neutral = {
        "bot",
        "animal",
        "insect",
        "plant",
        "fish",
        "robofac",
        "fungus",
        "aquatic_predator",
        "passive_machine",
    },
    friendly = { "passive_machine", "attack_player_only" },
}

ccb.content.define_monster_faction {
    id = "utility_bot",
    base = "bot",
}

ccb.content.define_monster_faction {
    id = "military",
    base = "bot",
}

ccb.content.define_monster_faction {
    id = "defense_bot",
    base = "bot",
    friendly = { "science", "passive_machine" },
}

ccb.content.define_monster_faction {
    id = "cop_bot",
    base = "bot",
    friendly = { "feral_police" },
}

ccb.content.define_monster_faction {
    id = "mech_bot",
    base = "bot",
    neutral = { "science", "human" },
}

ccb.content.define_monster_faction {
    id = "nurse_bot",
    base = "bot",
    by_mood = { "zombie" },
}

ccb.content.define_monster_faction {
    id = "passive_machine",
    neutral = {
        "human",
        "player",
        "zombie",
        "zombie_aquatic",
        "science",
        "cult",
        "nether",
        "vortex",
        "slime",
        "leech_plant",
        "mutant",
        "razorclaw",
        "frog",
        "slug",
        "mutant_piscivores",
        "amigara",
        "mutant_with_vortex",
        "corvid",
        "ratkin",
        "lab_mutant",
        "exodii",
        "isolated_artisans",
        "yrax",
        "mi-go",
        "seweranha",
        "sewer_snake",
        "dark_wyrm",
        "cop_zombie",
    },
    base = "bot",
}

-- No base_faction to allow normally bot-neutral to fight back
ccb.content.define_monster_faction {
    id = "berserk_bot",
}

ccb.content.define_monster_faction {
    id = "insect",
    friendly = { "attack_player_only" },
    neutral = { "fish", "bot", "aquatic_predator" },
    by_mood = { "insect" },
}

ccb.content.define_monster_faction {
    id = "worm",
    base = "insect",
}

ccb.content.define_monster_faction {
    id = "locust",
    base = "insect",
}

ccb.content.define_monster_faction {
    id = "wasp",
    base = "insect",
    by_mood = { "fungus", "ant", "acid_ant", "bee" },
    hate = { "insect", "small_animal" },
}

ccb.content.define_monster_faction {
    id = "bee",
    base = "insect",
    friendly = { "plant" },
}

ccb.content.define_monster_faction {
    id = "roach",
    base = "insect",
}

ccb.content.define_monster_faction {
    id = "mosquito",
    base = "insect",
    hate = { "animal" },
}

ccb.content.define_monster_faction {
    id = "dragonfly",
    base = "insect",
    by_mood = { "centipede", "spider", "ant", "acid_ant" },
    hate = { "insect", "small_animal" },
}

ccb.content.define_monster_faction {
    id = "centipede",
    base = "insect",
    hate = { "insect", "animal" },
}

ccb.content.define_monster_faction {
    id = "centipede_house",
    base = "insect",
    by_mood = { "centipede", "spider", "herbivore" },
    hate = { "insect", "small_animal" },
}

ccb.content.define_monster_faction {
    id = "dermatik",
    base = "insect",
    hate = { "small_animal", "herbivore", "dog" },
}

ccb.content.define_monster_faction {
    id = "spider",
    base = "insect",
    friendly = { "attack_player_only" },
    hate = { "insect", "animal" },
    by_mood = { "spider" },
}

ccb.content.define_monster_faction {
    id = "spider_wolf",
    base = "spider",
}

ccb.content.define_monster_faction {
    id = "spider_web",
    base = "spider",
}

ccb.content.define_monster_faction {
    id = "spider_jumping",
    base = "spider",
}

ccb.content.define_monster_faction {
    id = "spider_trapdoor",
    base = "spider",
}

ccb.content.define_monster_faction {
    id = "spider_widow",
    base = "spider",
}

-- Eat other spiders, but semi-social among themselves
ccb.content.define_monster_faction {
    id = "spider_cellar",
    base = "spider",
    by_mood = { "spider" },
    neutral = { "spider_cellar" },
}

ccb.content.define_monster_faction {
    id = "ant",
    base = "insect",
    friendly = { "aphid" },
    neutral = { "stag_beetle_larva" },
}

ccb.content.define_monster_faction {
    id = "acid_ant",
    base = "insect",
    neutral = { "aphid", "stag_beetle_larva" },
}

ccb.content.define_monster_faction {
    id = "aphid",
    base = "insect",
    neutral = { "ant", "acid_ant", "stag_beetle_larva" },
}

ccb.content.define_monster_faction {
    id = "crayfish",
    base = "insect",
    hate = { "fish" },
}

ccb.content.define_monster_faction {
    id = "stag_beetle",
    friendly = { "attack_player_only" },
    base = "insect",
}

ccb.content.define_monster_faction {
    id = "stag_beetle_larva",
    base = "stag_beetle",
    neutral = { "ant", "acid_ant", "aphid" },
}

ccb.content.define_monster_faction {
    id = "antlion_grub",
    base = "insect",
    neutral = { "antlion_grub", "antlion_adult" },
    by_mood = { "fungus", "bee" },
    hate = { "insect", "small_animal", "ant", "acid_ant" },
}

ccb.content.define_monster_faction {
    id = "antlion_adult",
    base = "insect",
    neutral = { "antlion_grub", "antlion_adult" },
}

ccb.content.define_monster_faction {
    id = "ladybug",
    base = "insect",
    by_mood = { "bee", "insect" },
    hate = { "small_animal", "ant", "acid_ant" },
}

ccb.content.define_monster_faction {
    id = "mantis",
    base = "insect",
    neutral = { "tiny_animal" },
    by_mood = { "centipede", "spider", "ant", "acid_ant" },
    hate = { "insect", "small_animal" },
}

ccb.content.define_monster_faction {
    id = "strider",
    base = "insect",
    hate = { "small_animal", "fish", "beetle_diving", "water_scorpion" },
}

ccb.content.define_monster_faction {
    id = "beetle_diving",
    base = "insect",
    hate = { "small_animal", "fish", "strider", "water_scorpion" },
}

ccb.content.define_monster_faction {
    id = "water_scorpion",
    base = "insect",
    hate = { "small_animal", "fish", "strider", "beetle_diving" },
}

ccb.content.define_monster_faction {
    id = "fungus",
    friendly = { "zombie_dusted" },
    neutral = { "bot", "fish", "passive_machine", "yrax" },
    hate = { "triffid" },
}

ccb.content.define_monster_faction {
    id = "flesh_abberation",
    neutral = { "fish", "flesh_abberation" },
    by_mood = { "jabberwock" },
    hate = { "zombie", "animal", "insect", "mutant", "human" },
}

ccb.content.define_monster_faction {
    id = "jabberwock",
    neutral = { "fish" },
    by_mood = { "jabberwock" },
    hate = { "zombie", "animal", "insect", "mutant", "human" },
}

ccb.content.define_monster_faction {
    id = "balthazar",
    hate = { "zombie" },
}

ccb.content.define_monster_faction {
    id = "robofac",
    neutral = { "bot", "animal", "passive_machine" },
    hate = { "zombie", "fungus", "cult", "triffid", "nether" },
}

ccb.content.define_monster_faction {
    id = "robofac_spy",
    base = "robofac",
    friendly = { "player" },
}

ccb.content.define_monster_faction {
    id = "exodii",
    base = "human",
    neutral = { "fish", "small_animal", "herbivore", "passive_machine" },
    by_mood = { "animal", "nether", "human", "yrax" },
    hate = { "zombie", "fungus", "triffid", "mi-go" },
}

ccb.content.define_monster_faction {
    id = "isolated_artisans",
    base = "human",
    neutral = { "fish", "small_animal", "herbivore", "passive_machine" },
    by_mood = { "animal", "nether", "human" },
    hate = { "zombie", "fungus", "triffid", "mi-go" },
}

ccb.content.define_monster_faction {
    id = "mi-go",
    base = "nether",
    neutral = { "fish", "yrax", "small_animal", "slime", "passive_machine" },
    by_mood = { "nether" },
    hate = { "zombie", "triffid", "fungus", "exodii", "isolated_artisans" },
}

-- detestably neutral
ccb.content.define_monster_faction {
    id = "yrax",
    base = "human",
    neutral = { "triffid", "mi-go", "fungus", "fish", "small_animal", "herbivore", "passive_machine" },
    by_mood = { "nether", "human" },
    hate = { "zombie" },
}

ccb.content.define_monster_faction {
    id = "plant",
    neutral = { "bot", "fish", "passive_machine" },
    friendly = { "bee", "attack_player_only" },
}

ccb.content.define_monster_faction {
    id = "triffid",
    base = "plant",
    friendly = { "attack_player_only" },
    neutral = { "yrax" },
    hate = { "fungus" },
}

ccb.content.define_monster_faction {
    id = "aquatic_predator",
    base = "insect",
    neutral = { "bot", "insect", "animal", "zombie", "passive_machine" },
    hate = { "fish", "zombie_aquatic", "kraken" },
}

ccb.content.define_monster_faction {
    id = "seweranha",
    base = "mutant_piscivores",
    neutral = { "seweranha" },
}

ccb.content.define_monster_faction {
    id = "sewer_snake",
    base = "mutant_piscivores",
    neutral = { "sewer_snake" },
}

ccb.content.define_monster_faction {
    id = "dark_wyrm",
    base = "mutant",
    neutral = { "dark_wyrm" },
}

ccb.content.define_monster_faction {
    id = "beetle_solar",
    base = "insect",
}
