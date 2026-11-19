local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_sealed_intermodal_crate_locked",
    name = ccb.content.text("powered down intermodal crate"),
    description = ccb.content.text("A sealed metal crate used to ferry cargo to and from orbit.  This one appears to be secured with an electric lock that has shut down."),
    looks_like = "f_sealed_intermodal_crate",
    required_strength = -1,
    symbol = "O",
    background_color = "brown",
    move_cost_mod = -1,
    coverage = 60,
    oxytorch = { result = "f_intermodal_crate_open", duration = "14 seconds" },
    flags = { "TRANSPARENT", "MOUNTABLE", "SHORT", "SMALL_HIDE", "PLACE_ITEM", "CONTAINER", "SEALED" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 200,
        sound = ccb.content.text("screeching metal!"),
        failure_sound = ccb.content.text("whump!"),
        drops = {
            { item = "ch_steel_chunk", count = { 1, 5 } },
            { item = "scrap", count = { 1, 5 } },
            { item = "afs_circuitry_1", count = { 1, 2 } },
        },
    },
}
