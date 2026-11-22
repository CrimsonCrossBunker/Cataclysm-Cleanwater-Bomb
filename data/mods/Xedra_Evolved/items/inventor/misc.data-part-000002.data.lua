local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_portal_closer",
    name = "Netherium-Reality Smoothing Device",
    description = "An enormous industrial press shaped device, covered in sensors, circuits, and other doodads.  Two inverted teleporters are located on each side of the hammers, poised to perfectly align at the end of a strike.  Doing so will smoothen the overall local barrier between Earth and other realities, filling in any holes at the expense of weakening it in a much wider area.  This is an overall positive effect, allowing you to heal tears that would never naturally close, but expect large temporary side-effects.",
    symbol = "#",
    looks_like = "box_large_metal",
    mass = "226 kg",
    volume = "601475 ml",
    length = "1495 mm",
    price = "100000 USD",
    survival_price = "1000 USD",
    flags = { "ELECTRONIC", "INVENTOR_CRAFTED" },
    materials = { "mc_steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "10 L",
            mass_limit = "20 kg",
            default_magazine = "inventor_heavy_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY", "BATTERY_MEDIUM" },
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    use_actions = {
        { kind = "cast_spell", spell = "inventor_portal_closer_spell", level = 0, no_fail = true },
    },
    tool = { charges_per_use = 3125, ammo_types = "battery" },
}
