local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_xedra_frozen_person_dead",
    name = ccb.content.text("unmoving figure"),
    looks_like = "f_statue",
    description = ccb.content.text("A person stands before you, completely motionless in spite of the horrific wound marring their body.  Every part of their figure is leeched of color, and you are completely incapable of affecting them in any way."),
    symbol = "@",
    color = "dark_gray",
    move_cost_mod = -1,
    coverage = 50,
    required_strength = -1,
}

-- Just a copy from the Magiclysm one
ccb.content.define_furniture {
    id = "f_alembic",
    name = ccb.content.text("standing alembic"),
    looks_like = "f_alembic",
    description = ccb.content.text("A large glass and copper alembic for distilling alchemical concoctions.  It consists of a copper pot with rising spires of twisted glass draining into various removable bottles."),
    symbol = "&",
    color = "light_blue",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = -1,
    crafting_pseudo_item = "still_lab",
    flags = { "TRANSPARENT", "NOITEM" },
    deconstruct = {
        drops = {
            { item = "pot_copper", count = 1 },
            { item = "pipe_glass", count = { 1, 4 } },
            { item = "glass_tube_small", count = { 5, 10 } },
            { item = "stopcock", count = { 1, 5 } },
            { item = "flask_glass", count = { 1, 3 } },
        },
    },
    max_volume = "1750 L",
    bash = {
        minimum_strength = 4,
        maximum_strength = 10,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap_copper", count = { 10, 20 } },
            { item = "stopcock", count = { 1, 5 } },
            { item = "glass_shard", count = { 25, 50 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_xe_magic_circle",
    name = ccb.content.text("magick circle"),
    looks_like = "f_magic_circle",
    move_cost_mod = 0,
    symbol = "O",
    color = "red",
    required_strength = -1,
    flags = { "ALLOW_FIELD_EFFECT", "TRANSPARENT" },
    description = ccb.content.text("This is a rough magic circle, carved into the ground and decorated with blood, candles, and other small knick-knacks."),
}
