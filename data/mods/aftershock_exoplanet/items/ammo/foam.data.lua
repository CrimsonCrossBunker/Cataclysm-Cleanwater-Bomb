local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_foamcrete",
    name = ccb.content.plural_text("foamcrete", "foamcrete"),
    description = ccb.content.text("The chemical precursors of foamcrete, a quick-hardening, resilient substance that readily expands on contact with air.  Originally designed for structural repair in commercial spaceflight, it can be used to quickly erect walls and platforms, or to encase foes."),
    mass = "250 g",
    volume = "2 L",
    price = "35 USD",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "=",
    color = "light_gray",
    default_container = "afs_foam_tank",
    phase = "liquid",
    ammunition = {
        type = "afs_foam",
        range = 8,
        count = 30,
        effects = { "FOAMCRETE", "JET", "NO_PENETRATE_OBSTACLES" },
    },
}

ccb.content.define_item {
    id = "afs_foamtoxic",
    name = ccb.content.plural_text("wide-range pesticide", "wide-range pesticide"),
    description = ccb.content.text("An old Thistle Industries neurotoxic pesticide that can be used to kill insects, plants, mammals, nematodes, fungi and most organisms not genetically engineered to withstand its assault.  Even short exposure is likely to prove fatal.  Frontier rated only."),
    mass = "250 g",
    volume = "2 L",
    price = "150 USD",
    survival_price = "150 USD",
    materials = { "water" },
    symbol = "=",
    color = "light_green",
    default_container = "afs_foam_tank",
    phase = "liquid",
    ammunition = {
        type = "afs_foam",
        range = 8,
        count = 30,
        effects = { "TOXIC_FOAM", "JET", "NO_PENETRATE_OBSTACLES", "NO_OVERSHOOT" },
    },
}
