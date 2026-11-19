local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_hay",
    name = ccb.content.text("bale of hay"),
    description = ccb.content.text("A massive packed-together block of hay, it makes for easy storage of straw for livestock.  If your only other option is the floor, it makes a tolerable bed."),
    symbol = "#",
    background_color = "yellow",
    move_cost_mod = 3,
    comfort = 2,
    floor_bedding_warmth = 100,
    required_strength = 6,
    mass = "30 kg",
    flags = {
        "TRANSPARENT",
        "CONTAINER",
        "FLAMMABLE_ASH",
        "ORGANIC",
        "MOUNTABLE",
        "SHORT",
        "EASY_DECONSTRUCT",
    },
    deconstruct = {
        drops = { { item = "straw_pile", count = 40 }, { item = "rope_makeshift_30", count = 1 } },
    },
    bash = {
        minimum_strength = 1,
        maximum_strength = 12,
        sound = ccb.content.text("whish!"),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "straw_pile", count = { 6, 10 } }, { item = "rope_makeshift_6", count = { 1, 3 } } },
    },
}

ccb.content.define_furniture {
    id = "f_woodchips",
    name = ccb.content.text("pile of woodchips"),
    symbol = "X",
    description = ccb.content.text("A large mound of piled wood chips.  Unpleasant to lay on, hard to walk through, and a large fire hazard, it's probably best to shovel it out of the way."),
    color = "brown",
    move_cost_mod = 6,
    max_volume = "750 L",
    required_strength = -1,
    flags = {
        "TRANSPARENT",
        "UNSTABLE",
        "ROUGH",
        "PLACE_ITEM",
        "MOUNTABLE",
        "CONTAINER",
        "SEALED",
        "ALLOW_FIELD_EFFECT",
        "TINY",
        "RUBBLE",
    },
    builtin_examine = "rubble",
}
