local ccb = require("ccb")

-- While heavy, most large pianos have casters for relatively easy movement.
ccb.content.define_furniture {
    id = "f_piano",
    name = ccb.content.text("piano"),
    description = ccb.content.text("An elegant piano, capable of producing beautiful music if used by a skilled player.  A set of off-white and black keys are linked to a set of hammers, which strike their corresponding tightly-coiled wire to produce sound."),
    symbol = "P",
    color = "i_black",
    move_cost_mod = 6,
    coverage = 70,
    required_strength = 8,
    mass = "317 kg",
    flags = { "FLAMMABLE", "ORGANIC", "BLOCKSDOOR", "EASY_DECONSTRUCT", "SMALL_HIDE" },
    base_item = "piano",
    bash = {
        minimum_strength = 12,
        maximum_strength = 40,
        sound = ccb.content.text("a suffering piano!"),
        failure_sound = ccb.content.text("kerchang."),
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    examine_handler = "examine_f_piano",
}
