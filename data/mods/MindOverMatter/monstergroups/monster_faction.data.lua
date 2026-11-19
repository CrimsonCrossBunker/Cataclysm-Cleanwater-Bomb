local ccb = require("ccb")

-- decided to give them some personality
ccb.content.define_monster_faction {
    id = "fear_hawk",
    base = "mutant",
    hate = { "corvid", "ratkin" },
}

ccb.content.define_monster_faction {
    id = "corvid",
    copy_from = "corvid",
    hate = "fear_hawk",
}

ccb.content.define_monster_faction {
    id = "ratkin",
    copy_from = "ratkin",
    hate = "fear_hawk",
}
