local ccb = require("ccb")

ccb.content.define_item {
    id = "hk_briefcase",
    copy_from = "briefcase",
    looks_like = "briefcase",
    mass = "1500 g",
    volume = "15232 ml",
    length = "544 mm",
    name = ccb.content.plural_text("H&K operational briefcase (empty)", "H&K operational briefcases (empty)"),
    description = ccb.content.text("This is a plain, hard-sided black briefcase with a trigger in the handle and a concealed hole in the side.  Squeezing the trigger would currently do nothing, as it is empty.  Don't forget to put a suitable MP5 back inside before you try to pay any ransom fees with lead."),
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            capacity = "14 L",
            mass_limit = "30 kg",
            max_item_length = "50 cm",
            moves = 300,
        },
    },
    price = "20 USD",
    survival_price = "12 USD 50 cent",
    armor = {},
}

ccb.content.define_item {
    id = "jerrypack",
    name = ccb.content.text("jerrypack"),
    description = ccb.content.text("A jerrycan modified to be worn in a similar manner to a backpack."),
    mass = "1763 g",
    volume = "10500 ml",
    price = "14 USD 50 cent",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "cotton" },
    symbol = "[",
    looks_like = "backpack",
    color = "green",
    pockets = {
        {
            capacity = "10 L",
            mass_limit = "10 kg",
            max_item_volume = "65 ml",
            watertight = true,
            rigid = true,
        },
    },
    flags = { "OVERSIZE", "BELTED", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 2,
        portions = {
            {
                encumbrance = 30,
                coverage = 80,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "leather_pouch",
    name = ccb.content.plural_text("leather pouch", "leather pouches"),
    description = ccb.content.text("A bag stitched together from leather scraps.  Doesn't hold an awful lot but is easy to wear."),
    mass = "250 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "1 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 0.1,
        portions = {
            {
                encumbrance = 1,
                coverage = 100,
                volume_encumbrance = 0.35,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
}

ccb.content.define_item {
    id = "legrig",
    name = ccb.content.plural_text("drop leg pouch", "drop leg pouches"),
    description = ccb.content.text("A pouch that can be worn on the thighs using buckled straps.  This variety is favored by the military."),
    mass = "102 g",
    volume = "525 ml",
    price = "15 USD",
    survival_price = "1 USD 25 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2250 ml",
            mass_limit = "4500 g",
            max_item_length = "30 cm",
            magazine_well = "500 ml",
            moves = 80,
        },
    },
    flags = { "OVERSIZE", "WATER_FRIENDLY", "BELTED" },
    armor = {
        sided = true,
        thickness = 0.2,
        portions = {
            {
                encumbrance = 1,
                volume_encumbrance = 0.15,
                coverage = 50,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

-- Based on skeletonized version of these https://fourthelement.com/product/technical-shorts/ with added lower buckles like here https://www.divegarage.com/neoprene-tech-shorts.html
-- Two large pockets separated into four, two small zipper pockets on flaps, four bungee loops.
ccb.content.define_item {
    id = "legrig_wetsuit",
    name = ccb.content.plural_text("diving pouches (pair)", "diving pouches (pair)"),
    description = ccb.content.text("A set of pouches that can be worn on the thighs using buckled neoprene rig.  This variety is favored by the divers."),
    mass = "305 g",
    volume = "1150 ml",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "neoprene", "nylon", "nylon_2" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1650 ml",
            mass_limit = "1500 g",
            max_item_length = "32 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1650 ml",
            mass_limit = "1500 g",
            max_item_length = "32 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1650 ml",
            mass_limit = "1500 g",
            max_item_length = "32 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1650 ml",
            mass_limit = "1500 g",
            max_item_length = "32 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "19 cm",
            moves = 130,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "19 cm",
            moves = 130,
        },
        {
            holster = true,
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1000 g",
            max_item_length = "70 cm",
            extra_encumbrance = 2,
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
        },
        {
            holster = true,
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1000 g",
            max_item_length = "70 cm",
            extra_encumbrance = 2,
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
        },
        {
            holster = true,
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1000 g",
            max_item_length = "70 cm",
            extra_encumbrance = 2,
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
        },
        {
            holster = true,
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1000 g",
            max_item_length = "70 cm",
            extra_encumbrance = 2,
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
        },
    },
    flags = { "OVERSIZE", "WATER_FRIENDLY", "BELTED" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 2.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 2,
                volume_encumbrance = 0.2,
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 2.0 },
                    { id = "nylon_2", coverage = 50, thickness = 1.5 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 40,
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

-- Based around https://www.amazon.com/HCoolfly-Waterproof-Motorcycle-Multi-Function-Fishing/dp/B07TVNBPZK/.
-- inherit name from item
-- inherit name from item
-- inherit name from item
ccb.content.define_item {
    id = "leg_bag",
    name = ccb.content.text("drop leg bag"),
    description = ccb.content.text("A bag that can be worn on the thighs and hips using adjustable buckled straps.  Provides some extra storage for outdoor activities."),
    mass = "258 g",
    volume = "1550 ml",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "legrig",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "25 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "WATER_FRIENDLY", "BELTED" },
    variant_kind = "generic",
    variants = {
        {
            id = "black_leg_bag",
            description = ccb.content.text("A black bag that can be worn on the thighs and hips using adjustable buckled straps.  Commonly used by motorcycle riders."),
            weight = 50,
        },
        {
            id = "brown_leg_bag",
            description = ccb.content.text("A khaki bag that can be worn on the thighs and hips using adjustable buckled straps.  Works nicely with a pair of khaki pants."),
            color = "brown",
            weight = 30,
        },
        {
            id = "purple_leg_bag",
            description = ccb.content.text("A purple bag that can be worn on the thighs and hips using adjustable buckled straps.  Perfect for the ladies that want a cooler way of carrying their personal items."),
            color = "magenta",
            weight = 10,
        },
        {
            id = "camo_leg_bag",
            name = ccb.content.text("camo drop leg bag"),
            description = ccb.content.text("A green bag with camouflage print that can be worn on the thighs and hips using adjustable buckled straps.  For those that have a military heart."),
            color = "green",
            weight = 5,
        },
        {
            id = "steampunk_leg_bag",
            name = ccb.content.text("steampunk drop leg bag"),
            description = ccb.content.text("A black and dark gold bag that can be worn on the thighs and hips using adjustable buckled straps, with a steampunk design and chains all over it.  Perfect for a wide variety of costumes."),
            weight = 3,
        },
        {
            id = "skull_leg_bag",
            name = ccb.content.text("skull drop leg bag"),
            description = ccb.content.text("A jet-black bag that can be worn on the thighs and hips using adjustable buckled straps, with skulls and spikes all over it.  Perfect for a rider of the apocalypse."),
            symbol = "S",
            weight = 2,
        },
        {
            id = "flag_leg_bag",
            name = ccb.content.text("founders' leg bag"),
            description = ccb.content.text("A garishly colored red, white, and blue bag that can be worn on the thighs and hips using adjustable buckled straps, with the stylized depiction of George Washington's face gazing sternly from the side.  Perfect for carrying the dreams of the founding fathers wherever you go."),
        },
    },
    armor = {
        sided = true,
        thickness = 1,
        warmth = 2,
        portions = {
            {
                encumbrance = 3,
                volume_encumbrance = 0.22,
                coverage = 70,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}
