local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "magical_beast",
}

ccb.content.define_monster_faction {
    id = "fantasy_beast_domestic",
    base = "animal",
}

ccb.content.define_monster_faction {
    id = "dragon_black",
    friendly = { "ooze", "lizardfolk" },
}

ccb.content.define_monster_faction {
    id = "demon_spider",
    base = "spider",
}

ccb.content.define_monster_faction {
    id = "hunllef",
    base = "herbivore",
}

ccb.content.define_monster_faction {
    id = "ooze",
    friendly = { "dragon_black", "lizardfolk", "ooze" },
}

ccb.content.define_monster_faction {
    id = "lizardfolk",
    friendly = { "dragon_black", "ooze", "lizardfolk" },
}

ccb.content.define_monster_faction {
    id = "goblin",
}

ccb.content.define_monster_faction {
    id = "robot",
    neutral = { "aerial_assassin" },
}

ccb.content.define_monster_faction {
    id = "wonder_forge",
    hate = { "zombie", "fungus" },
    neutral = { "aerial_assassin" },
    friendly = { "forge_lords" },
}

ccb.content.define_monster_faction {
    id = "orcs",
}

ccb.content.define_monster_faction {
    id = "ogre",
}

ccb.content.define_monster_faction {
    id = "leprechaun",
}

ccb.content.define_monster_faction {
    id = "elves",
}

ccb.content.define_monster_faction {
    id = "rust_monster",
    hate = { "iron_golem" },
}

ccb.content.define_monster_faction {
    id = "iron_golem",
    base = "robot",
    by_mood = { "rust_monster" },
}

ccb.content.define_monster_faction {
    id = "earth_spirit_faction",
    base = "animal",
    friendly = { "animal", "herbivore" },
    hate = { "zombie", "nether_player_hate", "jabberwock" },
}

ccb.content.define_monster_faction {
    id = "forest_spirit_faction",
    base = "animal",
    friendly = { "animal", "herbivore" },
    hate = { "zombie", "fungus", "nether_player_hate", "jabberwock" },
}

ccb.content.define_monster_faction {
    id = "magical_plant",
    neutral = { "triffid" },
}

ccb.content.define_monster_faction {
    id = "triffid",
    copy_from = "triffid",
    extend = { neutral = { "aerial_assassin", "magical_plant" } },
}

ccb.content.define_monster_faction {
    id = "mi-go",
    copy_from = "mi-go",
    base = "nether",
    friendly = { "mi-go_summon" },
    neutral = { "fish", "yrax", "small_animal", "slime", "passive_machine", "aerial_assassin" },
    by_mood = { "nether" },
    hate = { "zombie", "triffid", "fungus", "exodii", "isolated_artisans" },
}

ccb.content.define_monster_faction {
    id = "zombie",
    copy_from = "zombie",
    extend = { neutral = { "aerial_assassin" } },
}

ccb.content.define_monster_faction {
    id = "bot",
    copy_from = "bot",
    extend = { neutral = { "aerial_assassin" } },
}

ccb.content.define_monster_faction {
    id = "mi-go_summon",
    base = "nether",
    friendly = { "mi-go" },
}

ccb.content.define_monster_faction {
    id = "fungus",
    copy_from = "fungus",
    neutral = { "bot", "fish", "passive_machine", "yrax" },
    hate = { "triffid", "forest_spirit_faction" },
}

ccb.content.define_monster_faction {
    id = "jabberwock",
    copy_from = "jabberwock",
    neutral = { "fish" },
    by_mood = { "jabberwock" },
    hate = { "zombie", "animal", "insect", "mutant", "human", "forest_spirit_faction", "earth_spirit_faction" },
}

-- These creatures aren't necessarily sentient in and of themselves or are drawn to sentient life in and around dimensional breaches.
ccb.content.define_monster_faction {
    id = "nether_player_hate",
    copy_from = "nether_player_hate",
    base = "nether",
    friendly = { "zombie" },
    neutral = { "animal" },
    hate = { "player", "forest_spirit_faction", "earth_spirit_faction" },
}

ccb.content.define_monster_faction {
    id = "animal",
    copy_from = "animal",
    friendly = { "attack_player_only", "forest_spirit_faction", "earth_spirit_faction" },
    neutral = {
        "small_animal",
        "fish",
        "bot",
        "aquatic_predator",
        "robofac",
        "passive_machine",
        "nether_player_hate",
        "aerial_assassin",
    },
    by_mood = { "animal" },
}

ccb.content.define_monster_faction {
    id = "herbivore",
    copy_from = "herbivore",
    friendly = { "forest_spirit_faction", "earth_spirit_faction" },
}

ccb.content.define_monster_faction {
    id = "aerial_assassin",
    base = "nether_hate_humans",
    neutral = { "animal", "zombie", "mi-go", "bot", "triffid", "passive_machine", "robot", "wonder_forge" },
    by_mood = { "dragon_black" },
}
