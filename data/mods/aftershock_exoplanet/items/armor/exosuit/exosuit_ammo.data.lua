local ccb = require("ccb")

ccb.content.define_item {
    id = "mining_rod",
    copy_from = "rebar_rail",
    name = ccb.content.text("mining rod"),
    description = ccb.content.text("A surprisingly heavy rod with a tungsten core, this looks like it could pierce a tank.  When fired from a mining rod launcher, it will briefly map out the area surrounding the impact."),
    materials = { "carbide", "superalloy" },
    color = "light_gray",
    ammunition = {
        type = "metal_rail",
        dispersion = 0,
        effects = { "NON_FOULING", "SEISMIC_MAPPING" },
        damage = { type = "bullet", amount = 80, penetration = 40 },
    },
}
