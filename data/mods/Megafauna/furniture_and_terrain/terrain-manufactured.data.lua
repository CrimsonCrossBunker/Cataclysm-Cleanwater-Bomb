local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_glypto_shelter",
    name = ccb.content.text("glyptodont-shell shelter"),
    description = ccb.content.text("Improvised shelter made of a glyptodont shell, providing a little bit of protection against the elements or predators."),
    symbol = "O",
    color = "brown",
    looks_like = "t_leanto",
    move_cost = 2,
    coverage = 60,
    floor_bedding_warmth = 800,
    comfort = 1,
    connect_groups = "INDOORFLOOR",
    flags = { "CONTAINER", "FLAMMABLE_ASH", "REDUCE_SCENT", "INDOORS", "MOUNTABLE", "HIDE_PLACE", "NO_SIGHT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 60,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whump."),
        terrain = "t_pit_shallow",
        drops = { { item = "stick", count = { 0, 1 } }, { item = "glypto_shell", count = { 1, 1 } } },
    },
}
