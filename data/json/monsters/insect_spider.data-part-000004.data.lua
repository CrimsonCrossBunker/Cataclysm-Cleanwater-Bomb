local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_centipede_house_larva",
    name = ccb.content.plural_text("giant house centipede larva", "giant house centipede larvae"),
    description = ccb.content.text("A baby house centipede about the size of a rat."),
    copy_from = "mon_larva_abstract",
    default_faction = "centipede_house",
    color = "brown",
    fear_triggers = { "BRIGHT_LIGHT" },
    upgrade = { grow_at_age = 30, monster = "mon_centipede_house" },
}
