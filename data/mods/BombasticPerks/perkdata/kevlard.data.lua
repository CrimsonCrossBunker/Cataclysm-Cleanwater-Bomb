local ccb = require("ccb")

-- No encumbrance, obesity penalties already account for it
ccb.content.define_item {
    id = "integrated_kevlard_obese",
    category = "armor",
    name = ccb.content.plural_text("kevlard I", "kevlard I"),
    description = ccb.content.text("Your fat protects you from bullets, a little.  Maybe eat more."),
    mass = "0 kg",
    volume = "0 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh", "kevlar_layered" },
    symbol = "x",
    color = "magenta",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "SOFT",
        "ZERO_WEIGHT",
        "TRADER_AVOID",
    },
    armor = {
        warmth = 0,
        environmental_protection = 0,
        portions = {
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 2.5 },
                    {
                        id = "kevlar_layered",
                        coverage = 90,
                        thickness = 2.2,
                        ignore_sheet_thickness = true,
                    },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 0,
                breathability = "SECOND_SKIN",
            },
        },
    },
}

-- No encumbrance, obesity penalties already account for it
ccb.content.define_item {
    id = "integrated_kevlard_veryobese",
    category = "armor",
    name = ccb.content.plural_text("kevlard II", "kevlard II"),
    description = ccb.content.text("Your fat protects you from bullets, but there's still room for improvement."),
    mass = "0 kg",
    volume = "0 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh", "kevlar_layered" },
    symbol = "x",
    color = "magenta",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "SOFT",
        "ZERO_WEIGHT",
        "TRADER_AVOID",
    },
    armor = {
        warmth = 0,
        environmental_protection = 0,
        portions = {
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 5.0 },
                    {
                        id = "kevlar_layered",
                        coverage = 95,
                        thickness = 3.3,
                        ignore_sheet_thickness = true,
                    },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 0,
                breathability = "SECOND_SKIN",
            },
        },
    },
}

-- No encumbrance, obesity penalties already account for it
ccb.content.define_item {
    id = "integrated_kevlard_morbidlyobese",
    category = "armor",
    name = ccb.content.plural_text("kevlard III", "kevlard III"),
    description = ccb.content.text("Your substantial fat deflects bullets with ease."),
    mass = "0 kg",
    volume = "0 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh", "kevlar_layered" },
    symbol = "x",
    color = "magenta",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "SOFT",
        "ZERO_WEIGHT",
        "TRADER_AVOID",
    },
    armor = {
        warmth = 0,
        environmental_protection = 0,
        portions = {
            {
                materials = {
                    { id = "hflesh", coverage = 100, thickness = 7.5 },
                    {
                        id = "kevlar_layered",
                        coverage = 100,
                        thickness = 4.4,
                        ignore_sheet_thickness = true,
                    },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 0,
                breathability = "SECOND_SKIN",
            },
        },
    },
}
