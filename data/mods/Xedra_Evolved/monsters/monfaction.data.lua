local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "changeling",
    base = "nether",
    neutral = { "fish", "small_animal" },
    by_mood = { "nether", "nightmares", "slime" },
    hate = { "zombie", "triffid", "fungus", "exodii", "isolated_artisans", "cult" },
}

ccb.content.define_monster_faction {
    id = "vampire",
    base = "zombie",
    neutral = { "zombie" },
    by_mood = { "nether", "nightmares" },
    hate = { "changeling", "thornbeast", "werewolves", "xe_daemon" },
}

-- Like the mentors, they are human enough to be attacked by zombies.  Luring them into other hostiles is a valid strategy.
ccb.content.define_monster_faction {
    id = "vampire_anathema",
    copy_from = "vampire",
    extend = { hate = { "changeling", "nether", "nightmares", "vampire", "zombie" } },
}

ccb.content.define_monster_faction {
    id = "cult",
    copy_from = "cult",
    extend = { neutral = { "vampire_anathema" } },
}

ccb.content.define_monster_faction {
    id = "arvore",
    base = "changeling",
    neutral = { "small_animal", "fish" },
    by_mood = { "nether", "nightmares", "ierde", "undine", "sylph", "salamander", "changeling", "berserk_bot" },
    hate = { "zombie", "homullus", "thornbeast", "cult" },
}

ccb.content.define_monster_faction {
    id = "ierde",
    base = "changeling",
    friendly = { "worm" },
    neutral = { "small_animal", "fish", "berserk_bot" },
    by_mood = { "nether", "nightmares", "homullus", "arvore", "undine", "salamander", "changeling" },
    hate = { "zombie", "sylph", "cult" },
}

ccb.content.define_monster_faction {
    id = "undine",
    base = "changeling",
    neutral = { "small_animal", "fish", "berserk_bot" },
    by_mood = { "nether", "nightmares", "homullus", "arvore", "sylph", "ierde", "slime", "changeling" },
    hate = { "zombie", "salamander", "cult" },
}

ccb.content.define_monster_faction {
    id = "salamander",
    base = "changeling",
    neutral = { "small_animal", "fish", "berserk_bot" },
    by_mood = { "nether", "nightmares", "ierde", "arvore", "sylph", "homullus", "changeling" },
    hate = { "zombie", "undine", "cult" },
}

ccb.content.define_monster_faction {
    id = "homullus",
    base = "changeling",
    friendly = { "berserk_bot" },
    neutral = { "small_animal", "fish" },
    by_mood = { "nether", "nightmares", "ierde", "arvore", "sylph", "salamander", "changeling" },
    hate = { "zombie", "arvore", "cult" },
}

ccb.content.define_monster_faction {
    id = "sylph",
    base = "changeling",
    neutral = { "small_animal", "fish", "berserk_bot" },
    by_mood = { "nether", "nightmares", "homullus", "arvore", "undine", "salamander", "changeling" },
    hate = { "zombie", "ierde", "cult" },
}

ccb.content.define_monster_faction {
    id = "berserk_bot",
    copy_from = "berserk_bot",
    extend = {
        friendly = { "homullus" },
        neutral = { "sylph", "salamander", "undine", "ierde" },
        by_mood = { "arvore" },
    },
}

ccb.content.define_monster_faction {
    id = "thornbeast",
    by_mood = { "zombie", "nether", "nightmares" },
    hate = { "arvore", "vampire" },
}

ccb.content.define_monster_faction {
    id = "fish",
    copy_from = "fish",
    extend = { neutral = { "changeling", "nightmares", "vampire" } },
}

ccb.content.define_monster_faction {
    id = "worm",
    copy_from = "worm",
    extend = { neutral = { "ierde" } },
}

ccb.content.define_monster_faction {
    id = "small_animal",
    copy_from = "small_animal",
    extend = { neutral = { "changeling", "nightmares", "vampire" } },
}

ccb.content.define_monster_faction {
    id = "slime",
    copy_from = "slime",
    extend = { neutral = { "nightmares", "vampire" }, by_mood = "changeling" },
}

ccb.content.define_monster_faction {
    id = "zombie",
    copy_from = "zombie",
    extend = {
        hate = { "changeling", "vampire_anathema", "werewolves", "xe_daemon" },
        neutral = { "vampire" },
    },
}

ccb.content.define_monster_faction {
    id = "triffid",
    copy_from = "triffid",
    extend = { hate = { "changeling", "werewolves", "xe_daemon" } },
}

ccb.content.define_monster_faction {
    id = "fungus",
    copy_from = "fungus",
    extend = { hate = { "changeling", "werewolves", "xe_daemon" } },
}

ccb.content.define_monster_faction {
    id = "nether",
    copy_from = "nether",
    extend = {
        hate = { "werewolves", "xe_daemon" },
        by_mood = { "changeling", "arvore", "ierde", "sylph", "undine", "homullus", "salamander" },
    },
}

ccb.content.define_monster_faction {
    id = "exodii",
    copy_from = "exodii",
    extend = { hate = { "changeling", "vampire", "vampire_anathema" } },
}

ccb.content.define_monster_faction {
    id = "isolated_artisans",
    copy_from = "isolated_artisans",
    extend = { hate = { "changeling", "vampire", "nightmares", "vampire_anathema" } },
}

ccb.content.define_monster_faction {
    id = "nightmares",
    base = "nether_hate_humans",
    friendly = "nether",
    neutral = { "fish", "small_animal", "slime" },
    by_mood = { "changeling", "vampire" },
}

ccb.content.define_monster_faction {
    id = "werewolves",
    hate = { "zombie", "nether", "triffid", "vampire", "fungus" },
}

ccb.content.define_monster_faction {
    id = "xe_daemon",
    friendly = { "xe_daemon" },
    hate = { "zombie", "nether", "triffid", "vampire", "fungus" },
}
