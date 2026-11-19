local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_numbing",
    name = ccb.content.plural_text("numbing goblin fruit", "numbing goblin fruits"),
    description = ccb.content.text("This gray dented fruit numbs your fingers as you hold it and its smell numbs your nose the same way."),
    copy_from = "goblin_fruit_abstract",
    color = "light_gray",
    mass = "244 g",
    volume = "222 ml",
    comestible = { kind = "FOOD", fun = 0, on_consume = "eat_numbing_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_spawn_shadows",
    name = ccb.content.plural_text("whispering goblin fruit", "whispering goblin fruits"),
    description = ccb.content.text("This fruit is similar to a sphere of smoke.  Faint sounds come from this fruit.  They almost sound like whispers."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray",
    mass = "275 g",
    volume = "250 ml",
    comestible = { kind = "FOOD", on_consume = "eat_shadow_goblin_fruit" },
}

ccb.content.define_monster {
    id = "mon_dream_shadow_player",
    copy_from = "mon_dream_shadow",
    name = ccb.content.plural_text("shadow", "shadows"),
    default_faction = "player",
}
