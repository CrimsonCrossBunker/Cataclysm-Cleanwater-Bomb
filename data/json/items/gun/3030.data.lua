local ccb = require("ccb")

-- Based off https://www.winchesterguns.com/products/rifles/model-94/model-94-sporter.html
ccb.content.define_item {
    id = "winchester_94_3030",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("8-shot lever-action rifle"),
    description = ccb.content.text("A lever action rifle, chambered for 8 rounds of 30-30 Winchester.  Ideally used with a cowboy hat and six-shooter."),
    variant_kind = "gun",
    variants = {
        {
            id = "winchester_94_3030",
            name = ccb.content.text("Winchester Model 94"),
            description = ccb.content.text("A design that's existed for over 100 years, the Model 94 still persists to this day, and in the designs of many other lever-action rifles.  This one is chambered for 30-30."),
        },
    },
    mass = "3302 g",
    volume = "2702 ml",
    length = "1089 mm",
    price = "1 kUSD 629 USD 99 cent",
    survival_price = "15 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["3030"] = 8 } } },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "610 mm",
        ammunition = { "3030" },
        dispersion = 180,
        clip_size = 8,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- Based off https://www.marlinfirearms.com/s/model_336Classic
ccb.content.define_item {
    id = "marlin_336_3030",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("6-shot lever-action rifle"),
    description = ccb.content.text("A lever action rifle, chambered for 6 rounds of 30-30 Winchester.  Ideally used with a cowboy hat and six-shooter."),
    variant_kind = "gun",
    variants = {
        {
            id = "marlin_336_3030",
            name = ccb.content.text("Marlin Model 336"),
            description = ccb.content.text("A slightly more modern design of the Marlin 1893, the Marlin Model 336 remains a popular rifle in civilian spaces to this day, even despite the age of its design and its cartridge."),
        },
    },
    mass = "3402 g",
    volume = "2557 ml",
    length = "981 mm",
    price = "1 kUSD 239 USD",
    survival_price = "15 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["3030"] = 6 } } },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "514 mm",
        ammunition = { "3030" },
        dispersion = 240,
        clip_size = 6,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
