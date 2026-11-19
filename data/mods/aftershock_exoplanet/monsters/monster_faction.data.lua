local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "PrepNet",
    base = "human",
    friendly = { "Prepnet_Phyle", "PrepNet" },
    neutral = { "herbivore", "human" },
    by_mood = { "insect", "small_animal", "WraitheonRobotics" },
    hate = { "fungus" },
}

ccb.content.define_monster_faction {
    id = "alien_predator",
    neutral = { "bot" },
    by_mood = { "WraitheonRobotics", "alien_predator", "cop_bot", "defense_bot" },
}

ccb.content.define_monster_faction {
    id = "garlander",
    base = "alien_predator",
    by_mood = { "alien_predator" },
}

ccb.content.define_monster_faction {
    id = "boatman",
    base = "alien_predator",
    by_mood = { "alien_predator" },
}

ccb.content.define_monster_faction {
    id = "WraitheonRobotics",
    base = "robofac",
    neutral = { "cop_bot", "defense_bot", "utility_bot", "animal", "UPLIFT", "robofac" },
    hate = {
        "zombie",
        "fungus",
        "cult",
        "alien_predator",
        "triffid",
        "nether",
        "PrepNet",
        "moxie",
        "bio_machine",
        "reavers",
    },
    by_mood = { "human" },
}

ccb.content.define_monster_faction {
    id = "rampant_machine",
    base = "robofac",
    neutral = { "utility_bot" },
    hate = {
        "zombie",
        "fungus",
        "cult",
        "alien_predator",
        "triffid",
        "nether",
        "PrepNet",
        "moxie",
        "bio_machine",
        "reavers",
    },
    by_mood = { "human" },
}

ccb.content.define_monster_faction {
    id = "UICA_mil",
    base = "WraitheonRobotics",
}

ccb.content.define_monster_faction {
    id = "whately",
    base = "human",
    friendly = { "human", "whately", "whately_family" },
    by_mood = { "insect", "small_animal" },
    neutral = { "herbivore" },
    hate = { "zombie" },
}

ccb.content.define_monster_faction {
    id = "UPLIFT",
    base = "bear",
    neutral = { "herbivore", "robofac" },
    by_mood = { "insect", "small_animal", "human", "bee" },
    hate = { "zombie" },
}

ccb.content.define_monster_faction {
    id = "reavers",
    base = "human",
    neutral = { "herbivore", "robofac" },
    by_mood = { "insect", "small_animal", "human", "bee" },
    hate = { "zombie", "player", "UICA_mil", "moxie" },
}

ccb.content.define_monster_faction {
    id = "zombie",
    copy_from = "zombie",
    neutral = { "moxie" },
    hate = { "reavers" },
}

ccb.content.define_monster_faction {
    id = "moxie",
    base = "mutant",
    neutral = { "bio_machine", "zombie" },
    by_mood = { "small_animal", "herbivore" },
    hate = { "insect", "human", "mutant", "WraitheonRobotics", "bot", "reavers" },
}

ccb.content.define_monster_faction {
    id = "bio_machine",
    base = "bot",
    neutral = { "moxie", "small_animal", "herbivore", "insect", "human" },
    by_mood = { "WraitheonRobotics" },
}

ccb.content.define_monster_faction {
    id = "cryo",
    base = "mutant",
    by_mood = { "mutant", "animal" },
    hate = { "moxie", "insect", "human", "WraitheonRobotics" },
}

ccb.content.define_monster_faction {
    id = "hevel",
    base = "herbivore",
    neutral = { "herbivore" },
}

ccb.content.define_monster_faction {
    id = "venandi",
    base = "wolf",
    by_mood = { "wolf" },
}

ccb.content.define_monster_faction {
    id = "herbivore",
    copy_from = "herbivore",
    neutral = { "PrepNet", "whately", "UPLIFT", "bio_machine", "hevel" },
}

ccb.content.define_monster_faction {
    id = "human",
    copy_from = "human",
    neutral = { "bio_machine" },
}

ccb.content.define_monster_faction {
    id = "wolf",
    copy_from = "wolf",
    by_mood = { "venandi" },
}
