local ccb = require("ccb")

-- 20
ccb.content.define_item {
    id = "gambeson",
    category = "armor",
    name = ccb.content.text("padded gambeson"),
    description = ccb.content.text("A padded greatcoat assembled by quilting readily available fabric and stuffing the layers with waste fabric or horse hair that was intended as standalone armor, being too thick to comfortably fit a cuirass over.  Likely either a historical artifact or a low-quality reproduction.  Though inferior to a proper layered aketon or gambeson it still offers decent protection."),
    mass = "3750 g",
    volume = "7500 ml",
    price = "200 USD",
    survival_price = "15 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "jacket_light",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 50,
        portions = {
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 2.5 },
                    { id = "cotton", coverage = 95, thickness = 2.5 },
                    { id = "cotton", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 2 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 25,
            },
            {
                materials = { { id = "cotton_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 7,
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gambeson",
    copy_from = "gambeson",
    name = ccb.content.text("padded gambeson"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "gambeson_xs",
    copy_from = "gambeson",
    name = ccb.content.text("padded gambeson"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- 20
ccb.content.define_item {
    id = "gambeson_vest",
    category = "armor",
    name = ccb.content.text("padded gambeson vest"),
    description = ccb.content.text("A thick padded surcoat assembled by quilting readily available fabric and stuffing the layers with waste fabric or horse hair that was intended as standalone armor, being too thick to comfortably fit a cuirass over.  Likely either a historical artifact or a low-quality reproduction.  Though inferior to a proper layered gambeson its sheer thickness is still quite protective."),
    mass = "3 kg",
    volume = "6000 ml",
    price = "200 USD",
    survival_price = "10 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "vest",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 50,
        portions = {
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 2 },
                    { id = "cotton", coverage = 95, thickness = 2.5 },
                    { id = "cotton", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = { { id = "cotton_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 7,
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gambeson_vest",
    name = ccb.content.text("padded gambeson vest"),
    copy_from = "gambeson_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "gambeson_vest_xs",
    copy_from = "gambeson_vest",
    name = ccb.content.text("padded gambeson vest"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gambeson_pants",
    category = "armor",
    name = ccb.content.plural_text("padded arming pants", "padded arming pants"),
    description = ccb.content.text("Thick pants made of quilted fabric, meant to be worn alongside a gambeson under or without armor."),
    mass = "875 g",
    volume = "1750 ml",
    price = "140 USD",
    survival_price = "10 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "pants",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 30,
        portions = {
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 1 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 15,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gambeson_pants",
    name = ccb.content.plural_text("padded arming pants", "padded arming pants"),
    copy_from = "gambeson_pants",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "gambeson_pants_xs",
    name = ccb.content.plural_text("padded arming pants", "padded arming pants"),
    copy_from = "gambeson_pants",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- made of double layer cotton, so based off the canvas coif
-- human head total is about 2.5 sq. feet.  76g (canvas) x 8 (layers) x 1.25 (surface area) = 760g
ccb.content.define_item {
    id = "gambeson_hood",
    category = "armor",
    name = ccb.content.text("padded coif"),
    description = ccb.content.text("A cloth coif with neck and forehead protection.  Resting on your shoulders, it serves as padding for a helmet.  Though it's pretty warm, it is constructed of stuffed cloth layers and provides moderate protection."),
    mass = "250 g",
    volume = "500 ml",
    survival_price = "10 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "cowl_wool",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "SKINTIGHT", "WATERPROOF" },
    armor = {
        warmth = 25,
        thickness = 2.0,
        portions = {
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 0.5 },
                    { id = "cotton", coverage = 95, thickness = 1.5 },
                },
                covers = { "head" },
                subparts = {
                    "head_throat",
                    "head_ear_l",
                    "head_ear_r",
                    "head_forehead",
                    "head_crown",
                    "head_nape",
                },
                coverage = 100,
                encumbrance_modifiers = { "WELL_SUPPORTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_hood",
    name = ccb.content.text("padded coif"),
    copy_from = "gambeson_hood",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_hood",
    name = ccb.content.text("padded coif"),
    copy_from = "gambeson_hood",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq for the whole surface area of the body
-- roughly 0.25mm per sheet of canvas making this a 14-layer jack, sheets are 1x2 feet. 49 sheets for the vest and 18 sheets for the arms (67 total).
-- human torso is about 7 sq. feet.  76g (canvas) x 14 (layers) x 3.5 (surface area) = 3724g
-- human arms is about 3 sq. feet.  76g (canvas) x 12 (layers) x 1.5 (surface area) = 1368g
-- 5092g combined
ccb.content.define_item {
    id = "aketon_canvas",
    category = "armor",
    name = ccb.content.text("canvas aketon"),
    description = ccb.content.text("A thick cloth jack, intended to be worn below metal armor.  This one is made of over a dozen layers of tough canvas, and it provides fairly decent protection on its own."),
    mass = "5092 g",
    volume = "3500 ml",
    survival_price = "40 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "fencing_jacket",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "WATERPROOF" },
    armor = {
        warmth = 30,
        thickness = 3.5,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 10,
            },
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 15,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_canvas",
    name = ccb.content.text("canvas aketon"),
    copy_from = "aketon_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_canvas",
    name = ccb.content.text("canvas aketon"),
    copy_from = "aketon_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of canvas making this a 14-layer jack, sheets are 1x2 feet. 49 sheets total.
-- human torso is about 7 sq. feet.  76g (canvas) x 14 (layers) x 3.5 (surface area) = 3724g
ccb.content.define_item {
    id = "aketon_canvas_vest",
    category = "armor",
    name = ccb.content.text("canvas aketon vest"),
    description = ccb.content.text("A thick cloth vest, intended to be worn below metal armor.  This one is made of over a dozen layers of tough canvas, and it provides fairly decent protection on its own."),
    mass = "3724 g",
    volume = "2500 ml",
    survival_price = "25 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "vest",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "WATERPROOF" },
    armor = {
        warmth = 30,
        thickness = 3.5,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_canvas_vest",
    name = ccb.content.text("canvas aketon vest"),
    copy_from = "aketon_canvas_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_canvas_vest",
    name = ccb.content.text("canvas aketon vest"),
    copy_from = "aketon_canvas_vest",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of canvas making these 12 layer pants, sheets are 1x2 feet. 36 sheets total
-- human legs is about 6 sq. feet.  76g (canvas) x 12 (layers) x 3 (surface area) = 2736g
ccb.content.define_item {
    id = "aketon_pants_canvas",
    category = "armor",
    name = ccb.content.plural_text("canvas arming pants", "canvas arming pants"),
    description = ccb.content.text("Tough cloth pants worn alongside an aketon underneath metal armor.  These are made of many layers of canvas offering solid protection."),
    mass = "2736 g",
    volume = "1750 ml",
    survival_price = "25 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "fencing_pants",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "WATERPROOF" },
    armor = {
        warmth = 30,
        thickness = 3.0,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 15,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_pants_canvas",
    name = ccb.content.plural_text("canvas arming pants", "canvas arming pants"),
    copy_from = "aketon_pants_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_pants_canvas",
    name = ccb.content.plural_text("canvas arming pants", "canvas arming pants"),
    copy_from = "aketon_pants_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of canvas making this 8 layers, sheets are 1x2 feet. 10 sheets total
-- human head total is about 2.5 sq. feet.  76g (canvas) x 8 (layers) x 1.25 (surface area) = 760g
ccb.content.define_item {
    id = "aketon_hood_canvas",
    category = "armor",
    name = ccb.content.text("canvas coif"),
    description = ccb.content.text("A cloth coif with neck and forehead protection.  Resting on your shoulders, it serves as padding for a helmet.  Though it's pretty warm, it is constructed of tough canvas and provides substantial protection even on its own."),
    mass = "760 g",
    volume = "500 ml",
    survival_price = "10 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "cowl_wool",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "SKINTIGHT", "WATERPROOF" },
    armor = {
        warmth = 25,
        thickness = 2.0,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 1.0 },
                },
                covers = { "head" },
                subparts = {
                    "head_throat",
                    "head_ear_l",
                    "head_ear_r",
                    "head_forehead",
                    "head_crown",
                    "head_nape",
                },
                coverage = 100,
                encumbrance_modifiers = { "WELL_SUPPORTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_hood_canvas",
    name = ccb.content.text("canvas coif"),
    copy_from = "aketon_hood_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_hood_canvas",
    name = ccb.content.text("canvas coif"),
    copy_from = "aketon_hood_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of canvas making this 8 layers, sheets are 1x2 feet. 4 sheets total
-- human hands assumed to be about 1 sq ft total, 76g (canvas) x 8 (layers) x 0.5 (surface area) = 304g
ccb.content.define_item {
    id = "aketon_gloves_canvas",
    category = "armor",
    name = ccb.content.plural_text("canvas arming gloves (pair)", "canvas arming gloves (pair)"),
    description = ccb.content.text("Tough gloves made of canvas cloth, thin enough to wear under metal gauntlets.  They help to keep your hands safe during a fight."),
    mass = "304 g",
    volume = "250 ml",
    survival_price = "10 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "gloves_work",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 25,
        thickness = 2.0,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 1.0 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 20,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_gloves_canvas",
    name = ccb.content.plural_text("canvas arming gloves (pair)", "canvas arming gloves (pair)"),
    copy_from = "aketon_gloves_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_gloves_canvas",
    name = ccb.content.plural_text("canvas arming gloves (pair)", "canvas arming gloves (pair)"),
    copy_from = "aketon_gloves_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- roughly 0.25mm per sheet of canvas making this a 30-layer jack, sheets are 1x2 feet. 105 sheets for the vest and 36 sheets for the arms (141 total).
-- human torso is about 7 sq. feet.  76g (canvas) x 30 (layers) x 3.5 (surface area) = 7980g
-- human arms is about 3 sq. feet.  76g (canvas) x 24 (layers) x 1.5 (surface area) = 2736g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 1140g if 15 sheets.
-- 7980g + 2736g + 1140g = 11856g combined
-- 50
-- 20
ccb.content.define_item {
    id = "gambeson_canvas",
    category = "armor",
    name = ccb.content.text("canvas gambeson"),
    description = ccb.content.text("A thick cloth greatcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thirty layers of tough canvas, this will protect you from almost everything, but it's very heavy and warm.  The sleeves are a bit thinner for flexibility and it drapes below your legs, providing additional protection there."),
    mass = "11856 g",
    volume = "7500 ml",
    survival_price = "85 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "gambeson",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "BLOCK_WHILE_WORN", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 60,
        thickness = 7.5,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 2.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 2.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 25,
            },
            {
                materials = { { id = "canvas_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 7,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_canvas",
    name = ccb.content.text("canvas gambeson"),
    copy_from = "gambeson_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_canvas",
    name = ccb.content.text("canvas gambeson"),
    copy_from = "gambeson_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- roughly 0.25mm per sheet of canvas making this a 30-layer jack, sheets are 1x2 feet. 105 sheets for the vest and 18 sheets for the arms (123 total).
-- human torso is about 7 sq. feet.  76g (canvas) x 30 (layers) x 3.5 (surface area) = 7980g
-- human arms is about 3 sq. feet.  76g (canvas) x 12 (layers) x 1.5 (surface area) = 1368g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 1140g if 15 sheets.
-- 7980g + 1368g + 1140g = 10488g combined
-- 30
-- 20
ccb.content.define_item {
    id = "gambeson_canvas_thinsleeved",
    category = "armor",
    name = ccb.content.text("thin-sleeved canvas gambeson"),
    description = ccb.content.text("A thick cloth greatcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thirty layers of tough canvas, this will protect you from almost everything, but it's very heavy and warm.  The sleeves are a lot thinner for flexibility and it drapes below your legs, providing additional protection there."),
    mass = "10488 g",
    volume = "7000 ml",
    survival_price = "75 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "gambeson",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 60,
        thickness = 7.5,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 2.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 1.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 15,
                layers = { "NORMAL" },
            },
            {
                materials = { { id = "canvas_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 7,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_canvas_thinsleeved",
    name = ccb.content.text("thin-sleeved canvas gambeson"),
    copy_from = "gambeson_canvas_thinsleeved",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_canvas_thinsleeved",
    name = ccb.content.text("thin-sleeved canvas gambeson"),
    copy_from = "gambeson_canvas_thinsleeved",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- roughly 0.25mm per sheet of canvas making this a 30-layer jack, sheets are 1x2 feet. 105 sheets for the vest.
-- human torso is about 7 sq. feet.  76g (canvas) x 30 (layers) x 3.5 (surface area) = 7980g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 1140g if 15 sheets.
-- 7980g + 1140g = 9120g combined
-- 20
ccb.content.define_item {
    id = "gambeson_canvas_vest",
    category = "armor",
    name = ccb.content.text("sleeveless canvas gambeson"),
    description = ccb.content.text("A thick cloth surcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thirty layers of tough canvas, this will protect you from almost everything, but it's very heavy and warm.  It drapes below your legs, providing additional protection there, and it lacks sleeves entirely."),
    mass = "9120 g",
    volume = "6000 ml",
    survival_price = "50 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "sleeveless_tunic",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 60,
        thickness = 7.5,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 2.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = { { id = "canvas_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 7,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_canvas_vest",
    name = ccb.content.text("sleeveless canvas gambeson"),
    copy_from = "gambeson_canvas_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_canvas_vest",
    name = ccb.content.text("sleeveless canvas gambeson"),
    copy_from = "gambeson_canvas_vest",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of canvas making these 24 layer pants, sheets are 1x2 feet. 72 sheets total
-- human legs is about 6 sq. feet.  76g (canvas) x 24 (layers) x 3 (surface area) = 5472g
ccb.content.define_item {
    id = "gambeson_pants_canvas",
    category = "armor",
    name = ccb.content.plural_text("canvas heavy arming pants", "canvas heavy arming pants"),
    description = ccb.content.text("Tough, extremely thick cloth pants worn on their own alongside a gambeson.  These are made of a huge number of canvas layers offering very solid protection, though they're too thick to easily add metal armor on top and are both stuffy and restrictive."),
    mass = "5472 g",
    volume = "3750 ml",
    survival_price = "50 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "fencing_pants",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 55,
        thickness = 6.0,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 2.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_pants_canvas",
    name = ccb.content.plural_text("canvas heavy arming pants", "canvas heavy arming pants"),
    copy_from = "gambeson_pants_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_pants_canvas",
    name = ccb.content.plural_text("canvas heavy arming pants", "canvas heavy arming pants"),
    copy_from = "gambeson_pants_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of canvas making this 8 layers, sheets are 1x2 feet. 4 sheets total
-- human hands assumed to be about 1 sq ft total, 76g (canvas) x 8 (layers) x 0.5 (surface area) = 304g
-- on top of that, additional 2x as thick layer on about 60% of the hand, so adding another 5 sheets for 9 total (684 g)
-- technically, only covering 60% ish - inner hand is thinner - but fist will be clenched so inner hand should not really be hit
ccb.content.define_item {
    id = "gambeson_gloves_canvas",
    category = "armor",
    name = ccb.content.plural_text("canvas arming mittens (pair)", "canvas arming mittens (pair)"),
    description = ccb.content.text("Very thick canvas gauntlets worn in lieu of metal or leather armor.  Though they make it hard to do anything other than swing a weapon, and they're very warm, they offer excellent protection."),
    mass = "720 g",
    volume = "500 ml",
    survival_price = "20 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "mittens",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 50,
        thickness = 6.0,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 2.0 },
                    { id = "canvas_quilted_2", coverage = 90, thickness = 4.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 100,
                encumbrance = 30,
            },
            {
                materials = {
                    { id = "canvas_quilted", coverage = 100, thickness = 2.0 },
                    { id = "canvas_quilted_2", coverage = 95, thickness = 4.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
                coverage = 100,
            },
            {
                materials = { { id = "canvas_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                coverage = 100,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_gloves_canvas",
    name = ccb.content.plural_text("canvas arming mittens (pair)", "canvas arming mittens (pair)"),
    copy_from = "gambeson_gloves_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_gloves_canvas",
    name = ccb.content.plural_text("canvas arming mittens (pair)", "canvas arming mittens (pair)"),
    copy_from = "gambeson_gloves_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq for the whole surface area of the body
-- roughly 0.25mm per sheet of nylon making this a 14-layer jack, sheets are 1x2 feet. 49 sheets for the vest and 18 sheets for the arms (67 total).
-- human torso is about 7 sq. feet.  54g (nylon) x 14 (layers) x 3.5 (surface area) = 2646g
-- human arms is about 3 sq. feet.  54g (nylon) x 12 (layers) x 1.5 (surface area) = 972g
-- 3618g combined
ccb.content.define_item {
    id = "aketon_nylon",
    category = "armor",
    name = ccb.content.text("nylon aketon"),
    description = ccb.content.text("A thick cloth jack, intended to be worn below metal armor.  This one is made of over a dozen layers of tough nylon, and it provides fairly decent protection on its own."),
    mass = "3618 g",
    volume = "3500 ml",
    survival_price = "40 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "fencing_jacket",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "WATERPROOF" },
    armor = {
        warmth = 30,
        thickness = 3.5,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 7,
            },
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_nylon",
    name = ccb.content.text("nylon aketon"),
    copy_from = "aketon_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_nylon",
    name = ccb.content.text("nylon aketon"),
    copy_from = "aketon_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of nylon making this a 14-layer jack, sheets are 1x2 feet. 49 sheets total.
-- human torso is about 7 sq. feet.  54g (nylon) x 14 (layers) x 3.5 (surface area) = 2646g
ccb.content.define_item {
    id = "aketon_nylon_vest",
    category = "armor",
    name = ccb.content.text("nylon aketon vest"),
    description = ccb.content.text("A thick cloth vest, intended to be worn below metal armor.  This one is made of over a dozen layers of tough nylon, and it provides fairly decent protection on its own in addition to being quite light."),
    mass = "2646 g",
    volume = "2500 ml",
    survival_price = "25 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "vest",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "WATERPROOF" },
    armor = {
        warmth = 30,
        thickness = 3.5,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 7,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_nylon_vest",
    name = ccb.content.text("nylon aketon vest"),
    copy_from = "aketon_nylon_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_nylon_vest",
    name = ccb.content.text("nylon aketon vest"),
    copy_from = "aketon_canvas_vest",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of canvas making these 12 layer pants, sheets are 1x2 feet. 36 sheets total
-- human legs is about 6 sq. feet.  54g (nylon) x 12 (layers) x 3 (surface area) = 1944g
ccb.content.define_item {
    id = "aketon_pants_nylon",
    category = "armor",
    name = ccb.content.plural_text("nylon arming pants", "nylon arming pants"),
    description = ccb.content.text("Tough cloth pants worn alongside an aketon underneath metal armor.  These are made of many layers of nylon offering solid protection and the modern material is much lighter than organic fabrics."),
    mass = "1944 g",
    volume = "1750 ml",
    survival_price = "25 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "fencing_pants",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "WATERPROOF" },
    armor = {
        warmth = 30,
        thickness = 3.0,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_pants_nylon",
    name = ccb.content.plural_text("nylon arming pants", "nylon arming pants"),
    copy_from = "aketon_pants_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_pants_nylon",
    name = ccb.content.plural_text("nylon arming pants", "nylon arming pants"),
    copy_from = "aketon_pants_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of nylon making this 8 layers, sheets are 1x2 feet. 10 sheets total
-- human head total is about 2.5 sq. feet.  54g (nylon) x 8 (layers) x 1.25 (surface area) = 540g
ccb.content.define_item {
    id = "aketon_hood_nylon",
    category = "armor",
    name = ccb.content.text("nylon coif"),
    description = ccb.content.text("A cloth coif with neck and forehead protection.  Resting on your shoulders, it serves as padding for a helmet.  It is constructed of tough nylon and provides decent protection even on its own in addition to being fairly light."),
    mass = "540 g",
    volume = "500 ml",
    survival_price = "10 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "wetsuit_hood",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "SKINTIGHT" },
    armor = {
        warmth = 25,
        thickness = 2.0,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 1.0 },
                },
                covers = { "head" },
                subparts = {
                    "head_throat",
                    "head_ear_l",
                    "head_ear_r",
                    "head_forehead",
                    "head_crown",
                    "head_nape",
                },
                coverage = 100,
                encumbrance_modifiers = { "WELL_SUPPORTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_hood_nylon",
    name = ccb.content.text("nylon coif"),
    copy_from = "aketon_hood_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_hood_nylon",
    name = ccb.content.text("nylon coif"),
    copy_from = "aketon_hood_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of nylon making this 8 layers, sheets are 1x2 feet. 4 sheets total
-- human hands assumed to be about 1 sq ft total, 54g (nylon) x 8 (layers) x 0.5 (surface area) = 216g
ccb.content.define_item {
    id = "aketon_gloves_nylon",
    category = "armor",
    name = ccb.content.plural_text("nylon arming gloves (pair)", "nylon arming gloves (pair)"),
    description = ccb.content.text("Tough gloves made of nylon cloth, thin enough to wear under metal gauntlets.  They help to keep your hands safe during a fight."),
    mass = "216 g",
    volume = "250 ml",
    survival_price = "10 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "gloves_work",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 25,
        thickness = 2.0,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 1.0 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 15,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_gloves_nylon",
    name = ccb.content.plural_text("nylon arming gloves (pair)", "nylon arming gloves (pair)"),
    copy_from = "aketon_gloves_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_gloves_nylon",
    name = ccb.content.plural_text("nylon arming gloves (pair)", "nylon arming gloves (pair)"),
    copy_from = "aketon_gloves_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- roughly 0.25mm per sheet of nylon making this a 30-layer jack, sheets are 1x2 feet. 105 sheets for the vest and 36 sheets for the arms (141 total).
-- human torso is about 7 sq. feet.  54g (nylon) x 30 (layers) x 3.5 (surface area) = 5670g
-- human arms is about 3 sq. feet.  54g (nylon) x 24 (layers) x 1.5 (surface area) = 1944g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 810g if 15 sheets.
-- 5670g + 1944g + 810g = 8424g combined
-- 50
-- 20
ccb.content.define_item {
    id = "gambeson_nylon",
    category = "armor",
    name = ccb.content.text("nylon gambeson"),
    description = ccb.content.text("A thick cloth greatcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thirty layers of tough nylon, this will protect you from almost everything, but it's very heavy and warm.  The sleeves are a bit thinner for flexibility and it drapes below your legs, providing additional protection there."),
    mass = "8424 g",
    volume = "7500 ml",
    survival_price = "85 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "gambeson",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "BLOCK_WHILE_WORN", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 60,
        thickness = 7.5,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 15,
            },
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 21,
            },
            {
                materials = { { id = "nylon_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 5,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_nylon",
    name = ccb.content.text("nylon gambeson"),
    copy_from = "gambeson_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_nylon",
    name = ccb.content.text("nylon gambeson"),
    copy_from = "gambeson_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- roughly 0.25mm per sheet of nylon making this a 30-layer jack, sheets are 1x2 feet. 105 sheets for the vest and 18 sheets for the arms (123 total).
-- human torso is about 7 sq. feet.  54g (nylon) x 30 (layers) x 3.5 (surface area) = 5670g
-- human arms is about 3 sq. feet.  54g (nylon) x 12 (layers) x 1.5 (surface area) = 972g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 810g if 15 sheets.
-- 5670g + 972g + 810g = 7452g combined
-- 30
-- 20
ccb.content.define_item {
    id = "gambeson_nylon_thinsleeved",
    category = "armor",
    name = ccb.content.text("thin-sleeved nylon gambeson"),
    description = ccb.content.text("A thick cloth greatcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thirty layers of tough nylon, this will protect you from almost everything, but it's very heavy and warm.  The sleeves are a lot thinner for flexibility and it drapes below your legs, providing additional protection there."),
    mass = "7452 g",
    volume = "7000 ml",
    survival_price = "75 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "gambeson",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 60,
        thickness = 7.5,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 15,
            },
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 1.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 10,
                layers = { "NORMAL" },
            },
            {
                materials = { { id = "nylon_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 5,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_nylon_thinsleeved",
    name = ccb.content.text("thin-sleeved nylon gambeson"),
    copy_from = "gambeson_nylon_thinsleeved",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_nylon_thinsleeved",
    name = ccb.content.text("thin-sleeved nylon gambeson"),
    copy_from = "gambeson_nylon_thinsleeved",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- roughly 0.25mm per sheet of nylon making this a 30-layer jack, sheets are 1x2 feet. 105 sheets for the vest.
-- human torso is about 7 sq. feet.  54g (nylon) x 30 (layers) x 3.5 (surface area) = 5670g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 810g if 15 sheets.
-- 5670g + 810g = 6480g combined
-- 20
ccb.content.define_item {
    id = "gambeson_nylon_vest",
    category = "armor",
    name = ccb.content.text("sleeveless nylon gambeson"),
    description = ccb.content.text("A thick cloth surcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thirty layers of tough nylon, this will protect you from almost everything, but it's very heavy and warm.  It drapes below your legs, providing additional protection there, and it lacks sleeves entirely."),
    mass = "6480 g",
    volume = "6000 ml",
    survival_price = "50 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "sleeveless_tunic",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 60,
        thickness = 7.5,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 15,
            },
            {
                materials = { { id = "nylon_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 7,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_nylon_vest",
    name = ccb.content.text("sleeveless nylon gambeson"),
    copy_from = "gambeson_nylon_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_nylon_vest",
    name = ccb.content.text("sleeveless nylon gambeson"),
    copy_from = "gambeson_nylon_vest",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of nylon making these 24 layer pants, sheets are 1x2 feet. 72 sheets total
-- human legs is about 6 sq. feet.  54g (nylon) x 24 (layers) x 3 (surface area) = 3888g
ccb.content.define_item {
    id = "gambeson_pants_nylon",
    category = "armor",
    name = ccb.content.plural_text("nylon heavy arming pants", "nylon heavy arming pants"),
    description = ccb.content.text("Tough, extremely thick nylon pants worn on their own alongside a gambeson.  These are made of a huge number of canvas layers offering very solid protection, though they're too thick to easily add metal armor on top and are both stuffy and restrictive."),
    mass = "3888 g",
    volume = "3750 ml",
    survival_price = "50 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "fencing_pants",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 55,
        thickness = 6.0,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "nylon_quilted_2", coverage = 95, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 21,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_pants_nylon",
    name = ccb.content.plural_text("nylon heavy arming pants", "nylon heavy arming pants"),
    copy_from = "gambeson_pants_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_pants_nylon",
    name = ccb.content.plural_text("nylon heavy arming pants", "nylon heavy arming pants"),
    copy_from = "gambeson_pants_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- roughly 0.25mm per sheet of nylon making this 8 layers, sheets are 1x2 feet. 4 sheets total
-- human hands assumed to be about 1 sq ft total, 54g (nylon) x 8 (layers) x 0.5 (surface area) = 216g
-- on top of that, additional 2x as thick layer on about 60% of the hand, so adding another 5 sheets for 9 total (486 g)
-- technically, only covering 60% ish - inner hand is thinner - but fist will be clenched so inner hand should not really be hit
ccb.content.define_item {
    id = "gambeson_gloves_nylon",
    category = "armor",
    name = ccb.content.plural_text("nylon arming mittens (pair)", "nylon arming mittens (pair)"),
    description = ccb.content.text("Very thick nylon gauntlets worn in lieu of metal or leather armor.  Though they make it hard to do anything other than swing a weapon, and they're very warm, they offer excellent protection."),
    mass = "486 g",
    volume = "500 ml",
    survival_price = "20 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "mittens",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 50,
        thickness = 6.0,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "nylon_quilted_2", coverage = 90, thickness = 4.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 100,
                encumbrance = 28,
            },
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "nylon_quilted_2", coverage = 90, thickness = 4.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
                coverage = 100,
            },
            {
                materials = { { id = "nylon_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                coverage = 100,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_gloves_nylon",
    name = ccb.content.plural_text("nylon arming mittens (pair)", "nylon arming mittens (pair)"),
    copy_from = "gambeson_gloves_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_gloves_nylon",
    name = ccb.content.plural_text("nylon arming mittens (pair)", "nylon arming mittens (pair)"),
    copy_from = "gambeson_gloves_nylon",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq for the whole surface area of the body
-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human torso is about 7 sq. feet.  65g (wool) x 14 (layers) x 3.5 (surface area) = 3185g
-- human arms is about 3 sq. feet.  65g (wool) x 12 (layers) x 1.5 (surface area) = 1170g
-- 4355g combined
ccb.content.define_item {
    id = "aketon_wool",
    category = "armor",
    name = ccb.content.text("wool aketon"),
    description = ccb.content.text("A thick cloth jack, intended to be worn below metal armor.  This one is made of layered wool quilting and it provides fairly decent protection on its own."),
    mass = "4355 g",
    volume = "3500 ml",
    survival_price = "40 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "fencing_jacket",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 33,
        thickness = 3.5,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 9,
            },
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 13,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_wool",
    name = ccb.content.text("wool aketon"),
    copy_from = "aketon_wool",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_wool",
    name = ccb.content.text("wool aketon"),
    copy_from = "aketon_wool",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human torso is about 7 sq. feet.  65g (wool) x 14 (layers) x 3.5 (surface area) = 3185g
ccb.content.define_item {
    id = "aketon_wool_vest",
    category = "armor",
    name = ccb.content.text("wool aketon vest"),
    description = ccb.content.text("A thick cloth vest, intended to be worn below metal armor.  This one is made of layered wool quilting and it provides fairly decent protection on its own."),
    mass = "3185 g",
    volume = "2500 ml",
    survival_price = "25 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "vest",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 33,
        thickness = 3.5,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 9,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_wool_vest",
    name = ccb.content.text("wool aketon vest"),
    copy_from = "aketon_wool_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_wool_vest",
    name = ccb.content.text("wool aketon vest"),
    copy_from = "aketon_wool_vest",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human legs is about 6 sq. feet.  65g (wool) x 12 (layers) x 3 (surface area) = 2340g
ccb.content.define_item {
    id = "aketon_pants_wool",
    category = "armor",
    name = ccb.content.plural_text("wool arming pants", "wool arming pants"),
    description = ccb.content.text("Tough cloth pants worn alongside an aketon underneath metal armor.  This one is made of layered wool quilting and it provides fairly decent protection on its own."),
    mass = "2340 g",
    volume = "1750 ml",
    survival_price = "25 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "fencing_pants",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 33,
        thickness = 3.0,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 13,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_pants_wool",
    name = ccb.content.plural_text("wool arming pants", "wool arming pants"),
    copy_from = "aketon_pants_wool",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_pants_wool",
    name = ccb.content.plural_text("wool arming pants", "wool arming pants"),
    copy_from = "aketon_pants_canvas",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human head total is about 2.5 sq. feet.  65g (canvas) x 8 (layers) x 1.25 (surface area) = 650g
ccb.content.define_item {
    id = "aketon_hood_wool",
    category = "armor",
    name = ccb.content.text("wool coif"),
    description = ccb.content.text("A cloth coif with neck and forehead protection.  Resting on your shoulders, it serves as padding for a helmet.  Though it's pretty warm, it is constructed of layered wool quilting and provides substantial protection even on its own."),
    mass = "650 g",
    volume = "500 ml",
    survival_price = "10 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "cowl_wool",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "SKINTIGHT" },
    armor = {
        warmth = 28,
        thickness = 2.0,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 1.0 },
                },
                covers = { "head" },
                subparts = {
                    "head_throat",
                    "head_ear_l",
                    "head_ear_r",
                    "head_forehead",
                    "head_crown",
                    "head_nape",
                },
                coverage = 100,
                encumbrance_modifiers = { "WELL_SUPPORTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_hood_wool",
    name = ccb.content.text("wool coif"),
    copy_from = "aketon_hood_wool",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_hood_wool",
    name = ccb.content.text("wool coif"),
    copy_from = "aketon_hood_wool",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human hands assumed to be about 1 sq ft total, 65g (wool) x 8 (layers) x 0.5 (surface area) = 260g
ccb.content.define_item {
    id = "aketon_gloves_wool",
    category = "armor",
    name = ccb.content.plural_text("wool arming gloves (pair)", "wool arming gloves (pair)"),
    description = ccb.content.text("Tough cloth gloves made of layered wool quilting, thin enough to wear under metal gauntlets.  They help to keep your hands safe during a fight."),
    mass = "260 g",
    volume = "250 ml",
    survival_price = "10 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "gloves_wool",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 28,
        thickness = 2.0,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 1.0 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 18,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_aketon_gloves_wool",
    name = ccb.content.plural_text("wool arming gloves (pair)", "wool arming gloves (pair)"),
    copy_from = "aketon_gloves_wool",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_aketon_gloves_wool",
    name = ccb.content.plural_text("wool arming gloves (pair)", "wool arming gloves (pair)"),
    copy_from = "aketon_gloves_wool",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human torso is about 7 sq. feet.  65g (wool) x 30 (layers) x 3.5 (surface area) = 6825g
-- human arms is about 3 sq. feet.  65g (wool) x 24 (layers) x 1.5 (surface area) = 2340g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 975g if 15 sheets.
-- 6825g + 2340g + 975g = 10140g combined
-- 55
-- 22
ccb.content.define_item {
    id = "gambeson_wool",
    category = "armor",
    name = ccb.content.text("wool gambeson"),
    description = ccb.content.text("A thick cloth greatcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thickly layered wool quilting, this will protect you from almost everything, but it's very heavy and warm.  The sleeves are a bit thinner for flexibility and it drapes below your legs, providing additional protection there."),
    mass = "10140 g",
    volume = "7500 ml",
    survival_price = "85 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "gambeson",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "BLOCK_WHILE_WORN", "NORMAL", "OUTER" },
    armor = {
        warmth = 66,
        thickness = 7.5,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 2.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 18,
            },
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 2.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 23,
            },
            {
                materials = { { id = "wool_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 6,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_wool",
    name = ccb.content.text("wool gambeson"),
    copy_from = "gambeson_wool",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_wool",
    name = ccb.content.text("wool gambeson"),
    copy_from = "gambeson_wool",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human torso is about 7 sq. feet.  65g (wool) x 30 (layers) x 3.5 (surface area) = 6825g
-- human arms is about 3 sq. feet.  65g (wool) x 12 (layers) x 1.5 (surface area) = 1170g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 925g if 15 sheets.
-- 6825g + 1170g + 975g = 8970g combined
-- 33
-- 22
ccb.content.define_item {
    id = "gambeson_wool_thinsleeved",
    category = "armor",
    name = ccb.content.text("thin-sleeved wool gambeson"),
    description = ccb.content.text("A thick cloth greatcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thickly layered wool quilting, this will protect you from almost everything, but it's very heavy and warm.  The sleeves are a lot thinner for flexibility and it drapes below your legs, providing additional protection there."),
    mass = "10488 g",
    volume = "7500 ml",
    survival_price = "75 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "gambeson_wool",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 66,
        thickness = 7.5,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 2.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 18,
            },
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 2.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 23,
                layers = { "NORMAL" },
            },
            {
                materials = { { id = "wool_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 6,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_wool_thinsleeved",
    name = ccb.content.text("thin-sleeved wool gambeson"),
    copy_from = "gambeson_wool_thinsleeved",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_wool_thinsleeved",
    name = ccb.content.text("thin-sleeved wool gambeson"),
    copy_from = "gambeson_wool_thinsleeved",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Going off the Rule of Nines for body proportions and assuming about 20 ft sq in total
-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human torso is about 7 sq. feet.  65g (wool) x 30 (layers) x 3.5 (surface area) = 6825g
-- 8 layers thick waist. human waist is about 3ft circumference with the extra padding, and reaches to about below knees. doesn't usually cover the whole circumference so guessing about 1.5x2.5x8 total surface area divided by 1x2 ft for about 15-18 extra sheets, about 975g if 15 sheets.
-- 6825g + 975g = 7800g combined
-- 20
ccb.content.define_item {
    id = "gambeson_wool_vest",
    category = "armor",
    name = ccb.content.text("sleeveless wool gambeson"),
    description = ccb.content.text("A thick cloth surcoat intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thickly layered wool quilting, this will protect you from almost everything, but it's very heavy and warm.  It drapes below your legs, providing additional protection there, and it lacks sleeves entirely."),
    mass = "7800 g",
    volume = "6000 ml",
    survival_price = "50 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "sleeveless_tunic",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 66,
        thickness = 7.5,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 2.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 5.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 18,
            },
            {
                materials = { { id = "wool_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 6,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_wool_vest",
    name = ccb.content.text("sleeveless wool gambeson"),
    copy_from = "gambeson_wool_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_wool_vest",
    name = ccb.content.text("sleeveless wool gambeson"),
    copy_from = "gambeson_wool_vest",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human legs is about 6 sq. feet.  65g (wool) x 24 (layers) x 3 (surface area) = 4680g
ccb.content.define_item {
    id = "gambeson_pants_wool",
    category = "armor",
    name = ccb.content.plural_text("wool heavy arming pants", "wool heavy arming pants"),
    description = ccb.content.text("Tough, extremely thick cloth pants worn on their own alongside a gambeson.  These are made of thickly layered wool quilting offering very solid protection, though they're too thick to easily add metal armor on top and are both stuffy and restrictive."),
    mass = "4680 g",
    volume = "3750 ml",
    survival_price = "50 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "fencing_pants",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 61,
        thickness = 6.0,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 2.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 23,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_pants_wool",
    name = ccb.content.plural_text("wool heavy arming pants", "wool heavy arming pants"),
    copy_from = "gambeson_pants_wool",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_pants_wool",
    name = ccb.content.plural_text("wool heavy arming pants", "wool heavy arming pants"),
    copy_from = "gambeson_pants_wool",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- This is made out of quilts rather than sheets because felt is very low density and would need to be very thick - general wool has 1.4g/cm^3 however.
-- I am treating this as though it were made of canvas or nylon sheets with a density of 1.4 instead of 1.6 or 1.14.
-- human hands assumed to be about 1 sq ft total, 65g (wool) x 8 (layers) x 0.5 (surface area) = 260g
-- on top of that, additional 2x as thick layer on about 60% of the hand, so adding another 5 sheets for 9 total (585 g)
-- technically, only covering 60% ish - inner hand is thinner - but fist will be clenched so inner hand should not really be hit
ccb.content.define_item {
    id = "gambeson_gloves_wool",
    category = "armor",
    name = ccb.content.plural_text("wool arming mittens (pair)", "wool arming mittens (pair)"),
    description = ccb.content.text("Very thick wool gauntlets worn in lieu of metal or leather armor.  Though they make it hard to do anything other than swing a weapon, and they're very warm, they offer excellent protection."),
    mass = "585 g",
    volume = "500 ml",
    survival_price = "20 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "mittens",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 55,
        thickness = 6.0,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 2.0 },
                    { id = "wool_quilted_2", coverage = 90, thickness = 4.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 100,
                encumbrance = 29,
            },
            {
                materials = {
                    { id = "wool_quilted", coverage = 100, thickness = 2.0 },
                    { id = "wool_quilted_2", coverage = 95, thickness = 4.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
                coverage = 100,
            },
            {
                materials = { { id = "wool_quilted", coverage = 100, thickness = 2.0 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                coverage = 100,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_gloves_wool",
    name = ccb.content.plural_text("wool arming mittens (pair)", "wool arming mittens (pair)"),
    copy_from = "gambeson_gloves_wool",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_gloves_wool",
    name = ccb.content.plural_text("wool arming mittens (pair)", "wool arming mittens (pair)"),
    copy_from = "gambeson_gloves_wool",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- 30
-- 35
-- 35
ccb.content.define_item {
    id = "gambeson_HEMA",
    category = "armor",
    name = ccb.content.text("HEMA gambeson"),
    description = ccb.content.text("A thick cloth jacket intended to be worn as standalone armor, as it's a little too thick to comfortably add chainmail or a cuirass on top.  Made of thick nylon with padded foam inserts, this armor is designed to protect you during HEMA competitions."),
    mass = "1587 g",
    volume = "7250 ml",
    survival_price = "85 USD",
    materials = { "nylon", "plastic_pad" },
    symbol = "[",
    looks_like = "gambeson",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "BLOCK_WHILE_WORN", "NORMAL", "OUTER", "WATERPROOF" },
    armor = {
        warmth = 40,
        thickness = 10.0,
        environmental_protection = 5,
        portions = {
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "plastic_pad", coverage = 80, thickness = 8.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 18,
            },
            {
                materials = { { id = "nylon_quilted", coverage = 100, thickness = 1.75 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 12,
                subparts = { "arm_elbow_l", "arm_elbow_r", "arm_lower_l", "arm_lower_r" },
            },
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "plastic_pad", coverage = 90, thickness = 8.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                materials = {
                    { id = "nylon_quilted", coverage = 100, thickness = 2.0 },
                    { id = "plastic_pad", coverage = 40, thickness = 8.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
}
