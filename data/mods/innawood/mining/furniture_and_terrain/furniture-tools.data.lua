local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_bloomery",
    name = ccb.content.text("bloomery"),
    looks_like = "f_forge_rock",
    description = ccb.content.text("A type of metallurgical furnace for smelting iron from its oxides."),
    symbol = "U",
    color = "light_red",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = -1,
    crafting_pseudo_item = "bloomery",
    flags = { "SEALED", "CONTAINER", "NOITEM", "EASY_DECONSTRUCT", "MINEABLE" },
    deconstruct = { drops = { { item = "rock", count = 30 } } },
    builtin_examine = "reload_furniture",
    bash = {
        minimum_strength = 18,
        maximum_strength = 50,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "rock", count = { 10, 20 } } },
    },
}
