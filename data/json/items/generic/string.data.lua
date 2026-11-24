local ccb = require("ccb")

ccb.content.define_item {
    id = "string_6",
    category = "spare_parts",
    name = ccb.content.plural_text("short string", "short strings"),
    description = ccb.content.text("A 6-inch (or about 15 cm) long piece of cotton string."),
    mass = "5 g",
    volume = "10ml",
    price = "10 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = ",",
    color = "light_gray",
    flags = { "NO_SALVAGE" },
    stackable = true,
}

ccb.content.define_item {
    id = "string_36",
    copy_from = "string_6",
    name = ccb.content.plural_text("long string", "long strings"),
    description = ccb.content.text("A 3-foot (or about 90 cm) long piece of cotton string."),
    inheritance = { scale = { mass = 6, volume = 6, price = 6 } },
}

-- Universal pocket, can store almost anything sans liquid, at the price of high move and encumbrance cost.
ccb.content.define_item {
    id = "rope_6",
    copy_from = "string_36",
    name = ccb.content.plural_text("short rope", "short ropes"),
    description = ccb.content.text("A 6-foot (or about 180 cm) long piece of rope.  Wear it over a shoulder and tie items to it as a temporary carrying solution."),
    stackable = false,
    pockets = {
        {
            capacity = "10 L",
            mass_limit = "5 kg",
            max_item_length = "110 cm",
            moves = 2000,
            holster = true,
        },
    },
    inheritance = {
        add = { flags = { "TIE_UP", "BELTED", "WATER_FRIENDLY", "OVERSIZE" } },
        scale = { mass = 6, volume = 6, price = 6 },
    },
    armor = {
        portions = {
            {
                materials = { { id = "cotton", coverage = 100, thickness = 2.0 } },
                encumbrance = 3,
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Tie what to the rope?"),
            message = ccb.content.text("You use an elaborate knot to tie your %s to your %s"),
        },
    },
}

-- Universal pocket, can store almost anything sans liquid and very small items, at the price of high move and encumbrance cost.
ccb.content.define_item {
    id = "rope_30",
    copy_from = "rope_6",
    name = ccb.content.text("long rope"),
    description = ccb.content.text("A 30-foot (or about 9 m) long rope.  Useful for keeping yourself safe from falls.  Wear it over a shoulder and tie items to it as a temporary carrying solution."),
    qualities = { { id = "ROPE", level = 2 } },
    pockets = {
        {
            min_item_volume = "100 ml",
            capacity = "10 L",
            mass_limit = "10 kg",
            max_item_length = "110 cm",
            moves = 3000,
            holster = true,
        },
    },
    armor = {
        portions = {
            {
                materials = { { id = "cotton", coverage = 100, thickness = 6.0 } },
                encumbrance = 12,
                coverage = 10,
                covers = { "torso" },
            },
        },
    },
    inheritance = { scale = { mass = 5, volume = 5, price = 5 } },
}

-- Universal pocket, can store almost anything sans liquid, at the price of high move and encumbrance cost.
ccb.content.define_item {
    id = "seatbelt",
    copy_from = "rope_6",
    name = ccb.content.plural_text("seat belt", "seat belts"),
    description = ccb.content.text("A length of synthetic fiber weaved into a flat band, usually used to securely fasten passenger inside vehicles."),
    materials = { "nylon" },
    mass = "800 g",
    volume = "696 ml",
    pockets = {
        {
            capacity = "10 L",
            mass_limit = "5 kg",
            max_item_length = "110 cm",
            moves = 2000,
            holster = true,
        },
    },
    inheritance = { add = { flags = { "TIE_UP", "BELTED", "WATER_FRIENDLY", "OVERSIZE" } } },
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 1.0 } },
                encumbrance = 3,
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Tie what to the rope?"),
            message = ccb.content.text("You use an elaborate knot to tie your %s to your %s"),
        },
    },
}

ccb.content.define_item {
    id = "stick_fiber",
    category = "spare_parts",
    name = ccb.content.text("fibrous stalk"),
    symbol = "=",
    materials = { "dry_plant" },
    description = ccb.content.text("A rather green stick.  Very fibrous."),
    volume = "100 ml",
    mass = "80 g",
    comestible = { kind = "INVALID", fun = -100, healthy = -20 },
}
