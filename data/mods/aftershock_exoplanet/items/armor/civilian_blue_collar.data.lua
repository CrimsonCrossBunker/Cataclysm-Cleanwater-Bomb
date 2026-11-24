local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_hi_vis_jacket",
    repair_like = "jacket_windbreaker",
    copy_from = "jacket_windbreaker",
    looks_like = "jacket_windbreaker",
    name = ccb.content.text("hi-vis jacket"),
    description = ccb.content.text("Glowing orange and very visible indeed."),
    color = "red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "xl_jeans",
    mass = "900 g",
    volume = "3 L",
    copy_from = "jeans",
    pockets = { { kind = "CONTAINER", rigid = true, capacity = "750 ml", mass_limit = "1 kg" } },
    flags = { "VARSIZE", "POCKETS", "OVERSIZE", "PREFIX_XL" },
    armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "afs_hi_vis_vest",
    copy_from = "vest",
    looks_like = "vest",
    name = ccb.content.text("hi-vis vest"),
    variants = {},
    description = ccb.content.text("A bright orange winter vest with several front facing pockets.  Not even close to warm enough."),
    materials = { "cotton", "plastic" },
    color = "red",
    armor = { warmth = 70, thickness = 2 },
}

ccb.content.define_item {
    id = "afs_company_jacket",
    copy_from = "jacket_windbreaker",
    looks_like = "jacket_windbreaker",
    name = ccb.content.text("company jacket"),
    variants = {},
    description = ccb.content.text("A synthetic jacket adorned with the logos and colors of some interstellar corporation.  Impermeable, but not very warm."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "afs_supervisor_jacket",
    copy_from = "jacket_windbreaker",
    looks_like = "jacket_windbreaker",
    name = ccb.content.text("supervisor jacket"),
    variants = {},
    description = ccb.content.text("A variant company jacket tailored to slightly recall a business suit, often issued to low level managers.  Some might think it looks nicer, but it's just as cheaply made."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "afs_work_tie",
    copy_from = "tie_skinny",
    looks_like = "tie_skinny",
    name = ccb.content.text("worker's tie"),
    variants = {},
    description = ccb.content.text("Calling this thin strip of dark fabric a tie would do it a favor."),
    armor = {},
}

ccb.content.define_item {
    id = "spacer_jumpsuit",
    copy_from = "jumpsuit",
    looks_like = "jumpsuit",
    name = ccb.content.text("crew jumpsuit"),
    description = ccb.content.text("A lightweight cloth jumpsuit adorned with the faded corporate regalia of some freight hauling association or another.  This one is a standard design favored by spacers, with ample, easy access pockets."),
    variants = {},
    color = "brown",
    armor = {},
}

ccb.content.define_item {
    id = "afs_hazard_suit",
    copy_from = "robofac_enviro_suit",
    name = ccb.content.plural_text("soft hazard suit", "soft hazard suits"),
    materials = { "plastic", "cotton" },
    description = ccb.content.text("A brightly colored, standard-fab pattern environmental suit for use in industrial and medical settings.  Offers good protection from chemical and radioactive hazards, but is not insulated against heat or cold.  Requires a gas mask or sealed helmet for full protection."),
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = {
                    "foot_l", "foot_r", "head", "torso", "eyes", "mouth", "leg_l", "leg_r", "arm_l",
                    "arm_r", "hand_l", "hand_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear casually"),
            message = ccb.content.text("You slip out of the top of the suit and tie the sleeves around your waist."),
            target = "afs_hazard_suit_casual",
        },
    },
}

ccb.content.define_item {
    id = "afs_hazard_suit_casual",
    copy_from = "robofac_enviro_suit_casual",
    name = ccb.content.plural_text("soft hazard suit (casual)", "soft hazard suits (casual)"),
    description = ccb.content.text("A brightly colored, standard-fab pattern environmental suit for use in industrial and medical settings.  The upper portion has been tied around the waist casually."),
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r", "head", "leg_l", "leg_r" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear normally"),
            message = ccb.content.text("You untie the sleeves and put back on the top of the suit."),
            target = "afs_hazard_suit",
        },
    },
}

ccb.content.define_item {
    id = "spacer_cap",
    copy_from = "hat_cotton",
    materials = { "plastic", "cotton" },
    looks_like = "powered_earmuffs",
    variants = {},
    flags = { "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "PARTIAL_DEAF" },
    name = ccb.content.text("communications cap"),
    description = ccb.content.text("A padded cotton cap built around an augmented reality headset.  During normal operation it would provide visual information about a ship subsystems and a communications link with the rest of the crew, but severed from a spaceship, only their hearing protection function retains any utility."),
    color = "brown",
    armor = {
        portions = {
            { covers = { "eyes" }, rigid_only = true, coverage = 33, encumbrance = 0 },
            { covers = { "head" }, coverage = 100, encumbrance = 2 },
        },
    },
}

ccb.content.define_item {
    id = "afs_herc_rig",
    name = ccb.content.plural_text("HERC rig", "HERC rigs"),
    description = ccb.content.text("A lightweight steel-reinforced tool carrier.  Keeps your tools safe and about in zero-g, Mars, the bottom of the Pacific, or other generally inhospitable environments.  It has several deep pockets, and two mounting points for pressurized canisters or other large magazines."),
    mass = "600 g",
    volume = "10 L",
    looks_like = "tacvest",
    price = "1200 USD",
    survival_price = "1200 USD",
    materials = { "steel", "plastic" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            capacity = "5 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 40,
            allowed_flags = { "BELT_CLIP" },
            holster = true,
            transparent = true,
        },
        {
            capacity = "5 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 40,
            allowed_flags = { "BELT_CLIP" },
            holster = true,
            transparent = true,
        },
        {
            capacity = "5 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 40,
            allowed_flags = { "BELT_CLIP" },
            holster = true,
            transparent = true,
        },
        {
            capacity = "5 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 40,
            allowed_flags = { "BELT_CLIP" },
            rigid = true,
            holster = true,
            transparent = true,
        },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 60 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 60 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 60 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "5 kg", moves = 150 },
        {
            kind = "CONTAINER",
            min_item_volume = "2 L",
            capacity = "10 L",
            mass_limit = "30 kg",
            allowed_flags = { "MAG_BULKY", "HEAVY_TOOL" },
            moves = 60,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "2 L",
            capacity = "10 L",
            mass_limit = "30 kg",
            allowed_flags = { "MAG_BULKY", "HEAVY_TOOL" },
            moves = 60,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = { 2, 15 }, coverage = 20, covers = { "torso" } } },
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
    id = "xl_technician_pants_gray",
    copy_from = "technician_pants_gray",
    mass = "770 g",
    volume = "3 L",
    snippet_category = {
        { id = "xl_technician_pants_blue", text = "A pair of XL blue work pants." },
        { id = "xl_technician_pants_gray", text = "A pair of XL gray work pants." },
        { id = "xl_technician_pants_lightblue", text = "A pair of XL light-blue work pants." },
    },
    flags = { "VARSIZE", "POCKETS", "OVERSIZE", "PREFIX_XL" },
    pockets = {
        { kind = "CONTAINER", capacity = "1700 ml", mass_limit = "2 kg", rigid = true },
    },
    armor = { thickness = 2 },
}

ccb.content.define_item {
    id = "xl_technician_shirt_gray",
    copy_from = "technician_shirt_gray",
    mass = "84 g",
    volume = "350 ml",
    snippet_category = {
        {
            id = "xl_technician_shirt_blue",
            text = "An XL blue work t-shirt with a small front pocket.",
        },
        {
            id = "xl_technician_shirt_gray",
            text = "An XL gray work t-shirt with a small front pocket.",
        },
        {
            id = "xl_technician_shirt_lightblue",
            text = "An XL light-blue work t-shirt with a small front pocket.",
        },
    },
    flags = { "VARSIZE", "OVERSIZE", "PREFIX_XL" },
    armor = {},
}
