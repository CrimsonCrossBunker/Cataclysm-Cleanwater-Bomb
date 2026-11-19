local ccb = require("ccb")

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36%, both arms are 18%, both legs are 36% leaving us with 16740 cm^2.
-- Wool has a density of 1.31g/cm^3, thickness of 0.1 cm leaves us with 2192 grams.
-- Nomex has a density of 1.38g/cm^3, thickness of 0.05 cm leaves us with 1154 grams.
-- Nylon has a density of 1.14g/cm^3, thickness of 0.05 cm and ~5% coverage leaves us with 48 grams - this is just for some reinforced pockets sewn on.
-- Totalled up this is 3394 grams - round up to 3500 to account for clasps, zippers, etc.
-- The odd encumbrance rounds down to 3-4 when fitted - usually will always be, but since it's hand-tailored to your body, it should be harder for someone else to wear compared to a one-size-fits-all commercial garment.
ccb.content.define_item {
    id = "lsurvivor_jumpsuit",
    category = "armor",
    name = ccb.content.text("handmade summer suit"),
    description = ccb.content.text("A form-fitting coverall jumpsuit made from scratch, made of durably woven wool and Nomex with reinforced pockets.  The moisture wicking fabric keeps you cool and it's comfortable to wear day-to-day while maintaining a moderate level of protection.  Note that while the Nomex layer is chemical resistant, the garment's permeability means it is a poor defense against chemical attacks"),
    mass = "3500 g",
    volume = "3000 ml",
    survival_price = "50 USD",
    materials = { "wool", "nomex" },
    symbol = "[",
    looks_like = "survivor_jumpsuit",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            moves = 110,
            max_item_length = "32 cm",
            description = ccb.content.text("Lower back pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
    },
    flags = { "VARSIZE", "POCKETS", "HOOD", "STURDY" },
    melee_damage = { bash = 2 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nomex", coverage = 95, thickness = 0.5 },
                },
                covers = { "torso", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 7, 9 },
            },
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nomex", coverage = 95, thickness = 0.5 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 7, 7 },
            },
        },
        warmth = 20,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "xl_lsurvivor_jumpsuit",
    name = ccb.content.text("handmade summer suit"),
    copy_from = "lsurvivor_jumpsuit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lsurvivor_jumpsuit",
    name = ccb.content.text("handmade summer suit"),
    copy_from = "lsurvivor_jumpsuit",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36%, both arms are 18%, both legs are 36% leaving us with 16740 cm^2.
-- Nylon has a density of 1.14g/cm^3, thickness of 0.15 cm leaves us with 2865 grams.
-- Kevlar has a density of 1.44g/cm^3, thickness of 0.2 cm leaves us with 4820 grams.
-- 0.05 cm Nylon pockets weigh about 50 gram total.
-- Totalled up this is 7736 grams, rounded up to 7750 to account for clasps, zippers etc.
-- The odd encumbrance rounds down to 6-7 when fitted - usually will always be, but since it's hand-tailored to your body, it should be harder for someone else to wear compared to a one-size-fits-all commercial garment.
ccb.content.define_item {
    id = "survivor_jumpsuit",
    category = "armor",
    name = ccb.content.text("handmade combat suit"),
    description = ccb.content.text("A form-fitting coverall jumpsuit consisting of stab-weave Kevlar and ripstop Nylon woven in layers to provide substantial protection from bites and cuts.  Has reinforced pockets sewn on for storage.  Lacking a rubber sealant, it is still reasonably breathable, and therefore offers only modest protection against chemical attacks despite its synthetic fabric construction."),
    mass = "7750 g",
    volume = "6500 ml",
    survival_price = "75 USD",
    materials = { "kevlar", "nylon" },
    symbol = "[",
    looks_like = "touring_suit",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            moves = 110,
            max_item_length = "32 cm",
            description = ccb.content.text("Lower back pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
    },
    flags = { "VARSIZE", "POCKETS", "HOOD", "STURDY", "RAINPROOF" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 95, thickness = 1.0 },
                    { id = "nylon_quilted", coverage = 100, thickness = 1.5 },
                },
                covers = { "torso", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 13, 15 },
            },
            {
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 95, thickness = 1.0 },
                    { id = "nylon_quilted", coverage = 100, thickness = 1.5 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 13, 13 },
            },
        },
        warmth = 30,
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "xlsurvivor_jumpsuit",
    name = ccb.content.text("handmade combat suit"),
    copy_from = "survivor_jumpsuit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xssurvivor_jumpsuit",
    name = ccb.content.text("handmade combat suit"),
    copy_from = "survivor_jumpsuit",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36%, both arms are 18%, both legs are 36% leaving us with 16740 cm^2.
-- Canvas density at 1.6 g/cm^3, thickness of 0.15 cm leaves us with 4015 grams.
-- Kevlar has a density of 1.44g/cm^3, thickness of 0.2 cm leaves us with 4820 grams.
-- Vinyl has a density of 1.4g/cm^3, thickness of 0.05 cm leaves us with 1171 grams.
-- Totalled up this is 10006 grams, rounded up to 10100 to account for clasps, zippers, etc.
ccb.content.define_item {
    id = "hsurvivor_jumpsuit",
    category = "armor",
    name = ccb.content.text("handmade hazard suit"),
    description = ccb.content.text("A heavy, restrictive coverall jumpsuit consisting of layered Kevlar and tough canvas.  Most importantly, it is sealed with a flexible polymer coating, making it almost impermeable to chemical attacks.  It does not mitigate radiation or electrical dangers, and is a real pain to wear all the time."),
    mass = "10100 g",
    volume = "8000 ml",
    survival_price = "75 USD",
    materials = { "kevlar", "canvas", "vinyl" },
    symbol = "[",
    looks_like = "survivor_suit",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            moves = 110,
            max_item_length = "32 cm",
            description = ccb.content.text("Lower back pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
    },
    flags = { "VARSIZE", "POCKETS", "HOOD", "RAINPROOF", "STURDY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 95, thickness = 1.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.5 },
                },
                covers = { "torso", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 21, 22 },
            },
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 95, thickness = 1.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.5 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 21, 21 },
            },
        },
        warmth = 35,
        environmental_protection = 10,
    },
}

ccb.content.define_item {
    id = "xl_hsurvivor_jumpsuit",
    name = ccb.content.text("handmade hazard suit"),
    copy_from = "hsurvivor_jumpsuit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.13, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hsurvivor_jumpsuit",
    name = ccb.content.text("handmade hazard suit"),
    copy_from = "hsurvivor_jumpsuit",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36%, both arms are 18%, both legs are 36% leaving us with 16740 cm^2.
-- Cotton has a density of 1.52g/cm^3, thickness of 0.15 cm leaves us with 3814 grams.
-- Fur has a density of ~1.1g/cm^3 based off of the materials json, thickness of 0.19 cm leaves us with 3499 grams.
-- Canvas is waterproofed (waxed, etc) cotton at 1.6 g/cm^3, thickness of 0.05 cm leaves us with 1338 grams.
-- 0.05 cm canvas pockets weigh about 75 grams total.
-- Totalled up this is 8726 grams, rounded up to 8800 to account for clasps, zippers, etc.
ccb.content.define_item {
    id = "wsurvivor_jumpsuit",
    category = "armor",
    name = ccb.content.text("handmade winter suit"),
    description = ccb.content.text("A stuffy coverall jumpsuit consisting of durably woven cotton lined with fur and a canvas outer layer.  Waterproof, and sturdier than pre-Cataclysm winter clothing, with numerous storage pockets.  However, it is noticeably encumbering and wearing it outside of cold weather is pretty much out of the question."),
    mass = "8800 g",
    volume = "8500 ml",
    survival_price = "75 USD",
    materials = { "cotton", "fur", "canvas" },
    symbol = "[",
    looks_like = "survivor_suit",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            moves = 110,
            max_item_length = "32 cm",
            description = ccb.content.text("Lower back pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
    },
    flags = { "VARSIZE", "WATERPROOF", "POCKETS", "HOOD", "RAINPROOF", "STURDY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 1.5 },
                    { id = "fur", coverage = 100, thickness = 1.0 },
                    { id = "fur", coverage = 95, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                },
                covers = { "torso", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 19, 20 },
            },
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 1.5 },
                    { id = "fur", coverage = 100, thickness = 1.0 },
                    { id = "fur", coverage = 95, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 19, 19 },
            },
        },
        warmth = 70,
        environmental_protection = 5,
    },
}

ccb.content.define_item {
    id = "xl_wsurvivor_jumpsuit",
    name = ccb.content.text("handmade winter suit"),
    copy_from = "wsurvivor_jumpsuit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wsurvivor_jumpsuit",
    name = ccb.content.text("handmade winter suit"),
    copy_from = "wsurvivor_jumpsuit",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "wsurvivor_jumpsuit_nofur",
    name = ccb.content.text("handmade faux fur winter suit"),
    description = ccb.content.text("A stuffy coverall jumpsuit consisting of durably woven cotton lined with faux fur and a canvas outer layer.  Waterproof, and sturdier than pre-Cataclysm winter clothing, with numerous storage pockets.  However, it is noticeably encumbering and wearing it outside of cold weather is pretty much out of the question."),
    copy_from = "wsurvivor_jumpsuit",
    materials = { "cotton", "faux_fur", "canvas" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 1.5 },
                    { id = "faux_fur", coverage = 100, thickness = 1.0 },
                    { id = "faux_fur", coverage = 95, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                },
                covers = { "torso", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 19, 20 },
            },
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 1.5 },
                    { id = "faux_fur", coverage = 100, thickness = 1.0 },
                    { id = "faux_fur", coverage = 95, thickness = 1.0 },
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 19, 19 },
            },
        },
    },
}

ccb.content.define_item {
    id = "xs_wsurvivor_jumpsuit_nofur",
    name = ccb.content.text("handmade faux fur winter suit"),
    copy_from = "wsurvivor_jumpsuit_nofur",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "xl_wsurvivor_jumpsuit_nofur",
    name = ccb.content.text("handmade faux fur winter suit"),
    copy_from = "wsurvivor_jumpsuit_nofur",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}
