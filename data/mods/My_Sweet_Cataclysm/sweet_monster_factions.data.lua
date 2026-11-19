local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "marshmallow_boys",
    neutral = { "bot", "plant", "nether", "human", "crackers", "cookies" },
    by_mood = { "insect", "player", "animal", "gummy_bears" },
}

ccb.content.define_monster_faction {
    id = "gummy_bears",
    neutral = { "bot", "plant", "nether", "human", "crackers", "cookies" },
    by_mood = { "insect", "player", "animal", "marshmallow_boys" },
}

ccb.content.define_monster_faction {
    id = "crackers",
    neutral = { "bot", "plant", "nether", "human", "gummy_bears", "marshmallow_boys" },
    by_mood = { "insect", "player", "animal", "cookies" },
}

ccb.content.define_monster_faction {
    id = "cookies",
    neutral = { "bot", "plant", "nether", "human", "gummy_bears", "marshmallow_boys" },
    by_mood = { "insect", "player", "animal", "crackers" },
}

ccb.content.define_monster_faction {
    id = "chewgum",
    neutral = { "bot", "plant", "nether", "human", "crackers", "cookies" },
    by_mood = {
        "insect",
        "player",
        "animal",
        "gummy_bears",
        "marshmallow_boys",
        "caff_chewgum",
        "licorice_snakes",
    },
}

ccb.content.define_monster_faction {
    id = "caff_chewgum",
    neutral = { "bot", "plant", "nether", "human", "crackers", "cookies" },
    by_mood = { "insect", "player", "animal", "gummy_bears", "marshmallow_boys", "chewgum", "licorice_snakes" },
}

ccb.content.define_monster_faction {
    id = "zombie",
    friendly = {
        "slime",
        "cult",
        "zombie_aquatic",
        "crackers",
        "cookies",
        "gummy_bears",
        "marshmallow_boys",
        "caff_chewgum",
        "chewgum",
        "chocolate_cow",
        "licorice_snakes",
    },
    neutral = { "small_animal", "insect", "fish" },
    by_mood = { "bee" },
}

ccb.content.define_monster_faction {
    id = "licorice_snakes",
    neutral = { "bot", "plant", "nether", "human", "crackers", "cookies" },
    by_mood = { "insect", "player", "animal", "gummy_bears", "chewgum", "chocolate_cow", "caff_chewgum" },
}

ccb.content.define_monster_faction {
    id = "chocolate_cow",
    neutral = { "bot", "plant", "nether", "human", "gummy_bears", "marshmallow_boys" },
    by_mood = { "insect", "player", "animal", "cookies", "licorice_snakes" },
    base = "herbivore",
}
