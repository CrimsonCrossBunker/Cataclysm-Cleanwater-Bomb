local ccb = require("ccb")

ccb.content.define_item {
    id = "flux_comp_gen",
    name = "explosively pumped flux compression generator",
    description = "A large device consisting mainly of a tube of copper wire surrounding a large copper tube filled with high explosives.  When detonated properly, the explosives allow the device to produce large amounts of electrical energy in a very short time.",
    symbol = "|",
    color = "brown",
    category = "spare_parts",
    looks_like = "cu_pipe",
    mass = "3589 g",
    volume = "10455 ml",
    price = "100 USD",
    survival_price = "5 USD",
    stackable = true,
    explode_in_fire = true,
    materials = { "copper" },
    blast = {
        power = 600,
        shrapnel = { casing_mass = 3214, fragment_mass = 0.25 },
    },
}
