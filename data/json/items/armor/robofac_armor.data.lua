local ccb = require("ccb")

-- at least 3x thicker than a normal poncho
-- Why no PALS? Fundamentally PALS is a decent system but adds a pile of additional weight in straps and fasteners, they also unless very well designed aren't particularly low profile and can catch on stuff. It's fun for a game but in the real world you can just buy a bag with the pockets and utility you want, or as the current fad in Tacticool Operators ™️  go with a micro rig or a dedicated pre pocketed harness. So for military use where you are expected to carry 270 rounds of ammo weight is a lot less splitting hairs. In an apocalypse scenario where you will be moving on foot, potentially with low calories to supplement and no chain of resupply that weight can really matter.
ccb.content.define_item {
    id = "robofac_armor_rig",
    category = "armor",
    looks_like = "poncho",
    name = ccb.content.text("Hub 01 modular defense system"),
    description = ccb.content.text("A custom-designed poncho for the true frontier explorer, made with aramid fibers and robust ripstop nylon.  Striped in brown and blue, the white seal of Hub 01 is emblazoned proudly on the front.  It features several quick access pouches attached to a waist drawstring, and two waterproof dry bags for carrying liquids.  It also features several tight clamps and velcro strips around the waist and shoulders; perhaps something attaches to them."),
    mass = "960 g",
    volume = "250 ml",
    price = "40 USD",
    survival_price = "7 USD 50 cent",
    symbol = "[",
    materials = { "nylon", "kevlar" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATERPROOF", "VARSIZE", "RAINPROOF", "HOOD", "SOFT" },
    pockets = {
        {
            description = ccb.content.text("Watertight internal reservoir."),
            kind = "CONTAINER",
            capacity = "1500 ml",
            max_item_volume = "32 ml",
            watertight = true,
            spoil_multiplier = 0.8,
            mass_limit = "4 kg",
            moves = 120,
        },
        {
            description = ccb.content.text("Watertight internal reservoir."),
            kind = "CONTAINER",
            capacity = "1500 ml",
            max_item_volume = "32 ml",
            watertight = true,
            spoil_multiplier = 0.8,
            mass_limit = "4 kg",
            moves = 120,
        },
        {
            description = ccb.content.text("Quick access pouches."),
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "4 kg",
            max_item_length = "270 mm",
            moves = 80,
        },
        {
            description = ccb.content.text("Quick access pouches."),
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "4 kg",
            max_item_length = "270 mm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "7000 ml",
            mass_limit = "11 kg",
            moves = 200,
            description = ccb.content.text("Hooks for an armored mantle."),
            allowed_flags = { "ABLATIVE_MANTLE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "4000 ml",
            mass_limit = "4 kg",
            moves = 200,
            description = ccb.content.text("Hooks for an armored skirt."),
            allowed_flags = { "ABLATIVE_SKIRT" },
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1100 g",
            max_item_length = "70 cm",
            moves = 200,
            holster = true,
            description = ccb.content.text("Strap for a gun barrel."),
            allowed_items = {
                "robofac_gun_ar", "robofac_gun_smg", "robofac_gun_dmr", "robofac_gun_shotgun",
                "robofac_gun_shotgun_breach", "robofac_gun_exodii", "robofac_gun_57",
            },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "4000 ml",
            mass_limit = "900 g",
            moves = 200,
            description = ccb.content.text("Grommets for a poncho liner."),
            allowed_items = { "military_poncho_liner", "robofac_poncho_liner" },
        },
    },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = {
            {
                encumbrance = { 4, 8 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                layers = { "OUTER", "BELTED" },
            },
            {
                encumbrance = { 4, 4 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r" },
            },
            {
                encumbrance = { 4, 4 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "robofac_armor_anchor",
    copy_from = "robofac_armor_rig",
    name = ccb.content.plural_text("Hub 01 modular defense anchor", "Hub 01 modular defense anchors"),
    description = ccb.content.text("A custom-designed poncho for the true frontier explorer, made with aramid fibers and robust ripstop nylon.  This one features a hardened skeleton of ceramic plates running up and over the shoulders, and a portion of the front has been raised upwards from the rest.  Lifting the fabric reveals a large disc-shaped device installed into the garment, featureless except for a prominent switch and Hub 01's logo in LED.  In addition to the poncho's usual complement of storage, a battery compartment has been added that wires into this device, featuring very specialized connectors and, perhaps a little disconcertingly, radiation shielding."),
    mass = "2000 g",
    volume = "4250 ml",
    materials = { "nylon", "kevlar", "ceramic" },
    pockets = {
        {
            description = ccb.content.text("Watertight internal reservoir."),
            kind = "CONTAINER",
            capacity = "1500 ml",
            max_item_volume = "32 ml",
            watertight = true,
            spoil_multiplier = 0.8,
            mass_limit = "4 kg",
            moves = 120,
        },
        {
            description = ccb.content.text("Watertight internal reservoir."),
            kind = "CONTAINER",
            capacity = "1500 ml",
            max_item_volume = "32 ml",
            watertight = true,
            spoil_multiplier = 0.8,
            mass_limit = "4 kg",
            moves = 120,
        },
        {
            description = ccb.content.text("Quick access pouches."),
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "4 kg",
            max_item_length = "270 mm",
            moves = 80,
        },
        {
            description = ccb.content.text("Quick access pouches."),
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "4 kg",
            max_item_length = "270 mm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "7000 ml",
            mass_limit = "11 kg",
            moves = 200,
            description = ccb.content.text("Hooks for an armored mantle."),
            allowed_flags = { "ABLATIVE_MANTLE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "4000 ml",
            mass_limit = "4 kg",
            moves = 200,
            description = ccb.content.text("Hooks for an armored skirt."),
            allowed_flags = { "ABLATIVE_SKIRT" },
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1100 g",
            max_item_length = "70 cm",
            moves = 200,
            holster = true,
            description = ccb.content.text("Strap for a gun barrel."),
            allowed_items = {
                "robofac_gun_ar", "robofac_gun_smg", "robofac_gun_dmr", "robofac_gun_shotgun",
                "robofac_gun_shotgun_breach", "robofac_gun_exodii", "robofac_gun_57",
            },
        },
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "4000 ml",
            mass_limit = "900 g",
            moves = 200,
            description = ccb.content.text("Grommets for a poncho liner."),
            allowed_items = { "military_poncho_liner", "robofac_poncho_liner" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.5 },
                    { id = "ceramic", coverage = 50, thickness = 1.5 },
                },
                encumbrance = { 6, 10 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                layers = { "OUTER", "BELTED" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.5 },
                },
                encumbrance = { 4, 4 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.5 },
                },
                encumbrance = { 4, 4 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate the anchor, and the Hub 01 logo on your front begins to glow white."),
            target = "robofac_armor_anchor_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}

ccb.content.define_item {
    id = "robofac_armor_anchor_on",
    copy_from = "robofac_armor_anchor",
    name = ccb.content.plural_text("Hub 01 modular defense anchor (on)", "Hub 01 modular defense anchors (on)"),
    looks_like = "robofac_armor_anchor",
    description = ccb.content.text("A custom-designed poncho for the true frontier explorer, made with aramid fibers and robust ripstop nylon.  The logo of Hub 01 emblazoned on the chest is glowing white."),
    revert_to = "robofac_armor_anchor",
    flags = {
        "DIMENSIONAL_ANCHOR", "PORTAL_PROOF", "STURDY", "OUTER", "WATERPROOF", "VARSIZE", "RAINPROOF",
        "HOOD", "SOFT", "SPAWN_ACTIVE",
    },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 100 },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The Hub logo on your front stops glowing."),
            target = "robofac_armor_anchor",
        },
    },
}

-- nv goggles weight 1020g.  hub armor rig weight 960g for full body.  figure this strikes a decent midpoint, esp.  since weight here becomes head encumb.  materials wise, same nylon/kevlar weave as the poncho; the visor is being handwaved per the riot helmet and motorcycle helmet visors as precedent.
ccb.content.define_item {
    id = "robofac_head_rig",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 modular recon headgear", "Hub 01 modular recon headgear"),
    looks_like = "tac_helmet",
    description = ccb.content.text("Heavy duty hooded headwear for the true frontier explorer, made with robust Nylon sheeting reinforced with Kevlar fibers.  The top consists of a series of plastic plates with hooks and velcro strips, perhaps for attaching additional parts.  On the forehead of the assembly is a bulky box visor on a mechanism to quickly pull it down over your eyes, with a cover on the side to insert standard batteries.  Activate to lower the visor and use the light amplification functions."),
    mass = "1200 g",
    volume = "1200 ml",
    price = "100 USD",
    survival_price = "20 USD",
    materials = { "nylon", "kevlar" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "5000 ml",
            mass_limit = "5 kg",
            moves = 200,
            description = ccb.content.text("Hooks for an armored helm plate."),
            allowed_flags = { "ABLATIVE_HELMET" },
        },
    },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "PADDED", "OUTER", "RAINPROOF", "SOFT", "MUNDANE" },
    techniques = { "WBLOCK_1" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = { { covers = { "head" }, coverage = 95, encumbrance_modifiers = { "NONE" } } },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the visor and flick the control dial to light amplification mode."),
            target = "robofac_head_rig_nv",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

-- works out at 20 eye encumb in game, same as normal NV/IRs
ccb.content.define_item {
    id = "robofac_head_rig_nv",
    category = "armor",
    copy_from = "robofac_head_rig",
    name = ccb.content.plural_text("Hub 01 modular recon headgear (NV+IR)", "Hub 01 modular recon headgear (NV+IR)"),
    description = ccb.content.text("Heavy duty hooded headwear for the true frontier explorer.  The visor has been lowered over the eyes, and is drawing low power to provide light amplification by way of an infrared illuminator and detector.  Lets you see in the dark, and detects heat signatures emitted by (un)living organisms.  Activate again to turn off and stow the visor."),
    revert_to = "robofac_head_rig",
    inheritance = { add = { flags = { "GNV_EFFECT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "320 mW" },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 95, encumbrance_modifiers = { "NONE" } },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 4.0 },
                    { id = "steel", coverage = 100, thickness = 2.0 },
                },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 30,
                layers = { "BELTED" },
            },
        },
    },
    artifact = { enchantments = { "nvg_good", "THERMAL_VISION_GOOD" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You flick the visor off, and push it off your face."),
            target = "robofac_head_rig",
        },
    },
}

ccb.content.define_item {
    id = "robofac_head_rig_ar",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 visual augmentation headgear", "Hub 01 visual augmentation headgear"),
    looks_like = "tac_helmet",
    description = ccb.content.text("Heavy duty hooded headwear for the true frontier explorer, made with robust Nylon sheeting reinforced with Kevlar fibers.  The top consists of a series of plastic plates with hooks and velcro strips, perhaps for attaching additional parts, and an integrated camera array.  A multi-faceted augmented reality headset rests of the forehead like a pair of slim, boxy ski goggles, with side plugs for auxiliary devices.  The AR lenses are equipped with adaptive light correction, light amplification and thermal imaging, and an augmented reality overlay equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  Activate it to turn on all systems."),
    mass = "1400 g",
    volume = "1200 ml",
    price = "200 USD",
    survival_price = "40 USD",
    materials = { "nylon", "kevlar", "plastic" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "5000 ml",
            mass_limit = "5 kg",
            moves = 200,
            description = ccb.content.text("Hooks for an armored helm plate."),
            allowed_flags = { "ABLATIVE_HELMET" },
        },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "1 TB",
        },
    },
    flags = {
        "VARSIZE", "WATERPROOF", "STURDY", "PADDED", "OUTER", "RAINPROOF", "SOFT", "MUNDANE",
        "ELECTRONIC", "CAN_USE_IN_DARK",
    },
    techniques = { "WBLOCK_1" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, transfer_rate = "30 MB", ammo_types = "battery" },
    armor = {
        warmth = 10,
        thickness = 3,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.5 },
                },
                covers = { "head" },
                coverage = 95,
                encumbrance = 55,
                volume_encumbrance = 0,
            },
        },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the AR headset and switch it on.\n\"HELLO MERCENARY\".\nVisual systems:   ONLINE.\nRadio systems:    ONLINE.\nTargeting HUD:    ONLINE."),
            target = "robofac_head_rig_ar_on",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}

ccb.content.define_item {
    id = "robofac_head_rig_ar_on",
    copy_from = "robofac_head_rig_ar",
    name = ccb.content.plural_text("Hub 01 visual augmentation headgear (on)", "Hub 01 visual augmentation headgear (on)"),
    description = ccb.content.text("Heavy duty hooded headwear for the true frontier explorer, made with robust Nylon sheeting reinforced with Kevlar fibers.  The top consists of a series of plastic plates with hooks and velcro strips, perhaps for attaching additional parts, and an integrated camera array.  A multi-faceted augmented reality headset rests of the forehead like a pair of slim, boxy ski goggles, with side plugs for auxiliary devices.  The AR lenses are equipped with adaptive light correction, light amplification and thermal imaging, and an augmented reality overlay equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  The AR system is currently turned on, and continually draining batteries.  Use it to turn it off."),
    revert_to = "robofac_head_rig_ar",
    inheritance = {
        add = {
            flags = {
                "SPAWN_ACTIVE", "ZOOM", "THERMOMETER", "HYGROMETER", "BAROMETER", "TWO_WAY_RADIO",
                "WATCH", "ALARMCLOCK", "SUN_GLASSES",
            },
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "320 mW" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.5 },
                },
                covers = { "head" },
                coverage = 95,
                encumbrance = 50,
                volume_encumbrance = 0,
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 2 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
                rigid_only = true,
                volume_encumbrance = 0,
            },
        },
    },
    artifact = { enchantments = { "nvg_great", "THERMAL_VISION_GOOD", "AR_targeting_system" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your AR system turns off."),
            target = "robofac_head_rig_ar",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}

ccb.content.define_item {
    id = "robofac_robotrig",
    name = ccb.content.plural_text("drone-tech harness", "drone-tech harness"),
    description = ccb.content.text("A modified army harness, repurposed to carry several small and a single medium sized drone alongside the tools to maintain them."),
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
            max_item_length = "800 mm",
            name = ccb.content.text("Medium drone strap"),
            description = ccb.content.text("A series of connectors meant to hold a medium sized drone on your back."),
            capacity = "150 L",
            mass_limit = "40 kg",
            moves = 400,
            allowed_flags = { "ROBOFAC_ROBOT_MEDIUM" },
            holster = true,
            volume_encumbrance = 0.015,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "6 kg",
            name = ccb.content.text("Small drone holder"),
            description = ccb.content.text("A series of connectors meant to store a small drone."),
            moves = 80,
            allowed_flags = { "ROBOFAC_ROBOT_SMALL" },
            holster = true,
            volume_encumbrance = 0.03,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "6 kg",
            name = ccb.content.text("Small drone holder"),
            description = ccb.content.text("A series of connectors meant to store a small drone."),
            moves = 80,
            allowed_flags = { "ROBOFAC_ROBOT_SMALL" },
            holster = true,
            volume_encumbrance = 0.03,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "6 kg",
            name = ccb.content.text("Small drone holder"),
            description = ccb.content.text("A series of connectors meant to store a small drone."),
            moves = 80,
            allowed_flags = { "ROBOFAC_ROBOT_SMALL" },
            holster = true,
            volume_encumbrance = 0.03,
        },
        {
            kind = "CONTAINER",
            description = ccb.content.text("Gadget pouch"),
            capacity = "1000 ml",
            mass_limit = "4 kg",
            max_item_length = "15 cm",
            moves = 110,
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            description = ccb.content.text("Gadget pouch"),
            capacity = "1000 ml",
            mass_limit = "4 kg",
            max_item_length = "15 cm",
            moves = 110,
            volume_encumbrance = 0.3,
        },
        {
            description = ccb.content.text("Quick access pouches."),
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "4 kg",
            max_item_length = "5 cm",
            moves = 80,
        },
        {
            holster = true,
            description = ccb.content.text("Tool clip"),
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1500 g",
            max_item_length = "70 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
            transparent = true,
        },
        {
            holster = true,
            description = ccb.content.text("Tool clip"),
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1500 g",
            max_item_length = "70 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
            transparent = true,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = { 1, 38 },
                coverage = 25,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
        },
    },
}

-- NO_I18N
-- skip encumbrance for additional parts of same body part
-- skip encumbrance for additional parts of same body part
ccb.content.define_item {
    id = "robofac_mantle",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("abstract mantle"),
    mass = "6853 g",
    volume = "6600 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_MANTLE", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 7,
        environmental_protection = 5,
        warmth = 15,
        portions = {
            { encumbrance = 5, coverage = 95, covers = { "torso" }, subparts = { "torso_upper" } },
            {
                encumbrance = 0,
                coverage = 60,
                vitals_coverage = 90,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
            {
                encumbrance = 2,
                coverage = 95,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                encumbrance = 0,
                coverage = 85,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
}

-- NO_I18N
-- skip encumbrance for additional parts of same body part
ccb.content.define_item {
    id = "robofac_skirt",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("abstract armored skirt"),
    mass = "2454 g",
    volume = "3500 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_SKIRT", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 7,
        environmental_protection = 5,
        warmth = 15,
        portions = {
            {
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                encumbrance = 0,
                coverage = 85,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "robofac_vambraces",
    abstract = true,
    category = "armor",
    name = ccb.content.plural_text("abstract armored vambraces (pair)", "abstract armored vambraces (pair)"),
    looks_like = "armguard_hard",
    mass = "845 g",
    volume = "4000 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "BLOCK_WHILE_WORN", "OUTER", "PADDED" },
    armor = {
        thickness = 5.25,
        environmental_protection = 5,
        warmth = 20,
        portions = {
            {
                encumbrance = 3,
                coverage = 95,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_elbow_r", "arm_lower_l", "arm_lower_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "robofac_greaves",
    abstract = true,
    category = "armor",
    name = ccb.content.plural_text("abstract armored greaves (pair)", "abstract armored greaves (pair)"),
    looks_like = "legguard_hard",
    mass = "1295 g",
    volume = "5000 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "OUTER", "PADDED" },
    armor = {
        thickness = 5.25,
        environmental_protection = 5,
        warmth = 20,
        portions = {
            {
                encumbrance = 3,
                coverage = 95,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_knee_l", "leg_knee_r", "leg_lower_l", "leg_lower_r" },
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "robofac_helmet",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("abstract helmet"),
    mass = "1176 g",
    volume = "1750 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_HELMET", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 7,
        environmental_protection = 5,
        warmth = 15,
        portions = { { coverage = 85, vitals_coverage = 95, covers = { "head" } } },
    },
}

-- Tier 1 mantle
ccb.content.define_item {
    id = "robofac_basic_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 prototype mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  Several buckles and straps allow it to be adjusted to fit you comfortably.  Despite its rough finish, it's clear that a lot of thought has gone into the ergonomics and weight.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 mantle
ccb.content.define_item {
    id = "robofac_rubber_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 kinetic mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  This model incorporates a rubber coating that diffuses impacts and provides excellent protection from blunt trauma, even if it does feel a bit like a rain coat.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 mantle
ccb.content.define_item {
    id = "robofac_nomex_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 turnout mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  This model features heat-resistant materials in the construction, providing protection from extreme heat without sacrificing its overall performance.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.356 } },
}

-- Tier 2 mantle
ccb.content.define_item {
    id = "robofac_kevlar_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 ballistic mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  Thanks to a slim under-layer of synthetic fibers, it provides fantastic defense from small-arms fire, and could take the edge off of a rifle bullet, too.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 mantle
ccb.content.define_item {
    id = "robofac_military_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 soldier mantle"),
    description = ccb.content.text("3D printed armor for the upper body, sporting a professional finish and stellar ergonomics.  Made of extremely tough UHMW polyethylene combined with treated aramid fabric, it provides military-grade defense against zombies, bullets, zombies with bullets, and plenty of other things that the Cataclysm can throw at you.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

-- Tier 1 skirt
ccb.content.define_item {
    id = "robofac_basic_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 prototype skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, consisting of a skirt made of segmented armor plates.  It features a simple integrated belt to let it fit any waist size.  Despite its rough finish, it's clear that a lot of thought has gone into the ergonomics and weight.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 skirt
ccb.content.define_item {
    id = "robofac_rubber_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 kinetic skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, consisting of a skirt made of segmented armor plates.  This model resembles scale armor, and provides excellent protection from blunt trauma.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 skirt
ccb.content.define_item {
    id = "robofac_nomex_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 turnout skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, consisting of a skirt made of segmented armor plates.  This version incorporates tight-fitting leggings that provide some protection from extreme heat.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.365 } },
}

-- Tier 2 skirt
ccb.content.define_item {
    id = "robofac_kevlar_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 ballistic skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, consisting of a skirt made of segmented armor plates.  It includes a reinforcing layer of aramid fabric in addition to leg sleeves made of high-strength material, protecting your sensitive bits from small-arms fire.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 skirt
ccb.content.define_item {
    id = "robofac_military_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 soldier skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, sporting a professional finish and stellar ergonomics.  Composed of segmented polyethylene armor plates featuring a dense metal core sandwiched between layers of composite-grade aramid fabric, it provides excellent protection for the upper legs to ensure that you'll stay on your feet when it really matters.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

-- Tier 1 vambraces
ccb.content.define_item {
    id = "robofac_basic_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 prototype vambraces (pair)", "Hub 01 prototype vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, made of large and flexible polymer sheets wrapped around the forearm.  The end of each sheet features a clip and drawstring, to fit the armor to any size.  Despite the rough finish, it fits securely, and feels quite comfortable."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 vambraces
ccb.content.define_item {
    id = "robofac_rubber_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 kinetic vambraces (pair)", "Hub 01 kinetic vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, made of large and flexible polymer sheets wrapped around the forearm.  These ones are built in an overlapping pattern that diffuses impacts and provides excellent protection from blunt trauma."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 vambraces
ccb.content.define_item {
    id = "robofac_nomex_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 turnout vambraces (pair)", "Hub 01 turnout vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, made of large and flexible polymer sheets wrapped around the forearm.  These ones include Nomex sleeves to protect your arms from extreme heat."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.365 } },
}

-- Tier 2 vambraces
ccb.content.define_item {
    id = "robofac_kevlar_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 ballistic vambraces (pair)", "Hub 01 ballistic vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, made of large and flexible polymer sheets wrapped around the forearm.  These ones include aramid arm sleeves that do a great job of slowing down bullets and preventing them from shredding your arms."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 vambraces
ccb.content.define_item {
    id = "robofac_military_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 soldier vambraces (pair)", "Hub 01 soldier vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, sporting a professional finish and stellar ergonomics.  With thick bullet-resistant arm sleeves, flexible but extremely tough thermoplastic plates, and special attention given to areas reflexively used to protect the face from attacks, it provides first-rate protection against all the horrors that the apocalypse has brought to bear."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

-- Tier 1 greaves
ccb.content.define_item {
    id = "robofac_basic_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 prototype greaves (pair)", "Hub 01 prototype greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, consisting of thick knee pads and a pair of large, flexible polymer plates for securing around the calves to protect the tibias of each leg.  Two straps on each plate can be tightened or loosened to fit different leg sizes.  Despite the rough finish, it doesn't impede your movement, and fits comfortably against your body."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 greaves
ccb.content.define_item {
    id = "robofac_rubber_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 kinetic greaves (pair)", "Hub 01 kinetic greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, consisting of thick knee pads and a pair of large, flexible polymer plates for securing around the calves to protect the tibias of each leg.  Thick padding and rubber lining provide excellent protection from blunt trauma."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 greaves
ccb.content.define_item {
    id = "robofac_nomex_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 turnout greaves (pair)", "Hub 01 turnout greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, consisting of thick knee pads and a pair of large, flexible polymer plates for securing around the calves to protect the tibias of each leg.  Heat-resistant leg sleeves and a breathable design provide adequate protection from extreme heat without sacrificing your mobility or core protection."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.365 } },
}

-- Tier 2 greaves
ccb.content.define_item {
    id = "robofac_kevlar_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 ballistic greaves (pair)", "Hub 01 ballistic greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, consisting of thick knee pads and a pair of large, flexible polymer plates for securing around the calves to protect the tibias of each leg.  This model features leggings made of durable aramid and a reinforced plate design; combined, they do a good job of mitigating damage from small-arms fire."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 greaves
ccb.content.define_item {
    id = "robofac_military_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 soldier greaves (pair)", "Hub 01 soldier greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, sporting a professional finish and stellar ergonomics.  Layered UHMW thermoplastic plates and bullet-resistant aramid padding combine to keep your lower leg bones protected and unbroken, even when knee-deep in the dead."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

-- Tier 1 helmet
ccb.content.define_item {
    id = "robofac_basic_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 prototype helmet"),
    description = ccb.content.text("3D printed armor for the head, made of thick polymer plates woven with metallic fibers.  Despite its rough finish, it's clear that a lot of thought has gone into the ergonomics and weight.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 helmet
ccb.content.define_item {
    id = "robofac_rubber_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 kinetic helmet"),
    description = ccb.content.text("3D printed armor for the head, made of thick polymer plates woven with metallic fibers.  This model is covered in countless rubber hexagons, and offers superior protection against blunt trauma.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 helmet
ccb.content.define_item {
    id = "robofac_nomex_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 turnout helmet"),
    description = ccb.content.text("3D printed armor for the head, made of thick polymer plates woven with metallic fibers.  This version incorporates a tight fitting Nomex layer for some protection against heat.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.365 } },
}

-- Tier 2 helmet
ccb.content.define_item {
    id = "robofac_kevlar_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 ballistic helmet"),
    description = ccb.content.text("3D printed armor for the head, made of thick polymer plates woven with metallic fibers.  This one has extra Kevlar and steel layering, to provide superior protection against small arms.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 helmet
ccb.content.define_item {
    id = "robofac_military_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 soldier helmet"),
    description = ccb.content.text("3D printed armor for the head, sporting a professional finish and stellar ergonomics.  Composed of a dense metal shell sandwiched between layers of composite-grade aramid fabric, it provides excellent protection, ensuring you'll keep your head against whatever the Cataclysm throws at you.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

ccb.content.define_item {
    id = "hub_meteorology_pack",
    name = ccb.content.text("Hub 01 hazardous meteorology pack"),
    description = ccb.content.text("A 3D printed pack frame for the true frontier explorer.  While this resembles a standard military or hiking pack frame, this one appears to be made entirely of lightweight plastics and artificial fabrics.  This cumbersome contraption eschews the modular nature of standard frame packs in favor of ergonomic, pre-fabricated attachment points.  The back of the frame is a thin, solid piece with a slot labeled \"SOLAR PANEL\".  The base of the frame has two custom-fit slots labeled \"UPS\" and \"WORKSTATION\".  Hanging from the bottom are two wide loops labeled \"TENT\" and \"ROLLMAT\".  The frame itself has several large clips, each labeled with \"HEW SYSTEM\" in small text.  The pack is secured by shoulder straps - the left shoulder strap proudly displays the Hub 01 logo, while the right strap has \"HE\" sewn in bright white letters."),
    mass = "1200 g",
    volume = "4500 ml",
    length = "70 cm",
    price = "400 USD",
    survival_price = "30 USD",
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "plastic", portions = 2 },
        { id = "nylon", portions = 1 },
    },
    symbol = "[",
    looks_like = "backpack",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            allowed_items = { "folding_solar_panel" },
            moves = 300,
            capacity = "7500 ml",
            mass_limit = "5800 g",
            max_item_length = "54 cm",
            description = ccb.content.text("Secured in a slot labeled \"SOLAR PANEL.\""),
        },
        {
            kind = "CONTAINER",
            allowed_items = {
                "mobile_weather_station",
                "xedra_mobile_weather_station",
                "robofac_mobile_weather_station",
            },
            capacity = "90000 ml",
            mass_limit = "6300 g",
            max_item_length = "61 cm",
            moves = 300,
            description = ccb.content.text("Attached to points labeled \"HEW SYSTEM.\""),
        },
        {
            kind = "CONTAINER",
            allowed_items = { "laptop" },
            capacity = "710 ml",
            mass_limit = "1330 g",
            max_item_length = "323 mm",
            moves = 300,
            description = ccb.content.text("Secured in a slot labeled \"WORKSTATION.\""),
        },
        {
            kind = "CONTAINER",
            allowed_items = { "UPS_off", "UPS_OFF", "UPS_ON" },
            capacity = "3100 ml",
            mass_limit = "1400 g",
            max_item_length = "15 cm",
            moves = 300,
            description = ccb.content.text("Secured in a slot labeled \"UPS.\""),
        },
        {
            kind = "CONTAINER",
            allowed_items = { "tent_kit" },
            moves = 300,
            capacity = "2600 ml",
            mass_limit = "1200 g",
            max_item_length = "91 cm",
            extra_encumbrance = 1,
            description = ccb.content.text("Secured under compression straps labeled \"TENT.\""),
            ripoff = 5,
            transparent = true,
        },
        {
            kind = "CONTAINER",
            allowed_items = { "rollmat" },
            moves = 300,
            capacity = "1100 ml",
            mass_limit = "300 g",
            max_item_length = "11 cm",
            extra_encumbrance = 1,
            description = ccb.content.text("Secured under compression straps labeled \"ROLLMAT.\""),
            ripoff = 5,
            transparent = true,
        },
    },
    flags = { "BELTED", "WATERPROOF" },
    armor = {
        warmth = 8,
        thickness = 2,
        portions = {
            {
                encumbrance = { 10, 30 },
                coverage = 95,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- made of metallized polyethylene terephthalate, or MPET, so basically an emergency blanket
ccb.content.define_item {
    id = "robofac_poncho_liner",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.text("Hub 01 MPET poncho liner"),
    description = ccb.content.text("Often called a \"woobie\" by soldiers, this sleeping bag-like poncho liner can be attached under a poncho or used as a blanket.  This one is made of space-age metallized polyethylene terephthalate, or MPET, the same reflective material used on spacecraft, spacesuits, emergency blankets, and mundane food packaging.  The Hub 01 logo is stamped on one corner.  It folds into a very compact form when not in use."),
    price = "50 USD",
    survival_price = "50 cent",
    materials = { { id = "plastic", portions = 99 }, { id = "aluminum", portions = 1 } },
    mass = "50 g",
    volume = "200 ml",
    flags = { "OVERSIZE", "BELTED" },
    armor = {
        warmth = 10,
        environmental_protection = 4,
        thickness = 0.01,
        portions = {
            {
                encumbrance = 3,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
            },
            {
                encumbrance = 3,
                covers = { "arm_l", "arm_r" },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                    "arm_upper_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                },
                coverage = 100,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 90,
            },
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "robofac_lens_helmet_on",
    copy_from = "robofac_lens_helmet",
    name = ccb.content.plural_text("Hub 01 LENS helmet (on)", "Hub 01 LENS helmet (on)"),
    flags = {
        "OVERSIZE", "STURDY", "WATERPROOF", "SUN_GLASSES", "PADDED", "MODULE_HOLDER", "CAN_USE_IN_DARK",
        "MUNDANE", "ELECTRONIC", "RAINPROOF", "SPAWN_ACTIVE", "ZOOM", "THERMOMETER", "HYGROMETER",
        "BAROMETER", "TWO_WAY_RADIO", "WATCH", "ALARMCLOCK", "PARTIAL_DEAF", "FIX_NEARSIGHT",
        "FIX_FARSIGHT", "FLASH_PROTECTION", "SWIM_GOGGLES", "NO_TAKEOFF", "ROBOFAC_LENS_HELMET",
    },
    revert_to = "robofac_lens_helmet",
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "1 W" },
    armor = {
        environmental_protection = 16,
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 0 },
        },
    },
    artifact = { enchantments = { "nvg_great", "THERMAL_VISION_GOOD", "AR_targeting_system" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your LENS system and cybernetic HUD switch off, leaving you in darkness."),
            target = "robofac_lens_helmet",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}

ccb.content.define_item {
    id = "robofac_lens_helmet",
    name = "Hub 01 LENS helmet",
    description = "The Low-latency ExoNeural Sensory helmet, also known as the LENS - headgear for the true frontier cyborg.  Somewhat resembling a sleek and reflective fighter pilot's helmet, this combat headgear completely shields the head, eyes, and ears, totally obscuring vision and deafening the wearer.  While the nose and mouth are uncovered, the helmet is mounted with clips for accessory masks.  If powered by batteries and connected to a compatible LENS cybernetic implant, the user's nervous system can directly interface with external cameras dotting the headgear, providing a full field of view, and all of the benefits of more common consumer and military AR systems, including adaptive light correction, light amplification and thermal imaging, and an HUD equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  Activate it to toggle power.",
    symbol = "[",
    color = "dark_gray",
    category = "armor",
    looks_like = "tac_fullhelmet",
    mass = "1400 g",
    volume = "1200 ml",
    price = "400000 USD",
    survival_price = "450 USD",
    flags = {
        "OVERSIZE",
        "STURDY",
        "WATERPROOF",
        "SUN_GLASSES",
        "PADDED",
        "MODULE_HOLDER",
        "CAN_USE_IN_DARK",
        "MUNDANE",
        "ELECTRONIC",
        "RAINPROOF",
        "BLIND",
        "DEAF",
        "ROBOFAC_LENS_HELMET",
    },
    techniques = { "WBLOCK_1" },
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "medium_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
        },
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "1 TB",
            weight_multiplier = 0,
            rigid = true,
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    use_actions = { "CAMERA", "EBOOKSAVE", "E_FILE_DEVICE" },
    armor = {
        thickness = 7,
        warmth = 30,
        environmental_protection = 16,
        portions = {
            {
                covers = { "head" },
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
                coverage = 100,
            },
            {
                covers = { "eyes" },
                coverage = 100,
                rigid_only = true,
                encumbrance = 40,
            },
        },
    },
    tool = { charges_per_use = 1, ammo_types = "battery", transfer_rate = "30 MB" },
    artifact = {},
    subtype_order = { "armor", "tool", "artifact" },
}

ccb.content.define_item {
    id = "robofac_lens_helmet_pat",
    copy_from = "robofac_lens_helmet",
    name = "modified Hub 01 LENS helmet",
    description = "The Low-latency ExoNeural Sensory helmet, also known as the LENS - headgear for the true frontier cyborg.  Somewhat resembling a sleek and reflective fighter pilot's helmet, this combat headgear completely shields the head, eyes, and ears, totally obscuring vision and deafening the wearer.  While the nose and mouth are uncovered, the helmet is mounted with clips for accessory masks.  If powered by batteries and connected to a compatible LENS cybernetic implant, the user's nervous system can directly interface with external cameras dotting the headgear, providing a full field of view, and all of the benefits of more common consumer and military AR systems, including adaptive light correction, light amplification and thermal imaging, and an HUD equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  This one has custom software so you can communicate with your pal, Pat.  Activate it to toggle power.",
    category = "armor",
    use_actions = { "CAMERA", "EBOOKSAVE", "E_FILE_DEVICE" },
    armor = {},
    tool = {},
    artifact = {},
    subtype_order = { "armor", "tool", "artifact" },
}

ccb.content.define_item {
    id = "robofac_lens_helmet_pat_on",
    copy_from = "robofac_lens_helmet_on",
    name = ccb.content.plural_text("modified Hub 01 LENS helmet (on)", "modified Hub 01 LENS helmet (on)"),
    description = "The Low-latency ExoNeural Sensory helmet, also known as the LENS - headgear for the true frontier cyborg.  Somewhat resembling a sleek and reflective fighter pilot's helmet, this combat headgear completely shields the head, eyes, and ears, totally obscuring vision and deafening the wearer.  While the nose and mouth are uncovered, the helmet is mounted with clips for accessory masks.  If powered by batteries and connected to a compatible LENS cybernetic implant, the user's nervous system can directly interface with external cameras dotting the headgear, providing a full field of view, and all of the benefits of more common consumer and military AR systems, including adaptive light correction, light amplification and thermal imaging, and an HUD equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  This one has custom software so you can communicate with your pal, Pat.  You are currently connected to Pat's system.  Activate it to toggle power.",
    category = "armor",
    revert_to = "robofac_lens_helmet_pat",
    use_actions = {
        {
            kind = "transform",
            target = "robofac_lens_helmet_pat",
            ammo_scale = 0,
            message = "Your LENS system and cybernetic HUD switch off, leaving you in darkness.",
            menu_text = "Turn off",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
    armor = {},
    tool = {},
    artifact = {},
    subtype_order = { "armor", "tool", "artifact" },
}

ccb.content.define_item {
    id = "robofac_lens_mask_bal",
    category = "armor",
    name = ccb.content.text("Hub 01 LENS ballistic mask"),
    description = ccb.content.text("A ballistic mask with many tiny vents holes, designed to form a tight seal with a Hub 01 LENS helmet.  Warm and cumbersome, but very protective."),
    mass = "512 g",
    volume = "750 ml",
    price = "200 USD",
    survival_price = "45 USD 50 cent",
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    symbol = "[",
    looks_like = "mask_filter",
    color = "dark_gray",
    flags = { "WATERPROOF", "STURDY", "PADDED", "ROBOFAC_LENS_ACCESSORY" },
    armor = {
        thickness = 7,
        warmth = 30,
        environmental_protection = 1,
        portions = { { encumbrance = 20, coverage = 100, covers = { "mouth" } } },
    },
}

ccb.content.define_item {
    id = "robofac_lens_mask_filter",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 LENS filter mask", "Hub 01 LENS filter masks"),
    description = ccb.content.text("A ballistic mask with a built-in filter compartment, designed to form a tight seal with a Hub 01 LENS helmet.  Protects from smoke, dust, and other contaminants quite well.  It must be prepared before use."),
    mass = "512 g",
    volume = "750 ml",
    price = "200 USD",
    survival_price = "45 USD 50 cent",
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    symbol = "[",
    looks_like = "mask_filter",
    color = "dark_gray",
    flags = { "WATERPROOF", "STURDY", "PADDED", "SLEEP_IGNORE", "ROBOFAC_LENS_ACCESSORY" },
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
        thickness = 7,
        warmth = 35,
        portions = { { encumbrance = 25, coverage = 100, covers = { "mouth" } } },
        environmental_protection = 3,
        filtered_protection = 7,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "robofac_lens_mask_gas",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 LENS CBRN mask", "Hub 01 LENS CBRN masks"),
    description = ccb.content.text("A ballistic CBRN gas mask, designed to form a tight seal with a Hub 01 LENS helmet.  While it is warmer and harder to breath in than a standard or filtered LENS mask, if a filter canister's been screwed into the right-side filter port and the respirator's been prepared, it'll do an admirable job at preventing smoke, gas, and airborne contaminants from taking up residence in your organs.  It must be prepared before use."),
    mass = "512 g",
    volume = "750 ml",
    price = "200 USD",
    survival_price = "65 USD 50 cent",
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    symbol = "[",
    looks_like = "mask_filter",
    color = "dark_gray",
    flags = { "WATERPROOF", "STURDY", "PADDED", "SLEEP_IGNORE", "ROBOFAC_LENS_ACCESSORY" },
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
        thickness = 7,
        warmth = 40,
        portions = { { encumbrance = 30, coverage = 100, covers = { "mouth" } } },
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "robofac_lens_mask_papr",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 LENS PAPR mask", "Hub 01 LENS PAPR masks"),
    description = ccb.content.text("A ballistic powered air purifying respirator mask, designed to form a tight seal with a Hub 01 LENS helmet.  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  Like a standard gas mask it must be prepared before use; unlike a standard gas mask, or any other LENS mask, easy airflow keeps it relatively cool and comfortable.  However, it will only function to filter air when paired with an active PAPR blower unit."),
    mass = "512 g",
    volume = "750 ml",
    price = "200 USD",
    survival_price = "65 USD 50 cent",
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    symbol = "[",
    looks_like = "mask_filter",
    color = "dark_gray",
    flags = { "WATERPROOF", "STURDY", "PADDED", "SLEEP_IGNORE", "PAPR_MASK", "ROBOFAC_LENS_ACCESSORY" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        thickness = 7,
        warmth = 10,
        portions = { { encumbrance = 5, coverage = 100, covers = { "mouth" } } },
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "PAPR_MASK_ACTIVATE" },
    tick_actions = { "PAPR_MASK" },
}
