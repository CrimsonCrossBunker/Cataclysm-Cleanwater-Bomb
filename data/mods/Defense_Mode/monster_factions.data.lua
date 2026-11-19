local ccb = require("ccb")

ccb.content.define_monster_faction {
    id = "zombie",
    friendly = {
        "slime",
        "zombie",
        "animal",
        "mutant",
        "insect",
        "bot",
        "nether",
        "spider",
        "stag_beetle",
        "small_animal",
        "plant",
        "triffid",
        "cult",
        "fish",
        "aquatic_predator",
        "nether_player_hate",
        "attack_player_only",
    },
    by_mood = {},
    hate = { "player", "human" },
}
