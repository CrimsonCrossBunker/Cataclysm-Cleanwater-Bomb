local ccb = require("ccb")

ccb.content.define_item {
    id = "rebreather",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("rebreather mask", "rebreather masks"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  Use it to turn it on."),
    flags = { "WATER_FRIENDLY", "PADDED" },
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum" },
    mass = "720 g",
    volume = "500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "REBREATHER_CART" },
            default_magazine = "rebreather_cartridge_o2",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "rebreather_filter", "rebreather_o2_regenerator" } },
    armor = {
        warmth = 10,
        environmental_protection = 3,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "rebreather_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "rebreather_on",
    copy_from = "rebreather",
    materials = { "plastic", "aluminum" },
    name = ccb.content.plural_text("rebreather mask (on)", "rebreather masks (on)"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = { "WATER_FRIENDLY", "REBREATHER", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "rebreather",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = {
        environmental_protection = 15,
        portions = { { encumbrance = 20, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "rebreather",
        },
    },
}

ccb.content.define_item {
    id = "rebreather_xl",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("rebreather mask", "rebreather masks"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  This model has been expanded substantially and can accommodate exotic anatomy.  Use it to turn it on."),
    flags = { "WATER_FRIENDLY", "OVERSIZE", "PREFIX_XL" },
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum" },
    mass = "960 g",
    volume = "1250 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "REBREATHER_CART" },
            default_magazine = "rebreather_cartridge_o2",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "rebreather_filter", "rebreather_o2_regenerator" } },
    armor = {
        warmth = 10,
        environmental_protection = 3,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "rebreather_xl_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "rebreather_xl_on",
    copy_from = "rebreather_xl",
    name = ccb.content.plural_text("rebreather mask (on)", "rebreather masks (on)"),
    materials = { "plastic", "aluminum" },
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  This model has been expanded substantially and can accommodate exotic anatomy.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = { "WATER_FRIENDLY", "REBREATHER", "OVERSIZE", "PREFIX_XL", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "rebreather_xl",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = {
        environmental_protection = 15,
        portions = { { encumbrance = 20, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "rebreather_xl",
        },
    },
}

ccb.content.define_item {
    id = "rebreather_xs",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("rebreather mask", "rebreather masks"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  This model has been shrunk dramatically to fit a smaller face.  Use it to turn it on."),
    flags = { "WATER_FRIENDLY", "UNDERSIZE", "PREFIX_XS" },
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum" },
    mass = "360 g",
    volume = "250 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "REBREATHER_CART" },
            default_magazine = "rebreather_cartridge_o2",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "rebreather_filter", "rebreather_o2_regenerator" } },
    armor = {
        covers = { "mouth" },
        warmth = 10,
        environmental_protection = 3,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "rebreather_xs_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "rebreather_xs_on",
    copy_from = "rebreather_xs",
    name = ccb.content.plural_text("rebreather mask (on)", "rebreather masks (on)"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  This model has been shrunk dramatically to fit a smaller face.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = { "WATER_FRIENDLY", "REBREATHER", "UNDERSIZE", "PREFIX_XS", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "rebreather_xs",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = {
        covers = { "mouth" },
        environmental_protection = 15,
        portions = { { encumbrance = 20, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "rebreather_xs",
        },
    },
}

ccb.content.define_item {
    id = "scuba_regulator",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("SCUBA regulator", "SCUBA regulators"),
    description = ccb.content.text("A set of hoses and regulators used by SCUBA divers to breathe underwater.  Wear it, open an air tank, and activate it to prepare it for use."),
    flags = { "WATER_FRIENDLY", "PADDED", "NORMAL", "SKINTIGHT", "SCBA" },
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum", "rubber" },
    mass = "1000 g",
    volume = "1500 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 3,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = { "SCBA_MASK_ACTIVATE" },
}

ccb.content.define_item {
    id = "scuba_regulator_scba_on",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("SCUBA regulator (on)", "SCUBA regulators (on)"),
    description = ccb.content.text("A set of hoses and regulators used by SCUBA divers to breathe underwater.  It is currently being fed air.  Activate it to turn it off."),
    flags = { "WATER_FRIENDLY", "PADDED", "NORMAL", "SKINTIGHT", "SCBA_ON", "SPAWN_ACTIVE" },
    revert_to = "scuba_regulator",
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum", "rubber" },
    mass = "1000 g",
    volume = "1500 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 16,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn off the regulator."),
            menu_text = ccb.content.text("Turn off the regulator"),
            target = "scuba_regulator",
        },
    },
    tick_actions = { "SCBA_MASK" },
}

ccb.content.define_item {
    id = "mask_filter",
    name = ccb.content.plural_text("filter mask", "filter masks"),
    category = "clothing",
    description = ccb.content.text("A mask that straps over your mouth and nose and filters air.  Protects from smoke, dust, and other contaminants quite well.  It must be prepared before use."),
    flags = { "SLEEP_IGNORE" },
    mass = "260 g",
    volume = "500 ml",
    price = "35 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "mask_dust",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_SM" },
            default_magazine = "gasfilter_sm",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_s" },
    armor = {
        warmth = 10,
        thickness = 2,
        environmental_protection = 3,
        filtered_protection = 7,
        portions = { { encumbrance = 15, rigid_only = true, coverage = 100, covers = { "mouth" } } },
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

-- Based on https://www.avon-protection.com/products/c50/
-- While it's based on the C50, this could equally be the FM53, CM8, or an assortment of other gas masks that fall into the same category.
-- The cotton represents the head harness that keeps the mask attached to one's melon. Hood-style masks, like the GP5, should get their own item.
-- While some older gas masks had lenses made from glass, most modern ones are fabricated with plastic eyepieces or visors. We can hand-wave away the outliers.
-- The exhale valve, speech diaphragm, and, if a mask has them, the communications unit and drinking tube, are located over the mouth and nose sections. They're represented by the plastic content.
-- Most modern gas masks possess plastic filter mounts on either one or both of the cheek sections, which this plastic represents. Again, we can tactically handwave away the outliers.
ccb.content.define_item {
    id = "mask_gas",
    category = "clothing",
    name = ccb.content.plural_text("gas mask", "gas masks"),
    description = ccb.content.text("A full-face, industrial-grade respirator made from a solid black silicon and butyl rubber blend, providing decent user comfort in addition to a clear field of view and a secure fit thanks to the mask's single-element visor and 6-point head harness.  Provided that a filter canister's been screwed into the right-side filter port and the respirator's been prepared, it'll do an admirable job at preventing smoke, gas, and contaminants derived from chemical and lab work from taking up residence in your organs."),
    mass = "490 g",
    volume = "1536 ml",
    length = "27 cm",
    price = "499 USD 50 cent",
    survival_price = "7 USD 50 cent",
    materials = { { id = "butyl_rubber", portions = 3 }, { id = "plastic", portions = 2 } },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "50 ml",
            mass_limit = "60 g",
            max_item_length = "17 cm",
            moves = 250,
            description = ccb.content.text("A number of external brackets arranged around the eyepiece to retain an outer attachment."),
            allowed_flags = { "PANORAMIC_OUTSERT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            rigid = true,
            ablative = true,
            volume_encumbrance = 0,
            capacity = "50 ml",
            mass_limit = "50 g",
            max_item_length = "10 cm",
            moves = 380,
            description = ccb.content.text("A space behind the visor designed to accommodate the installation of inserts."),
            allowed_flags = { "PANORAMIC_INSERT" },
            inherits_flags = true,
        },
    },
    flags = { "SKINTIGHT", "NORMAL", "SLEEP_IGNORE", "VARSIZE", "PADDED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = { { id = "cotton", coverage = 100, thickness = 0.2 } },
                covers = { "head" },
                subparts = { "head_crown", "head_nape" },
                coverage = 25,
                encumbrance = 0,
                layers = { "SKINTIGHT" },
                volume_encumbrance = 0,
            },
            {
                materials = { { id = "butyl_rubber", coverage = 100, thickness = 2 } },
                covers = { "head" },
                subparts = { "head_forehead" },
                coverage = 100,
                encumbrance = 20,
                volume_encumbrance = 0,
                layers = { "SKINTIGHT" },
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 2 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 10,
                layers = { "SKINTIGHT", "NORMAL" },
                rigid_only = true,
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "butyl_rubber", coverage = 100, thickness = 2 },
                    { id = "plastic", coverage = 30, thickness = 1 },
                },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                subparts = {
                    "mouth_lips", "mouth_nose", "mouth_chin", "muzzle_lips", "muzzle_nose",
                    "muzzle_chin", "beak_tip", "beak_bottom", "beak_top", "insect_proboscis_base",
                    "insect_proboscis_labium", "insect_proboscis_bottom",
                },
                coverage = 100,
                encumbrance = { 20, 40 },
                layers = { "SKINTIGHT", "NORMAL" },
            },
            {
                materials = {
                    { id = "butyl_rubber", coverage = 100, thickness = 2 },
                    { id = "plastic", coverage = 25, thickness = 1 },
                },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                subparts = { "mouth_cheeks", "muzzle_cheeks", "beak_nares", "insect_proboscis_cheeks" },
                coverage = 100,
                encumbrance = 20,
                layers = { "SKINTIGHT", "NORMAL", "OUTER" },
                volume_encumbrance = 0,
            },
        },
        warmth = 40,
        thickness = 2,
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_gas_xl",
    name = ccb.content.plural_text("gas mask", "gas masks"),
    copy_from = "mask_gas",
    looks_like = "mask_gas",
    flags = { "VARSIZE", "OVERSIZE", "PREFIX_XL", "SLEEP_IGNORE" },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_gas_xs",
    name = ccb.content.plural_text("gas mask", "gas masks"),
    copy_from = "mask_gas",
    looks_like = "mask_gas",
    flags = { "VARSIZE", "UNDERSIZE", "PREFIX_XS", "SLEEP_IGNORE" },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_gas_half",
    name = ccb.content.plural_text("half-face gas mask", "half-face gas masks"),
    category = "clothing",
    description = ccb.content.text("A lightweight, form-fitting mask that straps over your mouth and nose, providing full protection from the inhalation of smoke, tear gas, and chemical contaminants - though safety goggles are advised!  It must be prepared before use."),
    flags = { "SLEEP_IGNORE" },
    mass = "400 g",
    volume = "500 ml",
    price = "52 USD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "mask_dust",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        warmth = 12,
        thickness = 2,
        environmental_protection = 3,
        filtered_protection = 16,
        portions = { { encumbrance = 35, rigid_only = true, coverage = 100, covers = { "mouth" } } },
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_fsurvivor",
    category = "armor",
    name = ccb.content.plural_text("handmade firemask", "handmade firemasks"),
    description = ccb.content.text("A custom-made leather gas mask faced with Nomex.  It must be prepared before use."),
    mass = "686 g",
    volume = "1250 ml",
    price = "260 USD",
    survival_price = "18 USD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    materials = { "nomex", "leather_treated", "hard_plastic_transp" },
    symbol = "[",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "SUN_GLASSES", "SLEEP_IGNORE", "UNRESTRICTED", "PADDED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 4 },
                    { id = "nomex", coverage = 100, thickness = 2 },
                },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                coverage = 100,
                encumbrance = 37,
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 5 } },
                covers = { "eyes", "eyes_compound" },
                coverage = 100,
                encumbrance = 25,
            },
        },
        warmth = 25,
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_fsurvivorxl",
    copy_from = "mask_fsurvivor",
    looks_like = "mask_fsurvivor",
    name = ccb.content.plural_text("handmade firemask", "handmade firemasks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "OVERSIZE",
        "PREFIX_XL",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_fsurvivorxs",
    copy_from = "mask_fsurvivor",
    looks_like = "mask_fsurvivor",
    name = ccb.content.plural_text("handmade firemask", "handmade firemasks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "UNDERSIZE",
        "PREFIX_XS",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_bunker",
    category = "armor",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("firefighter respirator mask", "firefighter respirator masks"),
    description = ccb.content.text("A full-face mask commonly used by firefighters.  When connected to an air source, the breathing apparatus provides excellent protection from smoke, flame, and other dangers.  Wear it, activate an air source, and activate it to engage airflow."),
    flags = { "WATERPROOF", "STURDY", "PADDED", "SCBA" },
    price = "1 kUSD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic", "nomex" },
    mass = "1260 g",
    volume = "1500 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 25,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 3 },
                    { id = "plastic", coverage = 100, thickness = 3 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 25,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 3 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
    use_actions = { "SCBA_MASK_ACTIVATE" },
}

ccb.content.define_item {
    id = "mask_bunker_scba_on",
    category = "armor",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("firefighter respirator mask (on)", "firefighter respirator masks (on)"),
    description = ccb.content.text("A full-face mask commonly used by firefighters.  When connected to an air source, the breathing apparatus provides excellent protection from smoke, flame, and other dangers.  It is currently part of an active SCBA system.  Activate it to turn it off."),
    copy_from = "mask_bunker",
    flags = { "WATERPROOF", "STURDY", "SUN_GLASSES", "SLEEP_IGNORE", "PADDED", "SCBA_ON" },
    revert_to = "mask_bunker",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { environmental_protection = 16 },
    tick_actions = { "SCBA_MASK" },
}

ccb.content.define_item {
    id = "mask_hsurvivor",
    category = "armor",
    name = ccb.content.plural_text("handmade plated gas mask", "handmade plated gas masks"),
    description = ccb.content.text("A gas mask handcrafted from treated leather with a steel faceplate overtop.  It must be prepared before use."),
    mass = "686 g",
    volume = "1350 ml",
    price = "260 USD",
    survival_price = "18 USD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    materials = { "leather_treated", "hard_plastic_transp", "lc_steel" },
    symbol = "[",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "SUN_GLASSES", "SLEEP_IGNORE", "PADDED", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 4 },
                    { id = "lc_steel", coverage = 90, thickness = 1 },
                },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                coverage = 100,
                encumbrance = 38,
            },
            {
                materials = {
                    { id = "hard_plastic_transp", coverage = 100, thickness = 5 },
                    { id = "lc_steel", coverage = 15, thickness = 1 },
                },
                covers = { "eyes", "eyes_compound" },
                layers = { "SKINTIGHT", "NORMAL" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 28,
            },
        },
        warmth = 28,
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_hsurvivorxl",
    copy_from = "mask_hsurvivor",
    looks_like = "mask_hsurvivor",
    name = ccb.content.plural_text("handmade plated gas mask", "handmade plated gas masks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "OVERSIZE",
        "PREFIX_XL",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_hsurvivorxs",
    copy_from = "mask_hsurvivor",
    looks_like = "mask_hsurvivor",
    name = ccb.content.plural_text("handmade plated gas mask", "handmade plated gas masks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "UNDERSIZE",
        "PREFIX_XS",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_lsurvivor",
    category = "armor",
    name = ccb.content.plural_text("handmade half gas mask", "handmade half gas masks"),
    description = ccb.content.text("A half-face gas mask handcrafted from treated leather.  It provides no protection for the eyes, and must be activated before use."),
    mass = "341 g",
    volume = "625 ml",
    price = "200 USD",
    survival_price = "14 USD 50 cent",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    materials = { "leather_treated" },
    symbol = "[",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "SLEEP_IGNORE", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = { { id = "leather_treated", coverage = 100, thickness = 4 } },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                coverage = 100,
                encumbrance = 35,
            },
        },
        warmth = 15,
        environmental_protection = 4,
        filtered_protection = 15,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_lsurvivorxl",
    copy_from = "mask_lsurvivor",
    looks_like = "mask_lsurvivor",
    name = ccb.content.plural_text("handmade half gas mask", "handmade half gas masks"),
    flags = { "VARSIZE", "STURDY", "OVERSIZE", "PREFIX_XL", "SLEEP_IGNORE", "UNRESTRICTED" },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_lsurvivorxs",
    copy_from = "mask_lsurvivor",
    looks_like = "mask_lsurvivor",
    name = ccb.content.plural_text("handmade half gas mask", "handmade half gas masks"),
    flags = { "VARSIZE", "STURDY", "SLEEP_IGNORE", "UNDERSIZE", "PREFIX_XS", "UNRESTRICTED" },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_survivor",
    category = "armor",
    name = ccb.content.plural_text("handmade gas mask", "handmade gas masks"),
    description = ccb.content.text("A gas mask handcrafted from treated leather.  It must be prepared before use."),
    mass = "682 g",
    volume = "1250 ml",
    price = "240 USD",
    survival_price = "17 USD 50 cent",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    materials = { "leather_treated", "hard_plastic_transp" },
    symbol = "[",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "SUN_GLASSES", "SLEEP_IGNORE", "PADDED", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = { { id = "leather_treated", coverage = 100, thickness = 4 } },
                covers = { "mouth", "beak", "muzzle", "insect_proboscis" },
                coverage = 100,
                encumbrance = 35,
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 5 } },
                covers = { "eyes", "eyes_compound" },
                layers = { "SKINTIGHT", "NORMAL" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 25,
            },
        },
        warmth = 20,
        environmental_protection = 4,
        filtered_protection = 15,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_survivorxl",
    copy_from = "mask_survivor",
    looks_like = "mask_survivor",
    name = ccb.content.plural_text("handmade gas mask", "handmade gas masks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "OVERSIZE",
        "PREFIX_XL",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_survivorxs",
    copy_from = "mask_survivor",
    looks_like = "mask_survivor",
    name = ccb.content.plural_text("handmade gas mask", "handmade gas masks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "UNDERSIZE",
        "PREFIX_XS",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}
