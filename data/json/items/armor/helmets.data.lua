local ccb = require("ccb")

ccb.content.define_item {
    id = "pot_helmet",
    category = "armor",
    name = ccb.content.plural_text("pot helmet", "pot helmets"),
    description = ccb.content.text("A helmet made from a soup pot.  It's not very good protection, but it's better than nothing."),
    mass = "760 g",
    volume = "2 L",
    price = "45 USD",
    survival_price = "50 cent",
    materials = { "iron" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "light_gray",
    qualities = {
        { id = "COOK", level = 3 },
        { id = "BOIL", level = 2 },
        { id = "CONTAIN", level = 1 },
        { id = "CHEM", level = 1 },
    },
    techniques = { "WBLOCK_1" },
    flags = { "RAINPROOF", "PADDED" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 5,
        thickness = 2,
        portions = {
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
            },
            { coverage = 80, covers = { "head" }, subparts = { "head_forehead" } },
            { coverage = 20, covers = { "head" }, subparts = { "head_ear_l", "head_ear_r" } },
        },
    },
    use_actions = { "HEAT_ALL_ITEMS" },
}

ccb.content.define_item {
    id = "stockpot_helmet",
    category = "armor",
    name = ccb.content.plural_text("pot great helm", "pot great helms"),
    description = ccb.content.text("An enclosed helmet made from a stock pot with a 'T' crudely carved into the front and a blanket stuffed inside to cushion it.  There are strings tied to the handles to help fasten it to your body, but it's extremely limiting and smothering."),
    mass = "3580 g",
    volume = "13 L",
    price = "45 USD",
    survival_price = "50 cent",
    materials = { "mc_steel", "aluminum" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "light_gray",
    qualities = { { id = "COOK", level = 2 }, { id = "BOIL", level = 1 } },
    techniques = { "WBLOCK_1" },
    flags = { "RAINPROOF", "PADDED", "OUTER" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 70,
        thickness = 1,
        portions = {
            {
                materials = {
                    { id = "mc_steel", coverage = 100, thickness = 0.95 },
                    { id = "cotton", coverage = 98, thickness = 2.5 },
                    { id = "aluminum", coverage = 40, thickness = 4.0 },
                },
                covers = { "head" },
                coverage = 100,
                subparts = { "head_ear_l", "head_ear_r" },
                layers = { "NORMAL", "OUTER" },
                encumbrance_modifiers = { "RESTRICTS_NECK", "IMBALANCED" },
            },
            {
                materials = {
                    { id = "mc_steel", coverage = 100, thickness = 0.95 },
                    { id = "cotton", coverage = 98, thickness = 2.5 },
                },
                covers = { "head" },
                coverage = 100,
                subparts = { "head_crown", "head_forehead" },
                layers = { "NORMAL", "OUTER" },
            },
            {
                materials = { { id = "mc_steel", coverage = 100, thickness = 0.95 } },
                covers = { "head" },
                coverage = 80,
                subparts = { "head_throat", "head_nape" },
                layers = { "OUTER" },
            },
            {
                materials = { { id = "mc_steel", coverage = 100, thickness = 0.95 } },
                covers = { "eyes" },
                coverage = 90,
                encumbrance = 25,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "mc_steel", coverage = 100, thickness = 0.95 } },
                coverage = 95,
                covers = { "mouth" },
                subparts = { "mouth_cheeks" },
                layers = { "OUTER" },
            },
            {
                materials = { { id = "mc_steel", coverage = 100, thickness = 0.95 } },
                covers = { "mouth" },
                coverage = 40,
                subparts = { "mouth_lips", "mouth_nose", "mouth_chin" },
                encumbrance = 30,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
    },
    use_actions = { "HEAT_ALL_ITEMS" },
}

ccb.content.define_item {
    id = "headgear",
    name = ccb.content.text("headgear"),
    description = ccb.content.text("Lightweight sports headgear designed to protect the head while sparring."),
    mass = "500 g",
    volume = "1 L",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic_pad", "leather" },
    symbol = "[",
    looks_like = "balclava",
    color = "red",
    flags = { "VARSIZE", "OVERSIZE", "STURDY" },
    armor = {
        warmth = 10,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 40,
                covers = { "head" },
                subparts = { "head_crown" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
            },
            {
                coverage = 95,
                covers = { "head" },
                subparts = { "head_forehead", "head_ear_l", "head_ear_r" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
            },
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 95,
                covers = { "mouth" },
                subparts = { "mouth_cheeks", "mouth_chin" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_army",
    category = "armor",
    name = ccb.content.text("army helmet"),
    description = ccb.content.text("A heavy helmet that provides excellent protection from all sorts of damage.  It is labeled as the advanced combat helmet."),
    mass = "1383 g",
    volume = "1750 ml",
    length = "28 cm",
    price = "150 USD",
    survival_price = "15 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "kevlar_rigid", "plastic" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "green",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a face shield, or a front night vision attachment."),
            allowed_flags = { "HELMET_FACE_SHIELD", "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a strapped mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 20,
        thickness = 9,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 50,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_army_stripped",
    category = "armor",
    copy_from = "helmet_army",
    name = ccb.content.plural_text("army helmet (stripped)", "army helmets (stripped)"),
    description = ccb.content.text("A heavy helmet that provides excellent protection from all sorts of damage.  It is labeled as the advanced combat helmet.  This one has been stripped of all its mounting points, leaving only the nape and mandible attachment points, and the counterweight pouch."),
    mass = "1153 g",
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a strapped mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
    },
    armor = {},
}

-- assuming this is an antique and not a cheap replica
ccb.content.define_item {
    id = "helmet_army_outdated",
    repair_like = "helmet_barbute",
    category = "armor",
    name = ccb.content.text("flak helmet"),
    description = ccb.content.text("A simple helmet meant to protect the head from fragmentation and impacts.  Its simple steel construction renders it outdated by modern military standards."),
    mass = "1400 g",
    volume = "1900 ml",
    length = "28 cm",
    price = "200 USD",
    survival_price = "12 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "hc_steel", "plastic", "leather" },
    repair_materials = { "hc_steel" },
    symbol = "[",
    looks_like = "helmet_army",
    color = "dark_gray",
    flags = { "VARSIZE", "STURDY", "PADDED" },
    variants = {
        {
            id = "helmet_m1",
            name = ccb.content.text("M1 helmet"),
            description = ccb.content.text("A M1 combat helmet, famously worn by American soldiers in the Second World War as well as the Korean and Vietnam wars.  Inferior to modern helmets, but it still remains popular among guerrilla fighters, collectors and war re-enactors."),
            color = "green",
            weight = 10,
        },
        {
            id = "helmet_ssh",
            name = ccb.content.text("SSh-68 helmet"),
            description = ccb.content.text("An old SSh-68 combat helmet from the Soviet Union, likely brought to The States by a collector or migrant.  It is designed to protect against shrapnel and some small arms and will do little to stop a rifle round."),
            color = "light_red",
            weight = 5,
        },
    },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "hc_steel", coverage = 100, thickness = 1.12 },
                    { id = "plastic", coverage = 100, thickness = 3 },
                    { id = "leather", coverage = 10, thickness = 1.0 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_soviet_tanker",
    category = "armor",
    name = ccb.content.text("Soviet tanker helmet"),
    description = ccb.content.text("A Soviet era tanker helmet.  It's distinctive foam pads are meant to protect a tank driver from bumps against the cramped interior."),
    price = "100 USD",
    survival_price = "12 USD",
    mass = "950 g",
    volume = "1200 ml",
    symbol = "[",
    looks_like = "helmet_army",
    color = "green",
    flags = { "VARSIZE", "STURDY", "PADDED" },
    armor = {
        warmth = 30,
        portions = {
            {
                layers = { "NORMAL" },
                encumbrance = 10,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead", "head_ear_l", "head_ear_r" },
                coverage = 100,
                materials = {
                    { id = "canvas", thickness = 1 },
                    { id = "canvas", coverage = 40, thickness = 1 },
                    { id = "plastic_pad", coverage = 40, thickness = 15 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "tac_fullhelmet",
    category = "armor",
    name = ccb.content.text("tactical full helmet"),
    description = ccb.content.text("An all-encompassing black helmet that covers your entire face and neck, providing excellent protection from all sorts of damage."),
    mass = "1594 g",
    volume = "2250 ml",
    price = "250 USD",
    survival_price = "25 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "kevlar_rigid", "plastic" },
    symbol = "[",
    looks_like = "helmet_motor",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "SUN_GLASSES", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a front night vision attachment."),
            allowed_flags = { "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
    },
    melee_damage = { bash = 1 },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 20 },
            { covers = { "mouth" }, rigid_only = true, coverage = 100, encumbrance = 15 },
        },
        warmth = 25,
        thickness = 8,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "tac_helmet",
    category = "armor",
    name = ccb.content.text("tactical helmet"),
    description = ccb.content.text("A lightweight black helmet that provides excellent protection from all sorts of damage.  It has a military rail system for attachments."),
    mass = "1180 g",
    volume = "1850 ml",
    price = "200 USD",
    survival_price = "20 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "kevlar_rigid", "plastic" },
    symbol = "[",
    looks_like = "tac_fullhelmet",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a face shield, or a front night vision attachment."),
            allowed_flags = { "HELMET_FACE_SHIELD", "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a rail-mounted mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 20,
        thickness = 8,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 10,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "firehelmet",
    category = "armor",
    name = ccb.content.text("firefighter helmet"),
    description = ccb.content.text("A distinctive helmet worn by firefighters.  More than just a piece of firefighting equipment, it serves as a badge of honor and respect."),
    mass = "1500 g",
    volume = "1250 ml",
    length = "30 cm",
    price = "240 USD",
    survival_price = "5 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "plastic", "nomex" },
    symbol = "[",
    looks_like = "cowboy_hat",
    color = "yellow",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "PADDED" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 15,
        thickness = 6,
        environmental_protection = 6,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 5.0 },
                    { id = "nomex", coverage = 100, thickness = 1.0 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                materials = { { id = "nomex", coverage = 100, thickness = 1.0 } },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r", "head_nape" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_ball",
    category = "armor",
    name = ccb.content.text("baseball helmet"),
    description = ccb.content.text("A hard plastic helmet that covers the head and ears.  Designed to protect against a baseball to the head."),
    mass = "615 g",
    volume = "1750 ml",
    price = "31 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "plastic_pad" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "blue",
    techniques = { "WBLOCK_1" },
    flags = { "PADDED" },
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 12 },
                    { id = "plastic", coverage = 100, thickness = 3 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 12 },
                    { id = "plastic", coverage = 100, thickness = 3 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 95,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_aztec",
    category = "armor",
    name = ccb.content.text("eagle cuacalalatli"),
    description = ccb.content.text("A hardwood Mesoamerican helmet that resembles the head of an eagle.  It was worn by the renowned eagle warriors of the Aztec, both ceremonially and for protection.  Its inside is lined with cotton, and it is ornamented with many feathers, carvings and colors."),
    mass = "1500 g",
    volume = "2500 ml",
    symbol = "[",
    color = "brown",
    looks_like = "helmet_plate",
    price = "150 USD",
    survival_price = "12 USD 50 cent",
    materials = { "wood", "cotton" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 1 },
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY", "PADDED", "WATERPROOF", "NO_REPAIR" },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_l", "head_ear_r" },
                encumbrance = 50,
                coverage = 100,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "head" },
                subparts = { "head_nape" },
                coverage = 40,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "mouth" },
                subparts = { "mouth_chin" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "mouth" },
                subparts = { "mouth_cheeks" },
                coverage = 20,
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_barbute",
    category = "armor",
    name = ccb.content.text("barbute helm"),
    description = ccb.content.text("A medieval helmet that provides excellent protection for the head, with a Y shaped opening for the face."),
    mass = "1175 g",
    volume = "2500 ml",
    price = "300 USD",
    survival_price = "40 USD",
    materials = { "steel", "leather" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 1 },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_l", "head_ear_r" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "head" },
                subparts = { "head_nape" },
                coverage = 20,
                encumbrance_modifiers = { "NONE" },
            },
            { covers = { "eyes" }, coverage = 65, encumbrance = 0 },
            {
                covers = { "mouth" },
                subparts = { "mouth_cheeks" },
                coverage = 100,
                encumbrance = 0,
                rigid_only = true,
            },
            {
                covers = { "mouth", "head" },
                subparts = { "mouth_lips", "mouth_nose", "mouth_chin" },
                coverage = 50,
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 10,
        thickness = 4,
    },
}

ccb.content.define_item {
    id = "xl_helmet_barbute",
    copy_from = "helmet_barbute",
    name = ccb.content.text("barbute helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_barbute_xs",
    copy_from = "helmet_barbute",
    name = ccb.content.text("barbute helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_bike",
    category = "armor",
    name = ccb.content.text("bike helmet"),
    description = ccb.content.text("A thick foam helmet.  Designed to protect against concussion."),
    mass = "400 g",
    volume = "1500 ml",
    length = "26 cm",
    price = "170 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "plastic_pad" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "PADDED" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "200 ml",
            mass_limit = "50 g",
            moves = 250,
            description = ccb.content.text("Pocket for a shield visor."),
            allowed_flags = { "HELMET_FACE_SHIELD" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a strapped mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
    },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 15,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "plastic", coverage = 100, thickness = 1.5 },
                },
            },
            {
                coverage = 80,
                covers = { "head" },
                subparts = { "head_forehead" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "plastic", coverage = 100, thickness = 1.5 },
                },
            },
        },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the head is 9% leaving us with 1 674 cm^2.
-- Chitin has a density of 1.45g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 777 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 129 grams.
-- Totalled up this is 906 grams with some rounding
ccb.content.define_item {
    id = "helmet_chitin",
    category = "armor",
    name = ccb.content.text("chitinous scale mail hood"),
    description = ccb.content.text("Chitin sections overlapping with each other secured to a leather backing in the shape of a hood.  The odd irregular shapes make full coverage impossible, not helped by how poor of a material chitin is.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "906 g",
    volume = "2 L",
    price = "380 USD",
    survival_price = "50 cent",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "helmet_larmor",
    color = "green",
    flags = { "OUTER" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "head" },
                subparts = {
                    "head_crown",
                    "head_forehead",
                    "head_ear_l",
                    "head_ear_r",
                    "head_nape",
                    "head_throat",
                },
                coverage = 95,
                encumbrance_modifiers = { "NONE" },
            },
        },
        warmth = 20,
    },
}

ccb.content.define_item {
    id = "xl_helmet_chitin",
    copy_from = "helmet_chitin",
    looks_like = "helmet_chitin",
    name = ccb.content.text("chitinous scale mail hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_chitin_xs",
    copy_from = "helmet_chitin",
    looks_like = "helmet_chitin",
    name = ccb.content.text("chitinous scale mail hood"),
    flags = { "WATERPROOF", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_conical",
    category = "armor",
    name = ccb.content.text("conical helm"),
    description = ccb.content.text("A conical iron helm with additional protection for the neck, associated with the Mongol Empire."),
    mass = "1425 g",
    volume = "3500 ml",
    price = "400 USD",
    survival_price = "35 USD",
    materials = { "iron", "fur" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 35,
        thickness = 3,
        portions = {
            {
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_l", "head_ear_r" },
            },
            { coverage = 90, covers = { "head" }, subparts = { "head_nape" } },
        },
    },
}

ccb.content.define_item {
    id = "xl_helmet_conical",
    copy_from = "helmet_conical",
    name = ccb.content.text("conical helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_conical_xs",
    copy_from = "helmet_conical",
    looks_like = "helmet_conical",
    name = ccb.content.text("conical helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_acidchitin",
    copy_from = "helmet_chitin",
    looks_like = "helmet_chitin",
    name = ccb.content.text("biosilicified chitin helmet"),
    description = ccb.content.text("A helmet crafted from the carefully cleaned and pruned biosilicified exoskeletons of acidic ants.  Covers the whole head.  Acid-resistant but brittle."),
    survival_price = "17 USD 50 cent",
    materials = { "acidchitin" },
    armor = {},
    inheritance = { offset = { melee_damage = { bash = 1 } } },
}

ccb.content.define_item {
    id = "xl_helmet_acidchitin",
    copy_from = "helmet_acidchitin",
    looks_like = "helmet_acidchitin",
    name = ccb.content.text("biosilicified chitin helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_acidchitin_xs",
    copy_from = "helmet_acidchitin",
    looks_like = "helmet_acidchitin",
    name = ccb.content.text("biosilicified chitin helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "helmet_football",
    category = "armor",
    name = ccb.content.text("football helmet"),
    description = ccb.content.text("A heavy polycarbonate helmet normally worn by football players.  It comes with a visor to protect the eyes."),
    mass = "1360 g",
    volume = "2250 ml",
    price = "198 USD",
    survival_price = "2 USD 50 cent",
    materials = { "thermo_resin", "plastic_pad" },
    symbol = "[",
    looks_like = "helmet_motor",
    color = "yellow",
    flags = { "WATER_FRIENDLY", "PADDED" },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                subparts = { "head_crown", "head_forehead" },
                encumbrance_modifiers = { "NONE" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "thermo_resin", coverage = 100, thickness = 3 },
                },
            },
            {
                covers = { "head" },
                coverage = 95,
                subparts = { "head_ear_l", "head_ear_r" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "thermo_resin", coverage = 100, thickness = 3 },
                },
            },
            {
                covers = { "eyes" },
                rigid_only = true,
                coverage = 70,
                encumbrance = 5,
                breathability = "POOR",
                materials = { { id = "thermo_resin", coverage = 100, thickness = 4 } },
            },
            {
                covers = { "mouth" },
                rigid_only = true,
                coverage = 85,
                encumbrance = 0,
                breathability = "GOOD",
                materials = { { id = "thermo_resin", coverage = 100, thickness = 4 } },
            },
        },
        warmth = 10,
    },
}

ccb.content.define_item {
    id = "helmet_galea",
    category = "armor",
    name = ccb.content.plural_text("galea", "galeae"),
    description = ccb.content.text("An Imperial Roman helmet, with distinct projections protecting the sides of the head."),
    mass = "1310 g",
    volume = "2500 ml",
    price = "350 USD",
    survival_price = "35 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                subparts = { "head_crown", "head_forehead" },
                encumbrance_modifiers = { "NONE" },
            },
            { covers = { "head" }, coverage = 20, subparts = { "head_ear_l", "head_ear_r" } },
            { covers = { "head" }, coverage = 80, subparts = { "head_nape" } },
            {
                covers = { "mouth" },
                coverage = 40,
                subparts = { "mouth_cheeks", "mouth_chin" },
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 10,
        thickness = 3,
    },
}

ccb.content.define_item {
    id = "xl_helmet_galea",
    copy_from = "helmet_galea",
    name = ccb.content.plural_text("galea", "galeae"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_galea_xs",
    copy_from = "helmet_galea",
    name = ccb.content.plural_text("galea", "galeae"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

-- Leaving this at $500 as it's either antique/priceless or player-made/Bartered, leastwise on the initial search.
ccb.content.define_item {
    id = "helmet_kabuto",
    category = "armor",
    name = ccb.content.plural_text("kabuto", "kabuto"),
    description = ccb.content.text("A medieval Japanese helmet with a scowling face mask that provides excellent protection to the entire head and face."),
    mass = "1625 g",
    volume = "3500 ml",
    price = "500 USD",
    survival_price = "50 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_forehead", "head_nape" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                covers = { "head" },
                subparts = { "head_throat" },
                coverage = 95,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 35, encumbrance = 0 },
            {
                covers = { "mouth" },
                subparts = { "mouth_lips" },
                rigid_only = true,
                coverage = 80,
                encumbrance = 10,
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_cheeks", "mouth_chin", "mouth_nose" },
                rigid_only = true,
                coverage = 100,
            },
        },
        warmth = 25,
        thickness = 4,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_helmet_kabuto",
    copy_from = "helmet_kabuto",
    name = ccb.content.plural_text("kabuto", "kabuto"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_kabuto_xs",
    copy_from = "helmet_kabuto",
    name = ccb.content.plural_text("kabuto", "kabuto"),
    flags = { "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_larmor",
    category = "armor",
    name = ccb.content.text("leather armor helmet"),
    description = ccb.content.text("A thick leather helmet that provides excellent protection for the head."),
    mass = "658 g",
    volume = "2 L",
    price = "140 USD",
    survival_price = "20 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATER_FRIENDLY", "STURDY" },
    armor = {
        warmth = 10,
        thickness = 4.5,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r" },
            },
            { coverage = 90, covers = { "head" }, subparts = { "head_forehead" } },
        },
    },
}

ccb.content.define_item {
    id = "xl_helmet_larmor",
    copy_from = "helmet_larmor",
    name = ccb.content.text("leather armor helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_larmor_xs",
    copy_from = "helmet_larmor",
    name = ccb.content.text("leather armor helmet"),
    flags = { "VARSIZE", "WATER_FRIENDLY", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_skull",
    name = ccb.content.text("wolf skull helmet"),
    description = ccb.content.text("The top part of a large wolf skull, equipped with leather straps to secure it on your head.  Every inch of the skull has been carved with a maze of fine, intertwined symbols that make your eyes water."),
    mass = "1 kg",
    volume = "4 L",
    price = "14 USD",
    survival_price = "2 USD",
    materials = { "leather", "bone" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY" },
    armor = {
        thickness = 3,
        portions = {
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
            },
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 60,
                covers = { "head" },
                subparts = { "head_forehead" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_liner",
    name = ccb.content.text("helmet liner"),
    description = ccb.content.text("A cloth liner worn inside a helmet to help keep your head warm in cold climates."),
    mass = "110 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "balclava",
    color = "green",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 30,
        thickness = 0.5,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 100, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "helmet_motor",
    category = "armor",
    name = ccb.content.plural_text("full-face motorcycle helmet", "full-face motorcycle helmets"),
    description = ccb.content.text("A helmet that covers the entire head along with glareproof visors, offering the best protection for when you ride around on your motorcycle.  Activate to raise the visor."),
    mass = "1587 g",
    volume = "2250 ml",
    length = "33 cm",
    price = "325 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "plastic", "hard_plastic_transp", "epoxy", "plastic_pad" },
    symbol = "[",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "WATERPROOF", "STURDY", "PADDED", "SUN_GLASSES" },
    melee_damage = { bash = 1 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 16 },
                },
                covers = { "head" },
                coverage = 100,
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_forehead" },
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 16 },
                },
                covers = { "head" },
                coverage = 40,
                subparts = { "head_nape", "head_throat" },
            },
            {
                materials = {
                    { id = "hard_plastic_transp", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = {
                    { id = "hard_plastic_transp", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                },
                covers = { "mouth" },
                subparts = { "mouth_nose" },
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 16 },
                },
                covers = { "mouth" },
                coverage = 100,
                subparts = { "mouth_chin" },
                encumbrance = 5,
            },
            {
                materials = {
                    { id = "hard_plastic_transp", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 50, thickness = 16 },
                },
                covers = { "mouth" },
                coverage = 100,
                subparts = { "mouth_cheeks", "mouth_lips" },
                encumbrance = 5,
            },
        },
        warmth = 30,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Raise visor"),
            target = "helmet_motor_raised",
            message = ccb.content.text("You raise your visor."),
        },
    },
}

-- Can't use copy-from and armor_portion_data at the same time, clear up this item once #43144 will be merged
ccb.content.define_item {
    id = "helmet_motor_raised",
    looks_like = "helmet_motor",
    category = "armor",
    name = ccb.content.plural_text("full-face motorcycle helmet (raised visor)", "full-face motorcycle helmets (raised visor)"),
    description = ccb.content.text("A helmet that covers the entire head along with glareproof visors, offering the best protection when you ride around on your motorcycle.  The visor is raised.  Activate to put down the visor."),
    mass = "1587 g",
    volume = "2250 ml",
    length = "33 cm",
    price = "325 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "plastic", "epoxy" },
    symbol = "[",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "WATERPROOF", "STURDY", "PADDED" },
    melee_damage = { bash = 1 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = {
                    { id = "hard_plastic_transp", coverage = 40, thickness = 2.0 },
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 16 },
                },
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_forehead" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 16 },
                },
                covers = { "head" },
                coverage = 40,
                subparts = { "head_nape", "head_throat" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 16 },
                },
                covers = { "mouth" },
                coverage = 100,
                subparts = { "mouth_chin" },
                encumbrance = 3,
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 16 },
                },
                covers = { "mouth" },
                coverage = 50,
                subparts = { "mouth_cheeks", "mouth_lips" },
                encumbrance = 2,
            },
        },
        warmth = 30,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Lower visor"),
            target = "helmet_motor",
            message = ccb.content.text("You put down your visor."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_motor_modified",
    looks_like = "helmet_motor",
    copy_from = "helmet_motor_raised",
    category = "armor",
    name = ccb.content.plural_text("modified full-face motorcycle helmet", "modified full-face motorcycle helmets"),
    description = ccb.content.text("A helmet that covers the entire head, designed to protect you from motorcycle crashes.  This one has been modified to hold mounting brackets for stuff such as NV goggles, at the cost of removing the visor."),
    mass = "1703 g",
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a face shield, or a front night vision attachment."),
            allowed_flags = { "HELMET_FACE_SHIELD", "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    flags = { "WATERPROOF", "STURDY", "PADDED", "MODULE_HOLDER" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {},
}

ccb.content.define_item {
    id = "helmet_riding",
    repair_like = "nomex_hood",
    category = "armor",
    name = ccb.content.plural_text("riding helmet", "riding helmets"),
    description = ccb.content.text("A helmet designed to protect from falls and kicks involving horses, has a small peak to protect from glare."),
    mass = "660 g",
    volume = "1800 ml",
    length = "28 cm",
    price = "70 USD",
    survival_price = "3 USD",
    techniques = { "WBLOCK_1" },
    materials = { "plastic", "epoxy", "plastic_pad" },
    symbol = "[",
    looks_like = "helmet_bike",
    color = "dark_gray",
    flags = { "WATERPROOF", "STURDY", "PADDED", "SUN_GLASSES" },
    melee_damage = { bash = 2 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        broken_item = "helmet_riding_peakless",
        portions = {
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.5 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                },
                encumbrance_modifiers = { "NONE" },
                covers = { "head" },
                subparts = { "head_crown" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.5 },
                    { id = "epoxy", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                },
                encumbrance_modifiers = { "NONE" },
                covers = { "head" },
                subparts = { "head_forehead" },
                coverage = 90,
            },
        },
        warmth = 20,
    },
}

ccb.content.define_item {
    id = "helmet_riding_peakless",
    copy_from = "helmet_riding",
    name = ccb.content.text("jockey skull cap"),
    description = ccb.content.text("A helmet designed to protect from falls and kicks involving horses."),
    mass = "650 g",
    volume = "1750 ml",
    armor = {},
    inheritance = { remove = { flags = { "SUN_GLASSES" } } },
}

ccb.content.define_item {
    id = "helmet_nasal",
    category = "armor",
    name = ccb.content.text("nasal helm"),
    description = ccb.content.text("An early medieval helmet with a projection guarding the nose, to better protect the face without obstructing vision.  Proper Viking gear, unlike the stereotypical horned helm."),
    mass = "907 g",
    volume = "2 L",
    price = "260 USD",
    survival_price = "30 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "600 ml",
            mass_limit = "2000 g",
            moves = 250,
            description = ccb.content.text("attachment for a partial or full aventail."),
            allowed_flags = { "HELMET_AVENTAIL" },
        },
    },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
                coverage = 20,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_nose" },
                coverage = 90,
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 10,
        thickness = 3,
    },
}

ccb.content.define_item {
    id = "xl_helmet_nasal",
    copy_from = "helmet_nasal",
    name = ccb.content.text("nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_nasal_xs",
    copy_from = "helmet_nasal",
    name = ccb.content.text("nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "lc_helmet_nasal",
    category = "armor",
    name = ccb.content.text("mild steel nasal helm"),
    description = ccb.content.text("An early medieval helmet with a projection guarding the nose, to better protect the face without obstructing vision.  Proper Viking gear, unlike the stereotypical horned helm.  This one is made in modern times out of steel."),
    mass = "1507 g",
    volume = "2 L",
    price = "260 USD",
    survival_price = "30 USD",
    materials = { "lc_steel", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY", "PADDED" },
    melee_damage = { bash = 3 },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "600 ml",
            mass_limit = "2000 g",
            moves = 250,
            description = ccb.content.text("attachment for a partial or full aventail."),
            allowed_flags = { "HELMET_AVENTAIL" },
        },
    },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                    { id = "leather", coverage = 50, thickness = 1 },
                },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                    { id = "leather", coverage = 50, thickness = 1 },
                },
                coverage = 20,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_nose" },
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                coverage = 90,
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 10,
        thickness = 3,
    },
}

ccb.content.define_item {
    id = "xl_lc_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("mild steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("mild steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "mc_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("medium steel nasal helm"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_helmet_nasal",
    copy_from = "mc_helmet_nasal",
    name = ccb.content.text("medium steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_helmet_nasal",
    copy_from = "mc_helmet_nasal",
    name = ccb.content.text("medium steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "hc_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("high steel nasal helm"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_helmet_nasal",
    copy_from = "hc_helmet_nasal",
    name = ccb.content.text("high steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_helmet_nasal",
    copy_from = "hc_helmet_nasal",
    name = ccb.content.text("high steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "qt_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("tempered steel nasal helm"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_helmet_nasal",
    copy_from = "qt_helmet_nasal",
    name = ccb.content.text("tempered steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_helmet_nasal",
    copy_from = "qt_helmet_nasal",
    name = ccb.content.text("tempered steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "ch_helmet_nasal",
    copy_from = "lc_helmet_nasal",
    name = ccb.content.text("hardened steel nasal helm"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_helmet_nasal",
    copy_from = "ch_helmet_nasal",
    name = ccb.content.text("hardened steel nasal helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_helmet_nasal",
    copy_from = "ch_helmet_nasal",
    name = ccb.content.text("hardened steel nasal helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_plate",
    category = "armor",
    name = ccb.content.text("great helm"),
    description = ccb.content.text("A medieval helmet that provides excellent protection to the entire head, at the cost of great encumbrance."),
    mass = "2175 g",
    volume = "2750 ml",
    price = "400 USD",
    survival_price = "50 USD",
    materials = { "steel", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "mouth" }, rigid_only = true, coverage = 100, encumbrance = 30 },
            { covers = { "eyes" }, rigid_only = true, coverage = 95, encumbrance = 20 },
        },
        warmth = 10,
        thickness = 5,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_helmet_plate",
    copy_from = "helmet_plate",
    name = ccb.content.text("great helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_plate_xs",
    copy_from = "helmet_plate",
    name = ccb.content.text("great helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_kettle",
    category = "armor",
    name = ccb.content.text("kettle helmet"),
    description = ccb.content.text("A wide-brimmed helmet that looks somewhat like a metal cowboy hat.  Sadly, it won't help protect your eyes from the sun."),
    mass = "2555 g",
    volume = "2050 ml",
    price = "300 USD",
    survival_price = "40 USD",
    materials = { "steel", "leather" },
    symbol = "n",
    looks_like = "helmet_barbute",
    color = "light_gray",
    variants = {
        {
            id = "morion",
            name = ccb.content.text("morion"),
            description = ccb.content.text("The tall crested helmet of a Spanish conquistador.  Heavy rusting implies it might be that many years old."),
            color = "dark_gray",
            weight = 0,
            append = false,
        },
    },
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 2 },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
        },
        warmth = 5,
        thickness = 4,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_helmet_kettle",
    copy_from = "helmet_kettle",
    name = ccb.content.text("kettle helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_scrap",
    category = "armor",
    name = ccb.content.text("scrap helmet"),
    description = ccb.content.text("Loose metal scraps tied precariously to your head with frayed cords.  Gaps leave critical areas exposed and the uneven weight causes constant neck strain."),
    mass = "2400 g",
    volume = "1600 ml",
    price = "4 USD",
    survival_price = "2 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "budget_steel", "cotton" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "light_gray",
    flags = { "OUTER" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 60, thickness = 2.2 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_ear_r" },
                coverage = 70,
                encumbrance_modifiers = { "IMBALANCED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_helmet_scrap",
    copy_from = "helmet_scrap",
    name = ccb.content.text("scrap helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_scrap_xs",
    copy_from = "helmet_scrap",
    name = ccb.content.text("scrap helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- The weight assumes one large sheet of about 75cm x 40cm x 1.5mm and one circular sheet with a diameter of 24cm as the crown, and one gambeson hood.
ccb.content.define_item {
    id = "helmet_metal_sheets_full",
    category = "armor",
    name = ccb.content.text("sheet metal great helm"),
    description = ccb.content.text("Massively heavy, extremely uncomfortable, very crude, and looks like a bucket with a slit cut out the front, but it'll keep zombie claws off your face.  Comes with a bevor to help spread the weight out onto your shoulders and protect your neck, and some cloth padding to keep your bell from being rung."),
    mass = "4570 g",
    volume = "2 L",
    price = "45 USD",
    survival_price = "50 cent",
    materials = { "lc_steel", "cotton" },
    repair_materials = { "steel" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "PADDED" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 40,
        thickness = 6.5,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 5 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 25,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.5 } },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_helmet_metal_sheets_full",
    copy_from = "helmet_metal_sheets_full",
    name = ccb.content.text("hardened sheet metal great helm"),
    description = ccb.content.text("It still looks like a bucket, but this crude great helm has at least been hardened for extra protection."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes one large sheet of about 75cm x 40cm x 1.5mm and one circular sheet with a diameter of 24cm as the crown, and one gambeson hood, but minus the weight of a 25cm x 30cm face cut out.
ccb.content.define_item {
    id = "helmet_metal_sheets",
    category = "armor",
    name = ccb.content.text("sheet metal helmet"),
    description = ccb.content.text("A helmet that looks like a crude bucket with the face cut out.  It comes with a bevor to distribute some of the weight to your shoulders, as well as cloth padding to keep your bell from being rung."),
    mass = "3690 g",
    volume = "2 L",
    price = "45 USD",
    survival_price = "50 cent",
    materials = { "lc_steel", "cotton" },
    repair_materials = { "lc_steel" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 35,
        thickness = 6.5,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 5 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_forehead", "head_nape" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_helmet_metal_sheets",
    copy_from = "helmet_metal_sheets",
    name = ccb.content.text("hardened sheet metal helmet"),
    description = ccb.content.text("While the design is crude, this helmet has been hardened for added protection, while still leaving your face open so you can see properly."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "helmet_skid",
    category = "armor",
    name = ccb.content.text("skid lid"),
    description = ccb.content.text("A small metal helmet that covers the head and protects against cuts and percussion."),
    mass = "1315 g",
    volume = "1250 ml",
    price = "45 USD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic", "iron" },
    symbol = "[",
    looks_like = "helmet_bike",
    color = "dark_gray",
    flags = { "PADDED" },
    techniques = { "WBLOCK_1" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 65,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
        },
    },
}

ccb.content.define_item {
    id = "pickelhaube",
    category = "armor",
    name = ccb.content.plural_text("pickelhaube", "pickelhauben"),
    description = ccb.content.text("A spiked helmet once worn by German military officers.  The spike is ornamental."),
    mass = "980 g",
    volume = "1750 ml",
    price = "240 USD",
    survival_price = "35 USD",
    accuracy = { grip = "none", length = "hand", surface = "point", balance = "clumsy" },
    materials = { "leather", "iron" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "dark_gray",
    flags = { "PADDED" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a strapped mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
    },
    melee_damage = { bash = 2, stab = 1 },
    armor = {
        warmth = 15,
        thickness = 3,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                subparts = { "head_crown" },
                covers = { "head" },
            },
            { coverage = 90, subparts = { "head_forehead" }, covers = { "head" } },
        },
    },
}

ccb.content.define_item {
    id = "helmet_corinthian",
    category = "armor",
    name = ccb.content.text("Corinthian helm"),
    description = ccb.content.text("An ancient Greek bronze helmet that provides excellent protection for the head, with slits for the eyes and mouth."),
    mass = "1310 g",
    volume = "2500 ml",
    price = "300 USD",
    survival_price = "35 USD",
    materials = { "bronze" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "yellow",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r", "head_nape" },
                coverage = 50,
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 50, encumbrance = 0 },
            {
                covers = { "mouth" },
                subparts = { "mouth_nose", "mouth_cheeks" },
                rigid_only = true,
                coverage = 95,
                encumbrance = 0,
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_lips", "mouth_chin" },
                rigid_only = true,
                coverage = 75,
                encumbrance = 0,
            },
        },
        warmth = 10,
        thickness = 3,
    },
}

ccb.content.define_item {
    id = "xl_helmet_corinthian",
    copy_from = "helmet_corinthian",
    name = ccb.content.text("Corinthian helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_corinthian_xs",
    copy_from = "helmet_corinthian",
    name = ccb.content.text("Corinthian helm"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "helmet_bronze",
    category = "armor",
    name = ccb.content.text("bronze helmet"),
    description = ccb.content.text("A solid, single piece closed bronze helmet with a slit for the eyes."),
    mass = "1110 g",
    volume = "2500 ml",
    price = "200 USD",
    survival_price = "25 USD",
    materials = { "bronze" },
    symbol = "[",
    looks_like = "helmet_corinthian",
    color = "yellow",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY" },
    melee_damage = { bash = 2 },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_forehead" },
                encumbrance_modifiers = { "NONE" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 85, encumbrance = 10 },
            { covers = { "mouth" }, rigid_only = true, coverage = 85, encumbrance = 10 },
        },
        warmth = 10,
        thickness = 2,
    },
}

ccb.content.define_item {
    id = "xl_helmet_bronze",
    copy_from = "helmet_bronze",
    name = ccb.content.text("bronze helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_helmet_bronze",
    copy_from = "helmet_bronze",
    name = ccb.content.text("bronze helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "pot_xlhelmet",
    name = ccb.content.text("pot helmet"),
    description = ccb.content.text("A huge makeshift helmet made from a canning pot.  For the truly desperate man-bear-pig."),
    mass = "6425 g",
    volume = "25 L",
    price = "220 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "[",
    looks_like = "pot_helmet",
    copy_from = "pot_helmet",
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
            },
            { coverage = 80, covers = { "head" }, subparts = { "head_forehead" } },
            { coverage = 20, covers = { "head" }, subparts = { "head_ear_l", "head_ear_r" } },
        },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "pot_helmet_xs",
    copy_from = "pot_helmet",
    name = ccb.content.text("pot helmet"),
    description = ccb.content.text("A helmet made from a soup pot.  It's not very good protection, but it's better than nothing."),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "helmet_sallet",
    category = "armor",
    name = ccb.content.plural_text("sallet helm", "sallet helms"),
    description = ccb.content.text("A popular German helmet of the late medieval era, the sallet covers the head and eyes.  Activate it to toggle the visor."),
    mass = "1800 g",
    volume = "2050 ml",
    price = "350 USD",
    survival_price = "45 USD",
    materials = { "steel", "leather" },
    symbol = "s",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 90, encumbrance = 20 },
            { covers = { "eyes" }, coverage = 60, encumbrance = 20 },
        },
        warmth = 15,
        thickness = 4,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "helmet_sallet_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "helmet_sallet_raised",
    category = "armor",
    copy_from = "helmet_sallet",
    name = ccb.content.plural_text("sallet helm (raised)", "sallet helms (raised)"),
    looks_like = "helmet_barbute",
    armor = { portions = { { covers = { "head" }, coverage = 90, encumbrance = 20 } } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "helmet_sallet",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "helmet_armet",
    category = "armor",
    name = ccb.content.plural_text("armet helm", "armet helms"),
    description = ccb.content.text("An iconic knightly helm of the late Middle Ages.  When you think of a knight's helmet, it looks something like this.  Activate it to toggle the visor."),
    mass = "2300 g",
    volume = "2050 ml",
    price = "550 USD",
    survival_price = "55 USD",
    materials = { "steel", "leather" },
    symbol = "s",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 40 },
            { covers = { "eyes" }, coverage = 70, encumbrance = 20 },
            { covers = { "mouth" }, coverage = 85, encumbrance = 30 },
        },
        warmth = 15,
        thickness = 5,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "helmet_armet_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "helmet_armet_raised",
    category = "armor",
    copy_from = "helmet_armet",
    name = ccb.content.plural_text("armet helm (raised)", "armet helms (raised)"),
    looks_like = "helmet_barbute",
    armor = { portions = { { covers = { "head" }, coverage = 100, encumbrance = 45 } } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "helmet_armet",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_lighthelm_close",
    category = "armor",
    name = ccb.content.plural_text("mild steel light close helm", "mild steel light close helms"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to raise the visor."),
    mass = "2750 g",
    volume = "3 L",
    price = "550 USD",
    survival_price = "55 USD",
    materials = { "lc_steel" },
    symbol = "o",
    looks_like = "helmet_sallet",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY", "CONDUCTIVE" },
    max_worn = 1,
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.25 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 5,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "lc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("mild steel light close helm (raised)", "mild steel light close helms (raised)"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to lower the visor."),
    looks_like = "helmet_barbute",
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "lc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_lighthelm_close",
    name = ccb.content.plural_text("mild steel light close helm", "mild steel light close helms"),
    copy_from = "lc_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_lc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_lighthelm_close_raised",
    name = ccb.content.plural_text("mild steel light close helm (raised)", "mild steel light close helms (raised)"),
    copy_from = "lc_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_lc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_lighthelm_close",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("medium steel light close helm", "medium steel light close helms"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "mc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close_raised",
    name = ccb.content.plural_text("medium steel light close helm (raised)", "medium steel light close helms (raised)"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "mc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_lighthelm_close",
    name = ccb.content.plural_text("medium steel light close helm", "medium steel light close helms"),
    copy_from = "mc_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_mc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_lighthelm_close_raised",
    name = ccb.content.plural_text("medium steel light close helm (raised)", "medium steel light close helms (raised)"),
    copy_from = "mc_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_mc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_lighthelm_close",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("high steel light close helm", "high steel light close helms"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "hc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close_raised",
    name = ccb.content.plural_text("high steel light close helm (raised)", "high steel light close helms (raised)"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "hc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_lighthelm_close",
    name = ccb.content.plural_text("high steel light close helm", "high steel light close helms"),
    copy_from = "hc_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_hc_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_lighthelm_close_raised",
    name = ccb.content.plural_text("high steel light close helm (raised)", "high steel light close helms (raised)"),
    copy_from = "hc_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_hc_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_lighthelm_close",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("hardened steel light close helm", "hardened steel light close helms"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "ch_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close_raised",
    name = ccb.content.plural_text("hardened steel light close helm (raised)", "hardened steel light close helms (raised)"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "ch_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_lighthelm_close",
    name = ccb.content.plural_text("hardened steel light close helm", "hardened steel light close helms"),
    copy_from = "ch_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_ch_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_lighthelm_close_raised",
    name = ccb.content.plural_text("hardened steel light close helm (raised)", "hardened steel light close helms (raised)"),
    copy_from = "ch_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_ch_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_lighthelm_close",
    copy_from = "lc_lighthelm_close",
    name = ccb.content.plural_text("tempered steel light close helm", "tempered steel light close helms"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "qt_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_lighthelm_close_raised",
    copy_from = "lc_lighthelm_close_raised",
    name = ccb.content.plural_text("tempered steel light close helm (raised)", "tempered steel light close helms (raised)"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "qt_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_lighthelm_close",
    name = ccb.content.plural_text("tempered steel light close helm", "tempered steel light close helms"),
    copy_from = "qt_lighthelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_qt_lighthelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_lighthelm_close_raised",
    name = ccb.content.plural_text("tempered steel light close helm (raised)", "tempered steel light close helms (raised)"),
    copy_from = "qt_lighthelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_qt_lighthelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_helm_close",
    category = "armor",
    name = ccb.content.plural_text("mild steel close helm", "mild steel close helms"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to raise the visor."),
    mass = "3750 g",
    volume = "3 L",
    price = "740 USD",
    survival_price = "74 USD",
    materials = { "lc_steel" },
    symbol = "o",
    looks_like = "helmet_sallet",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY", "CONDUCTIVE" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.75 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.75 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.75 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 5,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "lc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_helm_close_raised",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("mild steel close helm (raised)", "mild steel close helms (raised)"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to lower the visor."),
    looks_like = "helmet_barbute",
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 1.75 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "lc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_helm_close",
    name = ccb.content.plural_text("mild steel close helm", "mild steel close helms"),
    copy_from = "lc_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_lc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_helm_close_raised",
    name = ccb.content.plural_text("mild steel close helm (raised)", "mild steel close helms (raised)"),
    copy_from = "lc_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_lc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_helm_close",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("medium steel close helm", "medium steel close helms"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "mc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_helm_close_raised",
    copy_from = "lc_helm_close_raised",
    name = ccb.content.plural_text("medium steel close helm (raised)", "medium steel close helms (raised)"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "mc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_helm_close",
    name = ccb.content.plural_text("medium steel close helm", "medium steel close helms"),
    copy_from = "mc_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_mc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_helm_close_raised",
    name = ccb.content.plural_text("medium steel close helm (raised)", "medium steel close helms (raised)"),
    copy_from = "mc_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_mc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_helm_close",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("high steel close helm", "high steel close helms"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "mc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_helm_close_raised",
    copy_from = "lc_helm_close_raised",
    name = ccb.content.plural_text("high steel close helm (raised)", "high steel close helms (raised)"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "hc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_helm_close",
    name = ccb.content.plural_text("high steel close helm", "high steel close helms"),
    copy_from = "hc_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_hc_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_helm_close_raised",
    name = ccb.content.plural_text("high steel close helm (raised)", "high steel close helms (raised)"),
    copy_from = "hc_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_hc_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_helm_close",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("hardened steel close helm", "hardened steel close helms"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "ch_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_helm_close_raised",
    copy_from = "lc_helm_close_raised",
    name = ccb.content.plural_text("hardened steel close helm (raised)", "hardened steel close helms (raised)"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "ch_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_helm_close",
    name = ccb.content.plural_text("hardened steel close helm", "hardened steel close helms"),
    copy_from = "ch_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_ch_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_helm_close_raised",
    name = ccb.content.plural_text("hardened steel close helm (raised)", "hardened steel close helms (raised)"),
    copy_from = "ch_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_ch_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_helm_close",
    copy_from = "lc_helm_close",
    name = ccb.content.plural_text("tempered steel close helm", "tempered steel close helms"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "qt_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_helm_close_raised",
    copy_from = "lc_helm_close_raised",
    name = ccb.content.plural_text("tempered steel close helm (raised)", "tempered steel close helms (raised)"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "qt_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_helm_close",
    name = ccb.content.plural_text("tempered steel close helm", "tempered steel close helms"),
    copy_from = "qt_helm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_qt_helm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_helm_close_raised",
    name = ccb.content.plural_text("tempered steel close helm (raised)", "tempered steel close helms (raised)"),
    copy_from = "qt_helm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_qt_helm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_heavyhelm_close",
    category = "armor",
    name = ccb.content.plural_text("mild steel heavy close helm", "mild steel heavy close helms"),
    description = ccb.content.text("A type of helmet that was developed in the late 15th century.  Evolving from the sallet and armet, it includes a bevor to protect the neck.  Activate it to raise the visor."),
    mass = "4750 g",
    volume = "3 L",
    price = "935 USD",
    survival_price = "93 USD 50 cent",
    materials = { "lc_steel" },
    symbol = "o",
    looks_like = "helmet_sallet",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY", "CONDUCTIVE" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 2.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 2.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 2.25 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 5,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "lc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "lc_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("mild steel heavy close helm (raised)", "mild steel heavy close helms (raised)"),
    looks_like = "helmet_barbute",
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 2.25 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "lc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_heavyhelm_close",
    name = ccb.content.plural_text("mild steel heavy close helm", "mild steel heavy close helms"),
    copy_from = "lc_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_lc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("mild steel heavy close helm (raised)", "mild steel heavy close helms (raised)"),
    copy_from = "lc_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_lc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_heavyhelm_close",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("medium steel heavy close helm", "medium steel heavy close helms"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "mc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "mc_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("medium steel heavy close helm (raised)", "medium steel heavy close helms (raised)"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "mc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_heavyhelm_close",
    name = ccb.content.plural_text("medium steel heavy close helm", "medium steel heavy close helms"),
    copy_from = "mc_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_mc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_mc_heavyhelm_close_raised",
    name = ccb.content.plural_text("medium steel heavy close helm (raised)", "medium steel heavy close helms (raised)"),
    copy_from = "mc_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_mc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_heavyhelm_close",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("high steel heavy close helm", "high steel heavy close helms"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "hc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "hc_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("high steel heavy close helm (raised)", "high steel heavy close helms (raised)"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "hc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_heavyhelm_close",
    name = ccb.content.plural_text("high steel heavy close helm", "high steel heavy close helms"),
    copy_from = "hc_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_hc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_hc_heavyhelm_close_raised",
    name = ccb.content.plural_text("high steel heavy close helm (raised)", "high steel heavy close helms (raised)"),
    copy_from = "hc_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_hc_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_heavyhelm_close",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("hardened steel heavy close helm", "hardened steel heavy close helms"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "hc_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "ch_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("hardened steel heavy close helm (raised)", "hardened steel heavy close helms (raised)"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "ch_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_heavyhelm_close",
    name = ccb.content.plural_text("hardened steel heavy close helm", "hardened steel heavy close helms"),
    copy_from = "ch_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_ch_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_ch_heavyhelm_close_raised",
    name = ccb.content.plural_text("hardened steel heavy close helm (raised)", "hardened steel heavy close helms (raised)"),
    copy_from = "ch_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_ch_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_heavyhelm_close",
    copy_from = "lc_heavyhelm_close",
    name = ccb.content.plural_text("tempered steel heavy close helm", "tempered steel heavy close helms"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "qt_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "qt_heavyhelm_close_raised",
    copy_from = "lc_heavyhelm_close_raised",
    name = ccb.content.plural_text("tempered steel heavy close helm (raised)", "tempered steel heavy close helms (raised)"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "qt_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_heavyhelm_close",
    name = ccb.content.plural_text("tempered steel heavy close helm", "tempered steel heavy close helms"),
    copy_from = "qt_heavyhelm_close",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You raise the helm's visor."),
            target = "xl_qt_heavyhelm_close_raised",
            menu_text = ccb.content.text("Raise visor"),
        },
    },
}

ccb.content.define_item {
    id = "xl_qt_heavyhelm_close_raised",
    name = ccb.content.plural_text("tempered steel heavy close helm (raised)", "tempered steel heavy close helms (raised)"),
    copy_from = "qt_heavyhelm_close_raised",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the helm's visor."),
            target = "xl_qt_heavyhelm_close",
            menu_text = ccb.content.text("Lower visor"),
        },
    },
}

ccb.content.define_item {
    id = "airsoft_helmet",
    category = "armor",
    name = ccb.content.text("airsoft helmet"),
    description = ccb.content.text("A lightweight helmet that is fashioned to look like a real military helmet, but is made of plastic and only protects against BB's and other light threats.  It has a military rail system for attachments."),
    mass = "455 g",
    volume = "1850 ml",
    price = "60 USD",
    survival_price = "10 USD",
    materials = { "plastic", "plastic_pad" },
    symbol = "[",
    looks_like = "helmet_army",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "WATERPROOF", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a face shield, or a front night vision attachment."),
            allowed_flags = { "HELMET_FACE_SHIELD", "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a rail-mounted mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD", "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 6 },
                    { id = "plastic", coverage = 100, thickness = 2.5 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 6 },
                    { id = "plastic", coverage = 100, thickness = 2.5 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 50,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "airsoft_helmet_stripped",
    copy_from = "airsoft_helmet",
    category = "armor",
    name = ccb.content.plural_text("airsoft helmet (stripped)", "airsoft helmets (stripped)"),
    description = ccb.content.text("A lightweight helmet that is fashioned to look like a real military helmet, but is made of plastic and only protects against BB's and other light threats.  This one has no attachment rails."),
    mass = "325 g",
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a rail-mounted mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD", "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "lc_helmet_turban",
    category = "armor",
    name = ccb.content.text("mild steel turban helmet"),
    description = ccb.content.text("A middle eastern helmet, cylindrical on the top with protection for the nose and ears but nothing lower.  This one is made in modern times out of steel."),
    mass = "2400 g",
    volume = "1500 ml",
    price = "260 USD",
    survival_price = "25 USD",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "600 ml",
            mass_limit = "2000 g",
            moves = 250,
            description = ccb.content.text("attachment for a partial or full aventail."),
            allowed_flags = { "HELMET_AVENTAIL" },
        },
    },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
                coverage = 20,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_nose" },
                coverage = 90,
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 3,
        thickness = 2.5,
    },
}

ccb.content.define_item {
    id = "xl_lc_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("mild steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("mild steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("medium steel turban helmet"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_helmet_turban",
    copy_from = "mc_helmet_turban",
    name = ccb.content.text("medium steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_helmet_turban",
    copy_from = "mc_helmet_turban",
    name = ccb.content.text("medium steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("high steel turban helmet"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_helmet_turban",
    copy_from = "hc_helmet_turban",
    name = ccb.content.text("high steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_helmet_turban",
    copy_from = "hc_helmet_turban",
    name = ccb.content.text("high steel turban helmet"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "qt_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("tempered steel turban helmet"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_helmet_turban",
    copy_from = "qt_helmet_turban",
    name = ccb.content.text("tempered steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_helmet_turban",
    copy_from = "qt_helmet_turban",
    name = ccb.content.text("tempered steel turban helmet"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "ch_helmet_turban",
    copy_from = "lc_helmet_turban",
    name = ccb.content.text("hardened steel turban helmet"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_helmet_turban",
    copy_from = "ch_helmet_turban",
    name = ccb.content.text("hardened steel turban helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_helmet_turban",
    copy_from = "ch_helmet_turban",
    name = ccb.content.text("hardened steel turban helmet"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "string_dimension_helmet_conical",
    category = "armor",
    name = ccb.content.text("lamba khud helm"),
    description = ccb.content.text("An unusual-looking conical helm.  The perfectly smooth steel cap covers the top of the head and the ears, forming a tall cone with a spike at the top.  Chainmail covers the rest of the head, leaving only the face open.  It is padded with a modern synthetic fabric."),
    mass = "1425 g",
    volume = "3500 ml",
    price = "400 USD",
    survival_price = "35 USD",
    materials = { { id = "qt_steel", portions = 3 }, { id = "nylon", portions = 1 } },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "white",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY", "PADDED" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 10,
        portions = {
            {
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_l", "head_ear_r" },
                materials = {
                    { id = "qt_steel", coverage = 100, thickness = 2 },
                    { id = "nylon", coverage = 100, thickness = 1 },
                },
            },
            {
                coverage = 100,
                covers = { "head" },
                subparts = { "head_nape", "mouth_cheeks", "head_throat" },
                materials = { { id = "qt_steel", coverage = 100, thickness = 1.2 } },
            },
        },
    },
}

-- found in the inner cabins alongside ruana_sci_fi.  complement to cape_sci_fi, which is found as loot from nether spider
ccb.content.define_item {
    id = "helmet_sci_fi",
    category = "armor",
    name = ccb.content.plural_text("lunar veil", "lunar veils"),
    description = ccb.content.text("A wide-brimmed helm anchoring a veil of faintly latticed cloth.  The metallic fibers diffuse light in soft gradients, dimming near the crescent-moon eye-slit."),
    mass = "4100 g",
    volume = "2450 ml",
    survival_price = "150 USD",
    symbol = "n",
    color = "blue",
    flags = { "OVERSIZE", "UNBREAKABLE", "SUN_GLASSES", "PADDED" },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                encumbrance = 10,
                coverage = 100,
                materials = { { id = "nanotubes", coverage = 100, thickness = 9 } },
            },
            {
                covers = { "head" },
                subparts = { "head_nape", "head_throat", "head_ear_r", "head_ear_l" },
                encumbrance = 5,
                coverage = 100,
                materials = { { id = "nanotubes", coverage = 100, thickness = 2.5 } },
            },
            {
                covers = { "mouth" },
                encumbrance = 5,
                coverage = 100,
                materials = { { id = "nanotubes", coverage = 100, thickness = 2.5 } },
            },
        },
        warmth = 20,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Lower the veil"),
            target = "helmet_sci_fi_lowered",
            message = ccb.content.text("You lower the veil and bundle it about your throat."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_sci_fi_lowered",
    category = "armor",
    name = ccb.content.plural_text("lunar veil (lowered)", "lunar veils (lowered)"),
    description = ccb.content.text("A wide-brimmed helm; the veil of faintly latticed cloth gathered into a crinkled scarf.  The metallic fibers diffuse light in soft gradients."),
    mass = "3100 g",
    volume = "2450 ml",
    survival_price = "150 USD",
    symbol = "n",
    color = "blue",
    flags = { "OVERSIZE", "UNBREAKABLE", "SUN_GLASSES", "PADDED" },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                encumbrance = 10,
                coverage = 100,
                materials = { { id = "nanotubes", coverage = 100, thickness = 9 } },
            },
            {
                covers = { "head" },
                subparts = { "head_nape", "head_throat" },
                encumbrance = 10,
                coverage = 50,
                materials = { { id = "nanotubes", coverage = 100, thickness = 5 } },
            },
        },
        warmth = 20,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Raise the veil"),
            target = "helmet_sci_fi",
            message = ccb.content.text("You raise the veil."),
        },
    },
}
