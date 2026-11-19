local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "mega_wolf",
    base = "animal",
    hate = { "small_animal", "herbivore", "human", "mega_herbivore" },
    by_mood = { "felidae", "mega_bird" },
    neutral = { "dog" },
}

ccb.content.define_monster_faction {
    id = "mega_cat",
    base = "animal",
    hate = { "small_animal", "herbivore", "human", "mega_herbivore" },
    by_mood = { "fish", "canidae", "mega_bird" },
    neutral = { "cat" },
}

ccb.content.define_monster_faction {
    id = "mega_herbivore",
    base = "animal",
    neutral = { "small_animal", "fish", "exodii", "isolated_artisans", "passive_machine", "herbivore" },
    by_mood = { "wolf", "big_cat", "mega_cat", "mega_wolf" },
}

ccb.content.define_monster_faction {
    id = "mega_bear",
    base = "animal",
    hate = { "small_animal", "bee" },
    by_mood = { "fish", "human", "herbivore" },
}

ccb.content.define_monster_faction {
    id = "mega_bird",
    base = "animal",
    hate = { "small_animal", "herbivore", "mega_herbivore" },
    by_mood = { "felidae", "canidae", "fish", "human" },
}
