local ccb = require("ccb")

ccb.content.define_item {
    id = "robofac_lens_mask_bal",
    category = "armor",
    name = ccb.content.text("Hub 01 LENS ballistic mask"),
    description = ccb.content.text("A ballistic mask with many tiny vents holes, designed to form a tight seal with a Hub 01 LENS helmet.  Warm and cumbersome, but very protective."),
    mass = "512 g",
    volume = "750 ml",
    price = "200 USD",
    survival_price = "45 USD 50 cent",
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    symbol = "[",
    looks_like = "mask_filter",
    color = "dark_gray",
    flags = { "WATERPROOF", "STURDY", "PADDED", "ROBOFAC_LENS_ACCESSORY" },
    armor = {
        thickness = 7,
        warmth = 30,
        environmental_protection = 1,
        portions = { { encumbrance = 20, coverage = 100, covers = { "mouth" } } },
    },
}
