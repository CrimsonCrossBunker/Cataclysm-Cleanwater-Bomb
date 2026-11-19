local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "silent_one",
    base = "nether",
    neutral = { "zombie" },
    hate = { "feral_psychic" },
}

ccb.content.define_monster_faction {
    id = "feral_psychic",
    base = "zombie",
    by_mood = { "silent_one" },
}

ccb.content.define_monster_faction {
    id = "zombie",
    copy_from = "zombie",
    extend = { neutral = { "silent_one" } },
}
