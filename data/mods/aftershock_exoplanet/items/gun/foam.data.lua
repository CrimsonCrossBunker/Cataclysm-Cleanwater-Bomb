local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_foamgun",
    looks_like = "nailgun",
    name = ccb.content.text("foam gun"),
    description = ccb.content.text("A stubby industrial tool used to shoot expanding foam.  Using it as a weapon might require some creative thinking."),
    mass = "3904 g",
    volume = "750 ml",
    price = "130 USD",
    survival_price = "50 USD",
    materials = { "plastic", "steel" },
    symbol = "(",
    color = "yellow",
    flags = { "NEVER_JAMS", "NON_FOULING", "BELT_CLIP" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "afs_foam_tank" },
        },
    },
    melee_damage = { bash = 6 },
    gun = {
        reload_noise = ccb.content.text("pshht"),
        ammunition = { "afs_foam" },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("1s."), quantity = 1 },
            { id = "MULTI", label = ccb.content.text("3s."), quantity = 3 },
        },
        skill = "launcher",
        dispersion = 300,
        durability = 8,
        loudness = 5,
        reload_time = 50,
        mod_locations = {
            { id = "grip mount", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
