local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_hive_queen",
    name = ccb.content.text("Hive Queen"),
    description = ccb.content.text("The insects have accepted you as one of their own.  You are neutral with eusocial insects, including giant ones, but your presence is a little unnerving to animals and people."),
    points = 0,
    purifiable = false,
    valid = false,
    species_anger = { MAMMAL = 5, BIRD = 5 },
    enchantments = { "INLINE_ENCH_perk_hive_queen_0", "INLINE_ENCH_perk_hive_queen_1" },
    flags = { "PERK", "ANIMALDISCORD" },
}
