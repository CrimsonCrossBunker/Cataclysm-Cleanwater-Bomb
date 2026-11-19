local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_flower_marloss",
    name = ccb.content.text("Marloss flower"),
    description = ccb.content.text("This flower looks mostly like the other flowers taken by the mushrooms, but its bulb is a brilliant cyan color.  It emits an aroma that is both overwhelming and strangely alluring."),
    symbol = "f",
    color = "cyan",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "FUNGUS", "TINY", "NOCOLLIDE" },
    builtin_examine = "flower_marloss",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("poof."),
        failure_sound = ccb.content.text("poof."),
    },
}

ccb.content.define_furniture {
    id = "f_flower_fungal",
    name = ccb.content.text("fungal flower"),
    description = ccb.content.text("This flower has been overgrown by gray, sinewy tendrils of fungus, and the color has been leached from its petals and stem.  It gently sways of its own volition, maintaining an unsettling rhythm."),
    symbol = "f",
    color = "dark_gray",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLOWER", "FUNGUS", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "GRAZER_INEDIBLE" },
    builtin_examine = "fungus",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("poof."),
        failure_sound = ccb.content.text("poof."),
    },
}

ccb.content.define_furniture {
    id = "f_fungal_mass",
    name = ccb.content.text("fungal mass"),
    description = ccb.content.text("Thick ropes of Mycal matter have covered the ground here completely.  It's soft to the touch, but not firm enough to hold any weight."),
    symbol = "O",
    background_color = "dark_gray",
    move_cost_mod = -10,
    required_strength = -1,
    flags = { "CONTAINER", "SEALED", "ALLOW_FIELD_EFFECT", "FLAMMABLE_ASH", "FUNGUS", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 30,
        sound = ccb.content.text("poof."),
        failure_sound = ccb.content.text("poof."),
    },
}

ccb.content.define_furniture {
    id = "f_fungal_clump",
    name = ccb.content.text("fungal clump"),
    description = ccb.content.text("Alien mold and stems mingle tightly here, swaying around and weaving together, creating a sort of fungal bush."),
    symbol = "#",
    background_color = "light_gray",
    move_cost_mod = 3,
    required_strength = -1,
    flags = {
        "TRANSPARENT",
        "CONTAINER",
        "SEALED",
        "ALLOW_FIELD_EFFECT",
        "FLAMMABLE_ASH",
        "FUNGUS",
        "MOUNTABLE",
        "SHORT",
    },
    bash = {
        minimum_strength = 6,
        maximum_strength = 20,
        sound = ccb.content.text("poof."),
        failure_sound = ccb.content.text("poof."),
    },
}

ccb.content.define_furniture {
    id = "f_fungal_tangle",
    name = ccb.content.text("fungal tangle"),
    description = ccb.content.text("Thick, ropy tendrils of fungus have risen from the ground and gathered into an impenetrable clump."),
    looks_like = "mon_fungal_wall",
    symbol = "&",
    background_color = "light_gray",
    move_cost_mod = -1,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "FUNGUS" },
    bash = {
        minimum_strength = 26,
        maximum_strength = 50,
        sound = ccb.content.text("poof."),
        failure_sound = ccb.content.text("squelch."),
    },
}
