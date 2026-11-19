local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "scorpion",
    base = "spider",
}

ccb.content.define_monster_faction {
    id = "termite",
    base = "acid_ant",
    by_mood = { "acid_ant" },
}

ccb.content.define_monster_faction {
    id = "onicophore",
    base = "insect",
}

ccb.content.define_monster_faction {
    id = "turtle",
    base = "small_animal",
}

ccb.content.define_monster_faction {
    id = "gator",
    base = "mutant_piscivores",
}
