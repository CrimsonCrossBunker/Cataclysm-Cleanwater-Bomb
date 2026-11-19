local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "deep_ones",
    friendly = { "cthulhu" },
}

ccb.content.define_monster_faction {
    id = "witches",
    friendly = { "nyarlathotep" },
    neutral = { "rat" },
}

ccb.content.define_monster_faction {
    id = "nyarlathotep",
    neutral = { "witches" },
    hate = { "nodens" },
}

ccb.content.define_monster_faction {
    id = "nodens",
    neutral = { "ghouls" },
    hate = { "nyarlathotep" },
}

ccb.content.define_monster_faction {
    id = "ghouls",
    neutral = { "nodens" },
    hate = { "yig" },
}

ccb.content.define_monster_faction {
    id = "yig",
    hate = { "ghouls" },
}

ccb.content.define_monster_faction {
    id = "elder_things",
    hate = { "polyps", "cthulhu", "shub-niggurath" },
}

ccb.content.define_monster_faction {
    id = "polyps",
    hate = { "elder_things", "yith" },
}

ccb.content.define_monster_faction {
    id = "shub-niggurath",
    hate = { "elder_things" },
}

ccb.content.define_monster_faction {
    id = "cthulhu",
    friendly = { "deep_ones" },
    hate = { "elder_things", "hastur" },
}

ccb.content.define_monster_faction {
    id = "hastur",
    hate = { "cthulhu" },
}

ccb.content.define_monster_faction {
    id = "yith",
    hate = { "polyps" },
}

ccb.content.define_monster_faction {
    id = "shan",
    hate = { "mi-go" },
}

ccb.content.define_monster_faction {
    id = "rat",
    copy_from = "rat",
    neutral = { "witches" },
}

ccb.content.define_monster_faction {
    id = "mi-go",
    copy_from = "mi-go",
    hate = { "zombie", "triffid", "fungus", "exodii", "shan" },
}
