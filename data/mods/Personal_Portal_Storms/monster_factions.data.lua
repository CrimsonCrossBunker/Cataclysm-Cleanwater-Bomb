local ccb = require("ccb")

-- These creatures aren't necessarily sentient in and of themselves or are drawn to sentient life in and around dimensional breaches.
-- To avoid NPC death these are personal hallucinations.
ccb.content.define_monster_faction {
    id = "nether_player_hate",
    base = "nether",
    friendly = { "zombie" },
    neutral = { "animal", "human" },
    hate = { "player" },
}

ccb.content.define_monster_faction {
    id = "human",
    neutral = { "mech_bot", "passive_machine", "nether_player_hate" },
    by_mood = { "exodii", "isolated_artisans", "yrax" },
}
