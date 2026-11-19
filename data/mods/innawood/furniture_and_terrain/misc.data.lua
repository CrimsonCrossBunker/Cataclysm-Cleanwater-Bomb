local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_beaver_dam",
    name = ccb.content.text("dam"),
    description = ccb.content.text("A house that beavers built.  The entrance is underwater making it harder for predators to access."),
    symbol = "#",
    color = "brown",
    looks_like = "t_wall_log",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "TRANSPARENT" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 12,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("bonk."),
        drops = {
            { item = "twig", count = { 5, 12 } },
            { item = "stick", count = { 5, 12 } },
            { item = "stick_long", count = { 5, 12 } },
            { item = "splinter", count = { 12, 38 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}
