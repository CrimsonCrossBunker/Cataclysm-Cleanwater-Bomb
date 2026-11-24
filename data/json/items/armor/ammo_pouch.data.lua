local ccb = require("ccb")

ccb.content.define_item {
    id = "ammo_pouch",
    name = ccb.content.plural_text("ammo pouch", "ammo pouches"),
    description = ccb.content.text("A small pouch that can be used to store most types of small ammunition; rockets, however, will not fit.  Use insert to store ammunition."),
    mass = "490 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "6 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "leather_pouch",
    color = "brown",
    pockets = {
        {
            ammunition = {
                pebble = 60,
                ["458wm"] = 60,
                ["50"] = 60,
                ["4570"] = 60,
                BB = 60,
                ["410shot"] = 60,
                ["22"] = 60,
                shot = 60,
                ["9mm"] = 60,
                ["357sig"] = 60,
                ["9x18"] = 60,
                ["380"] = 60,
                ["38"] = 60,
                ["40"] = 60,
                ["10mm"] = 60,
                ["44"] = 60,
                ["45"] = 60,
                ["454"] = 60,
                ["45colt"] = 60,
                ["500"] = 60,
                ["57"] = 60,
                ["762"] = 60,
                ["545x39"] = 60,
                ["223"] = 60,
                ["3006"] = 60,
                ["123ln"] = 60,
                ["50beowulf"] = 60,
                ["450"] = 60,
                ["338lapua"] = 60,
                ["303"] = 60,
                ["77mm_arisaka"] = 60,
                ["270win"] = 60,
                ["308"] = 60,
                ["12mm"] = 60,
                ["8x40mm"] = 60,
                stimpack_ammo = 60,
                ampoule = 60,
                ["300"] = 60,
                ["32"] = 60,
                ["762x25"] = 60,
                flintlock = 60,
                ["36paper"] = 60,
                ["44paper"] = 60,
                ["762R"] = 60,
                paintball = 60,
            },
            moves = 35,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

ccb.content.define_item {
    id = "ammo_satchel",
    name = ccb.content.plural_text("ammo satchel", "ammo satchels"),
    description = ccb.content.text("A fabric ammo bag worn at the waist.  It is capable of holding a single large magazine close at hand."),
    mass = "180 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "6 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "300 mm",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT", "MAG_BULKY" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "PALS_LARGE" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "chestpouch",
    name = ccb.content.plural_text("chest ammo pouch", "chest ammo pouches"),
    description = ccb.content.text("A fabric ammo pouch that can be strapped to your chest and hold a single magazine close at hand."),
    mass = "140 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "PALS_SMALL" },
    armor = {
        thickness = 2,
        portions = { { coverage = 25, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

-- inherit name from item
ccb.content.define_item {
    id = "chestrig",
    name = ccb.content.plural_text("chest rig", "chest rigs"),
    description = ccb.content.text("Popularized during the Vietnam War, chest rigs like these are typically plain, barebones affairs consisting of three or more pouches in a row, with straps to secure them on your chest.  This one can hold four magazines in its pouches."),
    variant_kind = "generic",
    variants = {
        {
            id = "generic_chestrig",
            description = ccb.content.text("Popularized during the Vietnam War, chest rigs like these are typically plain, barebones affairs consisting of three or more pouches in a row, with straps to secure them on your chest.  This one can hold four magazines in its pouches."),
            weight = 30,
        },
        {
            id = "flag_chestrig",
            name = ccb.content.plural_text("patriot's chest rig", "patriot's chest rigs"),
            description = ccb.content.text("An American flag is proudly embroidered across the front of each pouch, with a tiny, eagle-winged .50-caliber bullet crowning each banner."),
            append = true,
        },
    },
    mass = "425 g",
    volume = "500 ml",
    price = "39 USD",
    survival_price = "30 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "tool_belt",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 1, coverage = 25, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

-- delete chest rig variants
ccb.content.define_item {
    id = "xl_chestrig",
    copy_from = "chestrig",
    name = ccb.content.text("chest rig"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

-- delete chest rig variants
ccb.content.define_item {
    id = "xs_chestrig",
    copy_from = "chestrig",
    name = ccb.content.text("chest rig"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "javelin_bag",
    name = ccb.content.plural_text("javelin bag", "javelin bags"),
    description = ccb.content.text("An open medieval-looking bag, designed to store javelins within easy reach."),
    mass = "900 g",
    volume = "1250 ml",
    price = "60 USD",
    survival_price = "10 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "quiver",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            min_item_volume = "250 ml",
            capacity = "1250 ml",
            mass_limit = "2 kg",
            moves = 60,
            allowed_flags = { "JAVELIN" },
            max_item_length = "150 cm",
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "250 ml",
            capacity = "1250 ml",
            mass_limit = "2 kg",
            moves = 60,
            allowed_flags = { "JAVELIN" },
            max_item_length = "150 cm",
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "250 ml",
            capacity = "1250 ml",
            mass_limit = "2 kg",
            moves = 60,
            allowed_flags = { "JAVELIN" },
            max_item_length = "150 cm",
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "250 ml",
            capacity = "1250 ml",
            mass_limit = "2 kg",
            moves = 60,
            allowed_flags = { "JAVELIN" },
            max_item_length = "150 cm",
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "250 ml",
            capacity = "1250 ml",
            mass_limit = "2 kg",
            moves = 60,
            allowed_flags = { "JAVELIN" },
            max_item_length = "150 cm",
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "OVERSIZE", "BELTED" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash javelins"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "legpouch",
    name = ccb.content.plural_text("ankle ammo pouch", "ankle ammo pouches"),
    description = ccb.content.text("A small fabric ammo pouch that can be strapped to your ankle and hold a single small magazine close at hand."),
    volume = "250 ml",
    mass = "60 g",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "250 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS", "PALS_SMALL" },
    armor = {
        sided = true,
        thickness = 2,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2 } },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
                coverage = 25,
                encumbrance = 1,
                layers = { "BELTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "legpouch_large",
    name = ccb.content.plural_text("leg ammo pouch", "leg ammo pouches"),
    description = ccb.content.text("A fabric ammo pouch that can be strapped to your leg and hold two magazines close at hand."),
    mass = "120 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "4 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "ammo_satchel",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "500 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "500 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "PALS_MEDIUM" },
    armor = {
        sided = true,
        thickness = 2,
        portions = {
            {
                encumbrance = 1,
                coverage = 38,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "quiver",
    name = ccb.content.text("quiver"),
    description = ccb.content.text("A leather quiver worn at the waist that can hold 20 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "320 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "10 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "bscabbard",
    color = "brown",
    pockets = { { ammunition = { arrow = 20, bolt = 20 }, moves = 20 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 2 },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 3,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "nylon_quiver",
    name = ccb.content.text("nylon quiver"),
    description = ccb.content.text("A lighter and more durable quiver made of nylon, with straps to attach to a MOLLE system."),
    mass = "230 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "12 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "bscabbard",
    color = "light_gray",
    pockets = { { ammunition = { arrow = 20, bolt = 20 }, moves = 20 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    melee_damage = { bash = 2 },
    armor = {
        sided = true,
        thickness = 0.5,
        portions = {
            {
                encumbrance = 2,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "quiver_birchbark",
    name = ccb.content.text("birchbark quiver"),
    description = ccb.content.text("A quiver woven from strips of birch bark, worn at the waist, that can hold 20 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "490 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "quiver",
    color = "light_gray",
    pockets = { { ammunition = { arrow = 20, bolt = 20 }, moves = 20 } },
    flags = { "BELTED", "VARSIZE", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 2 },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 10,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "pipe_quiver",
    name = ccb.content.text("pipe quiver"),
    description = ccb.content.text("A makeshift quiver fashioned from a pipe, worn at the waist.  Heavier and thinner than a typical quiver, it can only hold 10 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "800 g",
    volume = "370 ml",
    price = "65 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "quiver",
    color = "dark_gray",
    pockets = { { ammunition = { arrow = 10, bolt = 10 }, moves = 20 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 10 },
    armor = {
        sided = true,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 10,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "quiver_large",
    name = ccb.content.text("large quiver"),
    description = ccb.content.text("A large leather quiver, worn on the back, that can hold 60 arrows or bolts.  Historically used by horse archers, rather than foot archers, but neither of THEM had to fight zombies.  Use insert to store arrows or bolts."),
    mass = "920 g",
    volume = "1500 ml",
    price = "88 USD",
    survival_price = "15 USD",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "quiver",
    color = "brown",
    pockets = { { ammunition = { arrow = 60, bolt = 60 }, moves = 20 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 4 },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 3,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "quiver_large_birchbark",
    name = ccb.content.text("large birchbark quiver"),
    description = ccb.content.text("A large quiver woven from strips of birchbark, worn on the back, that can hold 60 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "1380 g",
    volume = "1500 ml",
    price = "88 USD",
    survival_price = "12 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "quiver_birchbark",
    color = "light_gray",
    pockets = { { ammunition = { arrow = 60, bolt = 60 }, moves = 20 } },
    flags = { "BELTED", "VARSIZE", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 4 },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 14,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "pipe_quiver_large",
    name = ccb.content.text("large pipe quiver"),
    description = ccb.content.text("A large makeshift quiver fashioned from 3 pipes, worn on the back.  Heavier and thinner than a typical large quiver, it can only hold 30 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "2000 g",
    volume = "810 ml",
    price = "88 USD",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "quiver",
    color = "dark_gray",
    pockets = { { ammunition = { arrow = 30, bolt = 30 }, moves = 30 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 12 },
    armor = {
        sided = true,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 14,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "quiver_simple_cloth",
    name = ccb.content.text("simple cloth quiver"),
    description = ccb.content.text("A simple quiver made out of cloth that can be adjusted to hold various types of arrows, bolts, and spears of different lengths.  Takes slightly longer to pull ammunition from than a regular quiver.  Use insert to store arrows, bolts, fishing spears, or atlatl spears."),
    mass = "200 g",
    volume = "500 ml",
    price = "5 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "quiver",
    color = "white",
    pockets = { { ammunition = { arrow = 30, bolt = 30, atlatl = 5, fishspear = 5 }, moves = 30 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 6,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- Based on: https://www.amazon.com/XTACER-Multi-Function-4-Tubes-Training-Takedown/dp/B072K4537K
ccb.content.define_item {
    id = "quiver_takedown_bow",
    name = ccb.content.plural_text("multi-function quiver", "multi-function quivers"),
    description = ccb.content.text("A large cotton quiver capable of easily storing 16 arrows.  It includes a bag and straps to store a takedown bow, as well as a small pouch for archery accessories.  Use insert to store arrows or bolts and activate to holster/draw your bow."),
    mass = "720 g",
    volume = "1500 ml",
    price = "88 USD",
    survival_price = "15 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "quiver",
    color = "dark_gray",
    pockets = {
        { ammunition = { arrow = 16, bolt = 16 }, moves = 20 },
        {
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "500 ml",
            capacity = "4 L",
            mass_limit = "5 kg",
            max_item_length = "75 cm",
            moves = 80,
            allowed_items = { "takedown_recurbow_folded" },
        },
        {
            kind = "CONTAINER",
            capacity = "2500 ml",
            mass_limit = "2 kg",
            max_item_length = "35 cm",
            moves = 250,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 4 },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 3,
                volume_encumbrance = 0.2,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = { { kind = "holster" } },
}

ccb.content.define_item {
    id = "tacvest",
    name = ccb.content.plural_text("tac vest", "tac vests"),
    description = ccb.content.text("This light vest is meant to carry your magazines, shells and pistols.  They are popular among law enforcement, but less so than combination tactical vests incorporating Kevlar."),
    mass = "1750 g",
    volume = "1250 ml",
    looks_like = "vest",
    price = "74 USD",
    survival_price = "20 USD",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 50,
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "300 mm",
            capacity = "1 L",
            mass_limit = "2 kg",
            moves = 100,
            volume_encumbrance = 0.25,
        },
        {
            kind = "CONTAINER",
            max_item_length = "300 mm",
            capacity = "1 L",
            mass_limit = "2 kg",
            moves = 100,
            volume_encumbrance = 0.25,
        },
        {
            kind = "CONTAINER",
            max_item_length = "250 mm",
            capacity = "800 ml",
            mass_limit = "1600 g",
            moves = 100,
            volume_encumbrance = 0.25,
        },
        {
            kind = "CONTAINER",
            max_item_length = "250 mm",
            capacity = "800 ml",
            mass_limit = "1600 g",
            moves = 100,
            volume_encumbrance = 0.25,
        },
        {
            kind = "CONTAINER",
            max_item_length = "250 mm",
            capacity = "800 ml",
            mass_limit = "1600 g",
            moves = 100,
            volume_encumbrance = 0.25,
        },
        {
            ammunition = { ["410shot"] = 6, shot = 6, signal_flare = 6 },
            moves = 25,
            volume_encumbrance = 0.2,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 2, coverage = 85, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash item"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "xl_tacvest",
    copy_from = "tacvest",
    name = ccb.content.text("tac vest"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_tacvest",
    copy_from = "tacvest",
    name = ccb.content.text("tac vest"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "light_load_bearing_vest",
    name = ccb.content.plural_text("light load bearing vest", "light load bearing vests"),
    description = ccb.content.text("This lightweight harness covered in MOLLE webbing is designed to attach a few pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated."),
    mass = "500 g",
    volume = "500 ml",
    looks_like = "vest",
    price = "47 USD",
    survival_price = "20 USD",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "BELTED", "STURDY" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                encumbrance = 1,
                coverage = 55,
                covers = { "torso" },
                subparts = { "torso_upper" },
                volume_encumbrance = 0.3,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 4 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "load_bearing_vest",
    name = ccb.content.plural_text("load bearing vest", "load bearing vests"),
    description = ccb.content.text("This vest covered in MOLLE webbing is designed to attach pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated."),
    mass = "1250 g",
    volume = "1000 ml",
    looks_like = "vest",
    price = "74 USD",
    survival_price = "30 USD",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "BELTED", "STURDY" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                encumbrance = 2,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 8 }, { kind = "detach_molle" } },
}

-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
ccb.content.define_item {
    id = "load_bearing_vest_sling",
    copy_from = "load_bearing_vest",
    name = ccb.content.plural_text("load bearing vest with sling", "load bearing vests with slings"),
    description = ccb.content.text("This vest covered in MOLLE webbing is designed to attach pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated.  This one has a single point sling wrapped around the shoulders using a system to keep your weapon extra secure."),
    mass = "1500 g",
    pockets = {
        {
            description = ccb.content.text("Rifle sling."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1000 ml",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 1.6,
            moves = 30,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 2,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_hanging_front" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "holster" }, { kind = "attach_molle", size = 8 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "heavy_load_bearing_vest",
    name = ccb.content.plural_text("heavy load bearing vest", "heavy load bearing vests"),
    description = ccb.content.text("This massive vest covered in MOLLE webbing is designed to attach a large number of pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated."),
    mass = "2000 g",
    volume = "1750 ml",
    looks_like = "vest",
    price = "130 USD",
    survival_price = "40 USD",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "BELTED", "STURDY" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_waist" },
                volume_encumbrance = 0.2,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 14 }, { kind = "detach_molle" } },
}

-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
ccb.content.define_item {
    id = "heavy_load_bearing_vest_sling",
    copy_from = "heavy_load_bearing_vest",
    name = ccb.content.plural_text("heavy load bearing vest with sling", "heavy load bearing vests with slings"),
    description = ccb.content.text("This massive vest covered in MOLLE webbing is designed to attach a large number of pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated.  This one has a single point sling wrapped around the shoulders using a system to keep your weapon extra secure."),
    mass = "2300 g",
    pockets = {
        {
            description = ccb.content.text("Rifle sling."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1000 ml",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 2,
            moves = 30,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_hanging_front", "torso_waist" },
                volume_encumbrance = 0.2,
            },
        },
    },
    use_actions = { { kind = "holster" }, { kind = "attach_molle", size = 14 }, { kind = "detach_molle" } },
}

-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
ccb.content.define_item {
    id = "heavy_load_bearing_vest_breacher",
    copy_from = "heavy_load_bearing_vest",
    name = ccb.content.plural_text("breacher load bearing vest", "breacher load bearing vests"),
    description = ccb.content.text("This massive vest covered in MOLLE webbing is designed to attach a large number of pouches, holsters and other PALS compatible accessories.  This one has a single point sling wrapped around the shoulders using a system to keep your weapon extra secure, as well as a set of strong magnets attached to the torso and waist to hold an extra medium-sized firearm - normally a short-barrel shotgun for breaching."),
    mass = "2900 g",
    pockets = {
        {
            description = ccb.content.text("Rifle sling."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1000 ml",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 2,
            moves = 30,
        },
        {
            description = ccb.content.text("Breaching shotgun magnets."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1 L",
            capacity = "4 L",
            mass_limit = "8200 g",
            min_item_length = "45 cm",
            max_item_length = "80 cm",
            volume_encumbrance = 2,
            moves = 60,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_hanging_front", "torso_waist" },
                volume_encumbrance = 0.2,
            },
        },
    },
    use_actions = { { kind = "holster" }, { kind = "attach_molle", size = 8 }, { kind = "detach_molle" } },
}

--  stats taken from: https://www.patriotoutfitters.com/5-11-tactical-molle-radio-pouch?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "radio_pouch",
    name = ccb.content.plural_text("tactical radio pouch", "tactical radio pouches"),
    description = ccb.content.text("A pouch designed to keep your radio accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "200 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "13 cm",
            moves = 40,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "OVERSIZE", "PALS_SMALL" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-gadget-pouch-tan498-?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "gadget_pouch",
    name = ccb.content.plural_text("gadget pouch", "gadget pouches"),
    description = ccb.content.text("A pouch designed to keep gadgets and small items accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "250 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-h2o-pouch?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "h2o_pouch",
    name = ccb.content.plural_text("H2O pouch", "H2O pouches"),
    description = ccb.content.text("A pouch designed to hold a water bottle with an additional front tactical pocket.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "250 g",
    volume = "400 ml",
    price = "20 USD",
    survival_price = "4 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2048 ml",
            mass_limit = "5 kg",
            max_item_length = "254 mm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            capacity = "426 ml",
            mass_limit = "3 kg",
            max_item_length = "165 mm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

ccb.content.define_item {
    id = "canteen_pouch",
    name = ccb.content.plural_text("canteen pouch", "canteen pouches"),
    description = ccb.content.text("A pouch designed to keep your canteen accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "190 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "4 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "1751 ml",
            mass_limit = "3800 g",
            max_item_length = "23 cm",
            moves = 40,
            volume_encumbrance = 0.2,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-t-and-t-pouch?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "tool_pouch",
    name = ccb.content.plural_text("tactical tool pouch", "tactical tool pouches"),
    description = ccb.content.text("A low profile pouch designed to keep your tools accessible and secure.  Has MOLLE straps for attaching to a vest or can be strapped directly to your chest."),
    mass = "250 g",
    volume = "250 ml",
    price = "30 USD",
    survival_price = "6 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2753 ml",
            mass_limit = "8 kg",
            max_item_length = "305 mm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 10, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-flashlight-pouch?PMSRCH=MOLLE%20GEAR liberties were taken with this one so it would hold either flashlight
ccb.content.define_item {
    id = "flashlight_pouch",
    name = ccb.content.plural_text("flashlight pouch", "flashlight pouches"),
    description = ccb.content.text("A tiny pouch designed to keep your flashlight accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "37 cm",
            moves = 40,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-vertical-molle-holster?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "tactical_holster",
    name = ccb.content.plural_text("tactical holster", "tactical holsters"),
    description = ccb.content.text("A sturdy holster designed to be worn vertically, to keep a small profile on a tactical vest.  This makes it a little more awkward to draw from than a normal holster."),
    mass = "220 g",
    volume = "500 ml",
    price = "90 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "sheath",
    color = "light_gray",
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "300 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 70,
        },
    },
    flags = { "BELTED", "OVERSIZE", "PALS_SMALL" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 4 },
                coverage = 5,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    use_actions = { { kind = "holster" } },
}

--  stats taken from: https://condoroutdoor.com/ma11.html
-- Dimensions: 10.5x6.75x4 inches.
ccb.content.define_item {
    id = "gas_mask_pouch",
    looks_like = "holster",
    name = ccb.content.plural_text("gas mask pouch", "gas mask pouches"),
    description = ccb.content.text("A large pouch capable of holding a gas mask and an additional filter, keeping both accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "300 g",
    volume = "250 ml",
    price = "19 USD 95 cent",
    survival_price = "1 USD 90 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "3546 ml",
            mass_limit = "3 kg",
            max_item_length = "27 cm",
            description = ccb.content.text("The main compartment for a respirator."),
            moves = 80,
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "950 ml",
            mass_limit = "500 g",
            max_item_length = "12 cm",
            description = ccb.content.text("A side pocket for a single spare filter."),
            moves = 80,
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            capacity = "150 ml",
            mass_limit = "250 g",
            max_item_length = "17 cm",
            description = ccb.content.text("An internal divider pocket for some small accessories."),
            moves = 80,
            volume_encumbrance = 0,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        sided = true,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 1.0 } },
                encumbrance = { 3, 4 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
        thickness = 0.5,
    },
}

ccb.content.define_item {
    id = "modular_papr_strap",
    looks_like = "holster",
    name = ccb.content.text("modular PAPR strap"),
    description = ccb.content.text("A patch of velcro and MOLLE straps for attaching a modular PAPR blower to a compatible MOLLE unit.  It can also be strapped to the hip."),
    mass = "300 g",
    volume = "300 ml",
    price = "19 USD 95 cent",
    survival_price = "1 USD 90 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            allowed_items = { "molle_papr_blower_off", "molle_papr_blower_on" },
            capacity = "4000 ml",
            mass_limit = "2 kg",
            max_item_length = "16 cm",
            description = ccb.content.text("A MOLLE harness for a modular PAPR blower."),
            moves = 300,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = {
        sided = true,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 1.0 } },
                encumbrance = { 3, 4 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
        thickness = 0.5,
    },
}

--  stats taken from: https://www.tacticalassaultgearstore.com/molle-frag-grenade-pouch.html
ccb.content.define_item {
    id = "tactical_grenade_pouch",
    name = ccb.content.plural_text("tactical grenade pouch", "tactical grenade pouches"),
    description = ccb.content.text("A pouch designed to hold one military grenade, keeping it both accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "200 g",
    volume = "100 ml",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 30,
            allowed_flags = { "GRENADE" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-triple-stacker-open-top-m4-mag-pouch?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "triple_stacker_pouch",
    name = ccb.content.plural_text("triple stacker ammo pouch", "triple stacker ammo pouches"),
    description = ccb.content.text("A collection of 6 pockets, 3 wide and 2 deep, designed to hold rifle magazines and keep them accessible and secure.  Has MOLLE straps for attaching to a vest or can be strapped directly to your chest."),
    mass = "500 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "6 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "200 mm",
            capacity = "300 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "200 mm",
            capacity = "300 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "200 mm",
            capacity = "300 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 2, coverage = 10, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

--  stats taken from: https://condoroutdoor.com/ma12-shotgun-ammo-pouch.html
ccb.content.define_item {
    id = "tactical_shotshell_pouch",
    name = ccb.content.plural_text("tactical shotshell pouch", "tactical shotshell pouches"),
    description = ccb.content.text("A pouch designed to hold shotgun shells or .308 rounds, keeping them accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "300 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "4 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            ammunition = { ["410shot"] = 12, shot = 12, signal_flare = 12, ["308"] = 20 },
            moves = 30,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

-- encumbrance handled above
ccb.content.define_item {
    id = "xlkevlar",
    category = "armor",
    name = ccb.content.text("Kevlar vest"),
    description = ccb.content.text("A massive handmade imitation of a proper ballistic vest for abnormally large folks.  Large and heavy, but will still fit under an abnormally large coat."),
    mass = "4210 g",
    volume = "8 L",
    survival_price = "25 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "neutral" },
    materials = { "kevlar_layered", "nylon" },
    symbol = "[",
    looks_like = "kevlar",
    color = "light_gray",
    flags = { "STURDY", "OVERSIZE", "PREFIX_XL" },
    melee_damage = { bash = 4 },
    armor = {
        warmth = 20,
        thickness = 5,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 6,
                coverage = 98,
                vitals_coverage = 70,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 0,
                coverage = 92,
                vitals_coverage = 60,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ammo_satchel_leather",
    name = ccb.content.plural_text("leather ammo satchel", "leather ammo satchels"),
    description = ccb.content.text("A sturdy leather ammo bag worn at the waist.  It is capable of holding a single large magazine close at hand."),
    mass = "590 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "6 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "300 mm",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT", "MAG_BULKY" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "OVERSIZE", "BELTED", "PALS_LARGE" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 1, coverage = 20, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "chestpouch_leather",
    name = ccb.content.plural_text("leather chest ammo pouch", "leather chest ammo pouches"),
    description = ccb.content.text("A leather ammo pouch that can be strapped to your chest and hold a single magazine close at hand."),
    mass = "1140 g",
    volume = "250 ml",
    price = "12 USD 50 cent",
    survival_price = "2 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "OVERSIZE", "BELTED", "PALS_SMALL" },
    armor = {
        thickness = 2,
        portions = { { coverage = 25, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "belt_loop_small",
    name = ccb.content.text("small belt loop"),
    description = ccb.content.text("A MOLLE-compatible loop for attaching small tools to a load-bearing vest."),
    mass = "25 g",
    volume = "25 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "leather_pouch",
    color = "brown",
    pockets = {
        {
            holster = true,
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "30 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            volume_encumbrance = 0.3,
            transparent = true,
        },
    },
    flags = { "CANT_WEAR", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = { thickness = 1, portions = { { encumbrance = 0, coverage = 0, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "belt_loop_medium",
    name = ccb.content.text("medium belt loop"),
    description = ccb.content.text("A MOLLE-compatible loop for attaching tools and some weapons to a load-bearing vest."),
    mass = "50 g",
    volume = "50 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "leather_pouch",
    color = "brown",
    pockets = {
        {
            holster = true,
            capacity = "1500 ml",
            mass_limit = "1500 g",
            max_item_length = "60 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            volume_encumbrance = 0.3,
            transparent = true,
        },
    },
    flags = { "CANT_WEAR", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = { thickness = 1, portions = { { encumbrance = 0, coverage = 0, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "belt_loop_large",
    name = ccb.content.text("large belt loop"),
    description = ccb.content.text("A MOLLE-compatible loop for attaching large tools and weapons to a load-bearing vest."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "leather_pouch",
    color = "brown",
    pockets = {
        {
            holster = true,
            capacity = "2000 ml",
            mass_limit = "6000 g",
            max_item_length = "100 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            volume_encumbrance = 0.3,
            transparent = true,
        },
    },
    flags = { "CANT_WEAR", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = { thickness = 1, portions = { { encumbrance = 0, coverage = 0, covers = { "torso" } } } },
}

--  stats taken from: https://www.varusteleka.com/en/product/us-molle-ii-sustainment-pouch-surplus/63566
ccb.content.define_item {
    id = "sustainment_pouch",
    name = ccb.content.plural_text("sustainment pouch", "sustainment pouches"),
    description = ccb.content.text("A large, drawstring & buckle pouch originally designed to hold 3 MREs, and part of the official MOLLE II rucksack system.  Has MOLLE straps for attaching to a belt, vest, or rucksack."),
    mass = "230 g",
    volume = "300 ml",
    price = "30 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "7000 ml",
            mass_limit = "10000 g",
            max_item_length = "30 cm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "OVERSIZE", "PALS_MEDIUM" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}
