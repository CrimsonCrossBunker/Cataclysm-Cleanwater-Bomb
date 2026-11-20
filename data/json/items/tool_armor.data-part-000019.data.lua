local ccb = require("ccb")

ccb.content.define_item {
    id = "goggles_ir_on",
    copy_from = "goggles_ir",
    name = ccb.content.plural_text("infrared goggles (on)", "infrared goggles (on)"),
    description = ccb.content.text("A pair of battery-powered goggles that grant infrared vision, allowing you to see warm-blooded creatures in the dark.  Use it to turn them off."),
    materials = { "plastic", "steel" },
    faults = { { group = "electronic_general" } },
    revert_to = "goggles_ir",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "1 W" },
    armor = {
        warmth = 15,
        portions = { { encumbrance = 20, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "goggles_ir",
        },
    },
}

ccb.content.define_item {
    id = "wearable_rx12",
    category = "clothing",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("wearable RX12 jet injector", "wearable RX12 jet injectors"),
    description = ccb.content.text("A modified RX12 jet injector which can be worn on the body.  A label on the side warns against using more than two doses per hour."),
    price = "400 USD",
    survival_price = "10 USD",
    materials = { "ceramic", "superalloy" },
    flags = { "OVERSIZE" },
    mass = "364 g",
    volume = "750 ml",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ampoule = 2 } } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1 },
    armor = { thickness = 3 },
    use_actions = { "JET_INJECTOR" },
}

ccb.content.define_item {
    id = "rx11_stimpack",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("RX11 stimulant delivery system", "RX11 stimulant delivery system"),
    description = ccb.content.text("A Rivtech RX11 stimulant delivery system, a jet autoinjector system worn on the user's body.  A simple press of its activator injects powerful chemical stimulants into the bloodstream without using a needle."),
    price = "400 USD",
    survival_price = "10 USD",
    materials = { "superalloy", "kevlar_rigid" },
    flags = { "OVERSIZE" },
    mass = "212 g",
    volume = "750 ml",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { stimpack_ammo = 5 } } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "stimpack_ammo" },
    armor = { thickness = 3 },
    use_actions = { "STIMPACK" },
}

ccb.content.define_item {
    id = "mask_h20survivor",
    category = "armor",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("handmade divemask", "handmade divemasks"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  Use it to turn it on."),
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "SWIM_GOGGLES" },
    price = "400 USD",
    survival_price = "20 USD",
    materials = { "kevlar_layered", "plastic" },
    mass = "982 g",
    volume = "1500 ml",
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
        warmth = 15,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 3.0 },
                    { id = "neoprene", coverage = 25, thickness = 1.0 },
                },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = {
                    {
                        id = "kevlar_layered",
                        coverage = 100,
                        thickness = 1.1,
                        ignore_sheet_thickness = true,
                    },
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "aluminum", coverage = 75, thickness = 0.5 },
                    { id = "neoprene", coverage = 50, thickness = 1.0 },
                },
                covers = { "mouth" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 30,
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "mask_h20survivor_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivor_on",
    copy_from = "mask_h20survivor",
    name = ccb.content.plural_text("handmade divemask (on)", "handmade divemasks (on)"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "REBREATHER", "SWIM_GOGGLES", "SPAWN_ACTIVE" },
    revert_to = "mask_h20survivor",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = { environmental_protection = 16 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "mask_h20survivor",
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivorxl",
    copy_from = "mask_h20survivor",
    looks_like = "mask_h20survivor",
    name = ccb.content.plural_text("handmade divemask", "handmade divemasks"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  Use it to turn it on."),
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "SWIM_GOGGLES", "OVERSIZE", "PREFIX_XL" },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 1.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "mask_h20survivorxl_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivorxs",
    copy_from = "mask_h20survivor",
    looks_like = "mask_h20survivor",
    name = ccb.content.plural_text("handmade divemask", "handmade divemasks"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  Use it to turn it on."),
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "SWIM_GOGGLES", "UNDERSIZE", "PREFIX_XS" },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "mask_h20survivorxs_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivorxl_on",
    copy_from = "mask_h20survivorxl",
    name = ccb.content.plural_text("handmade divemask (on)", "handmade divemasks (on)"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes regardless of your state of mutation.  Provides excellent protection from harm as well providing breathing gas while underwater.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = {
        "VARSIZE", "STURDY", "WATER_FRIENDLY", "REBREATHER", "SWIM_GOGGLES", "OVERSIZE", "PREFIX_XL",
        "TRADER_AVOID", "SPAWN_ACTIVE",
    },
    revert_to = "mask_h20survivorxl",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = { environmental_protection = 16 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "mask_h20survivorxl",
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivorxs_on",
    copy_from = "mask_h20survivor",
    looks_like = "mask_h20survivor",
    name = ccb.content.plural_text("handmade divemask (on)", "handmade divemasks (on)"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  Use it to turn it on."),
    flags = {
        "VARSIZE", "STURDY", "WATER_FRIENDLY", "REBREATHER", "SWIM_GOGGLES", "UNDERSIZE", "PREFIX_XS",
        "TRADER_AVOID", "SPAWN_ACTIVE",
    },
    revert_to = "mask_h20survivorxs",
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = { environmental_protection = 16 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "mask_h20survivorxs",
        },
    },
}

ccb.content.define_item {
    id = "rad_monitor",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("radiation biomonitor", "radiation biomonitors"),
    description = ccb.content.text("A small, battery-powered biometric safety device worn on the wrist.  Activate to check your current level of radiation exposure."),
    price = "600 USD",
    survival_price = "10 USD",
    materials = { "plastic", "aluminum" },
    mass = "150 g",
    volume = "150 ml",
    flags = { "BELTED", "FRAGILE", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY", "OVERSIZE" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_minus_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        sided = true,
        thickness = 0.1,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = { "RADGLOVE" },
}

ccb.content.define_item {
    id = "hairpin",
    category = "clothing",
    symbol = "[",
    color = "brown",
    name = ccb.content.plural_text("hairpin", "hairpins"),
    description = ccb.content.text("A plain hairpin to keep your hair in place."),
    price = "4 cent",
    survival_price = "10 cent",
    materials = { "steel" },
    mass = "200 mg",
    volume = "1 ml",
    length = "45 mm",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "fc_hairpin",
    copy_from = "hairpin",
    color = "pink",
    name = ccb.content.plural_text("fancy hairpin", "fancy hairpins"),
    description = ccb.content.text("A pink hairpin with cute flower textures."),
    price = "10 USD",
    survival_price = "5 cent",
    materials = { "plastic" },
    mass = "100 mg",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "towel",
    symbol = ",",
    color = "cyan",
    name = ccb.content.plural_text("towel", "towels"),
    description = ccb.content.text("A large, fluffy towel.  It could be used to dry yourself.  Any person that can travel the length and breadth of the apocalypse, rough it, slum it, struggle against terrible odds, win through, and still know where their towel is, is clearly a force to be reckoned with."),
    price = "45 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    mass = "250 g",
    volume = "500 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 8,
        thickness = 0.3,
        portions = { { coverage = 50, covers = { "torso", "leg_l", "leg_r" } } },
    },
    use_actions = { "TOWEL" },
}

ccb.content.define_item {
    id = "towel_wet",
    symbol = ",",
    color = "blue",
    name = ccb.content.plural_text("towel", "towels"),
    description = ccb.content.text("A large, sopping wet towel.  If you wait a little bit, it should dry out.  Don't panic."),
    price = "20 USD",
    survival_price = "0 cent",
    materials = { "cotton", "water" },
    mass = "375 g",
    volume = "500 ml",
    revert_to = "towel",
    flags = { "WET", "SLEEP_IGNORE" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { thickness = 0.3, portions = { { coverage = 50, covers = { "torso", "leg_l", "leg_r" } } } },
    use_actions = { "TOWEL" },
}

ccb.content.define_item {
    id = "straw_fedora",
    category = "clothing",
    name = ccb.content.plural_text("straw fedora", "straw fedoras"),
    mass = "300 g",
    color = "light_gray",
    symbol = "[",
    description = ccb.content.text("A straw fedora hat, comfortable and stylish.  Its brim helps keep the sun out of your eyes."),
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "paper" },
    volume = "1250 ml",
    flags = { "VARSIZE", "SUN_GLASSES" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 5,
        environmental_protection = 1,
        thickness = 1,
        portions = { { encumbrance = 10, coverage = 100, covers = { "head" }, subparts = { "head_crown" } } },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Tip"),
            target = "straw_fedora",
            message = ccb.content.text("You tip your fedora."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_outfit",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("thermal electric outfit", "thermal electric outfits"),
    description = ccb.content.text("A suit of thin thermal underwear that covers you from head to toe and is equipped with internal battery-powered heating elements.  Use it to turn it on."),
    flags = { "VARSIZE", "SKINTIGHT", "WATER_BREAK" },
    price = "300 USD",
    survival_price = "7 USD 50 cent",
    materials = { "cotton" },
    mass = "2250 g",
    volume = "4500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            default_magazine = "heavy_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = {
            {
                coverage = 100,
                covers = {
                    "head",
                    "mouth",
                    "torso",
                    "arm_l",
                    "arm_r",
                    "leg_l",
                    "leg_r",
                    "hand_l",
                    "hand_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heating elements on."),
            target = "thermal_outfit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_outfit_on",
    copy_from = "thermal_outfit",
    name = ccb.content.plural_text("thermal electric outfit (on)", "thermal electric outfits (on)"),
    description = ccb.content.text("A suit of thin thermal underwear that covers you from head to toe and is equipped with internal battery-powered heating elements.  It is currently on, and continually draining batteries.  Use it to turn it off."),
    flags = { "VARSIZE", "SKINTIGHT", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "thermal_outfit",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "8 W" },
    armor = { warmth = 60 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the heating elements off."),
            target = "thermal_outfit",
        },
    },
}

ccb.content.define_item {
    id = "turtleneck",
    name = ccb.content.plural_text("turtleneck", "turtlenecks"),
    description = ccb.content.text("A tasteful wool turtleneck, modeled after cashmere.  Unencumbering and warm, but lacking storage."),
    category = "clothing",
    mass = "478 g",
    volume = "2500 ml",
    price = "50 USD",
    survival_price = "60 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "sweater",
    color = "white",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 30,
        thickness = 0.5,
        environmental_protection = 2,
        portions = {
            { encumbrance = 3, coverage = 100, covers = { "torso", "arm_l", "arm_r", "mouth" } },
            { encumbrance = 1, coverage = 100, covers = { "head" }, subparts = { "head_throat" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "turtleneck_rolled",
            menu_text = ccb.content.text("Roll neck"),
            message = ccb.content.text("You adjust the neck and collar of the turtleneck."),
        },
    },
}

ccb.content.define_item {
    id = "turtleneck_rolled",
    name = ccb.content.plural_text("turtleneck (rolled)", "turtlenecks (rolled)"),
    description = ccb.content.text("This wool turtleneck's neck is rolled out of the way of the mouth."),
    category = "clothing",
    mass = "478 g",
    volume = "2500 ml",
    price = "50 USD",
    survival_price = "60 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "sweater",
    color = "white",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 30,
        thickness = 0.5,
        environmental_protection = 2,
        portions = {
            { encumbrance = 3, coverage = 100, covers = { "torso", "arm_l", "arm_r" } },
            { encumbrance = 1, coverage = 100, covers = { "head" }, subparts = { "head_throat" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "turtleneck",
            menu_text = ccb.content.text("Unroll neck"),
            message = ccb.content.text("You adjust the neck and collar of the turtleneck."),
        },
    },
}

ccb.content.define_item {
    id = "turtleneck_shirt",
    name = ccb.content.plural_text("turtleneck shirt", "turtleneck shirts"),
    description = ccb.content.text("A tasteful cotton turtleneck shirt, thick for a shirt, thin for a sweater, and completely lacking storage."),
    category = "clothing",
    mass = "300 g",
    volume = "2000 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sweater",
    color = "white",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 20,
        thickness = 0.5,
        environmental_protection = 1,
        portions = {
            { encumbrance = 2, coverage = 100, covers = { "torso", "arm_l", "arm_r", "mouth" } },
            { encumbrance = 0, coverage = 100, covers = { "head" }, subparts = { "head_throat" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "turtleneck_shirt_rolled",
            menu_text = ccb.content.text("Roll neck"),
            message = ccb.content.text("You adjust the neck and collar of the turtleneck shirt."),
        },
    },
}

ccb.content.define_item {
    id = "turtleneck_shirt_rolled",
    name = ccb.content.plural_text("turtleneck shirt (rolled)", "turtleneck shirts (rolled)"),
    description = ccb.content.text("This turtleneck shirt's neck is rolled out of the way of the mouth."),
    category = "clothing",
    mass = "300 g",
    volume = "2000 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sweater",
    color = "white",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 20,
        thickness = 0.5,
        environmental_protection = 1,
        portions = {
            { encumbrance = 2, coverage = 100, covers = { "torso", "arm_l", "arm_r" } },
            { encumbrance = 0, coverage = 100, covers = { "head" }, subparts = { "head_throat" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "turtleneck_shirt",
            menu_text = ccb.content.text("Unroll neck"),
            message = ccb.content.text("You adjust the neck and collar of the turtleneck shirt."),
        },
    },
}

-- not forehead or nape
ccb.content.define_item {
    id = "mask_ski",
    name = ccb.content.plural_text("ski mask", "ski masks"),
    category = "clothing",
    mass = "86 g",
    color = "dark_gray",
    symbol = "[",
    description = ccb.content.text("A warm wool mask that protects the head and face from the cold.  It covers most of your head and mouth, and can be adjusted to hang around your throat instead."),
    price = "18 USD",
    survival_price = "2 USD 50 cent",
    materials = { "wool" },
    volume = "250 ml",
    flags = { "VARSIZE", "SKINTIGHT" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 25,
        thickness = 1,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 6,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_ear_r", "head_ear_l", "head_throat" },
            },
            {
                encumbrance = 10,
                coverage = 100,
                covers = { "mouth" },
                subparts = { "mouth_lips", "mouth_cheeks", "mouth_chin" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear as collar"),
            message = ccb.content.text("You adjust your ski mask for less warmth."),
            target = "mask_ski_loose",
        },
    },
}

ccb.content.define_item {
    id = "mask_ski_loose",
    name = ccb.content.plural_text("ski mask (collar)", "ski masks (collar)"),
    category = "clothing",
    mass = "86 g",
    color = "dark_gray",
    revert_to = "mask_ski",
    symbol = "[",
    description = ccb.content.text("A warm wool mask that protects the head and face from the cold.  It is wrapped around your throat, and can be adjusted to cover your mouth and more of your head."),
    price = "18 USD",
    survival_price = "2 USD 50 cent",
    materials = { "wool" },
    volume = "250 ml",
    flags = { "VARSIZE", "SKINTIGHT", "COLLAR" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 25,
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 4,
                coverage = 20,
                covers = { "head" },
                subparts = { "head_nape", "head_throat" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear around head"),
            message = ccb.content.text("You adjust your ski mask for more warmth."),
            target = "mask_ski",
        },
    },
}
