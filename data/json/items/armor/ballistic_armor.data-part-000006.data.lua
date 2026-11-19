local ccb = require("ccb")

ccb.content.define_item {
    id = "xl_ballistic_vest",
    category = "armor",
    name = ccb.content.plural_text("ballistic vest", "ballistic vests"),
    description = ccb.content.text("An enormous handmade ballistic vest built with of lots of salvaged ballistic Kevlar panels.  It's bulkier than a factory made US Army vest, but it is customized for the benefit of an abnormally large mutant who couldn't wear such armors otherwise.  Coated in MOLLE webbing to support modular loadouts for the tacticool mutant.  It could be outfitted with steel plates for further protection."),
    mass = "4500 g",
    volume = "9 L",
    price = "1600 USD",
    survival_price = "10 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "OVERSIZE", "PREFIX_XL" },
    looks_like = "ballistic_vest_esapi",
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 8,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 12 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "xl_ballistic_vest_lc",
    category = "armor",
    name = ccb.content.plural_text("ballistic vest (mild steel plates)", "ballistic vests (mild steel plates)"),
    description = ccb.content.text("An enormous handmade ballistic vest built with lots of salvaged ballistic Kevlar panels and homemade \"ballistic inserts\" made of mild steel.  The thin metal isn't the most protective, but it's probably better than just plain Kevlar."),
    mass = "12500 g",
    volume = "9 L",
    survival_price = "15 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered", "lc_steel" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "OVERSIZE", "PREFIX_XL" },
    looks_like = "ballistic_vest_esapi",
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                    { id = "lc_steel", coverage = 85, thickness = 1.5 },
                },
                encumbrance = 14,
                coverage = 100,
                vitals_coverage = 95,
                covers = { "torso" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 12 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "xl_ballistic_vest_qt",
    category = "armor",
    name = ccb.content.plural_text("ballistic vest (tempered steel plates)", "ballistic vests (tempered steel plates)"),
    description = ccb.content.text("An enormous handmade ballistic vest made of lots of salvaged ballistic Kevlar panels and ten NIJ IIIA plates inserted into custom-made pockets - four each for your front and back and one each for your sides.  Monstrously heavy but extremely protective."),
    mass = "18000 g",
    volume = "9 L",
    price = "1600 USD",
    survival_price = "30 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered", "qt_steel" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "OVERSIZE", "PREFIX_XL" },
    looks_like = "ballistic_vest_esapi",
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                    { id = "qt_steel", coverage = 90, thickness = 2.5 },
                },
                encumbrance = 20,
                coverage = 100,
                vitals_coverage = 95,
                covers = { "torso" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 12 }, { kind = "detach_molle" } },
}
