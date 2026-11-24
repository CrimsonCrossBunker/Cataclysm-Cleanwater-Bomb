local ccb = require("ccb")

-- Use of %s not currently supported.
ccb.content.define_item {
    id = "airhorn",
    name = ccb.content.plural_text("compressed air horn", "compressed air horns"),
    description = ccb.content.text("A small can of compressed air attached to a plastic horn.  Pressing the button on top causes it to emit a loud honking sound."),
    mass = "467 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "plastic", "aluminum" },
    symbol = ";",
    color = "red",
    tool = { initial_charges = 50, max_charges = 50, charges_per_use = 1 },
    use_actions = {
        {
            kind = "manualnoise",
            moves = 100,
            volume = 110,
            sound_message = ccb.content.text("HOOOOONK!"),
            sound_id = "misc",
            sound_variant = "airhorn",
            message = ccb.content.text("You honk your airhorn."),
        },
    },
}

-- 8 oz canister of butane - 227g butane
ccb.content.define_item {
    id = "butane_can",
    name = ccb.content.plural_text("can of butane", "cans of butane"),
    description = ccb.content.text("A non-refillable can of butane with an adapter for refilling lighters.  It could be useful as a fuel, but also as a solvent or chemical reagent."),
    symbol = "!",
    color = "dark_gray",
    looks_like = "spray_can",
    mass = "364 g",
    volume = "500 ml",
    price = "15 USD",
    survival_price = "2 USD 50 cent",
    pockets = { { kind = "MAGAZINE", watertight = true, rigid = true, ammunition = { butane = 400 } } },
    materials = { "aluminum" },
    flags = { "NO_RELOAD", "GAS_TANK" },
    explode_in_fire = true,
    tool = { charges_per_use = 1 },
}

-- Use of %s not currently supported.
ccb.content.define_item {
    id = "horn_bicycle",
    category = "veh_parts",
    name = ccb.content.plural_text("bicycle horn", "bicycle horns"),
    description = ccb.content.text("A simple bulb horn found on many bicycles.  Activate it to honk.  Honk honk."),
    mass = "170 g",
    volume = "500 ml",
    price = "4 USD",
    survival_price = "10 cent",
    materials = { "plastic", "aluminum" },
    symbol = ";",
    color = "light_gray",
    tool = {},
    use_actions = {
        {
            kind = "manualnoise",
            moves = 100,
            volume = 15,
            sound_message = ccb.content.text("honk."),
            sound_id = "misc",
            sound_variant = "horn_bicycle",
            message = ccb.content.text("You honk the bicycle horn."),
        },
    },
}

ccb.content.define_item {
    id = "permanent_marker",
    name = ccb.content.plural_text("permanent marker", "permanent markers"),
    description = ccb.content.text("A King Size™ industrial-strength permanent marker, about halfway between a typical marker and a can of spray paint in size.  Activate it to write something down.  However, writing \"Elbereth\" probably won't help you."),
    mass = "28 g",
    volume = "50 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = ",",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", ammunition = { permanent_ink = 500 }, watertight = true, rigid = true } },
    flags = { "WRITE_MESSAGE", "NO_RELOAD", "NO_UNLOAD" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = true,
            material_restricted = false,
        },
    },
}

ccb.content.define_item {
    id = "pocketwatch",
    name = ccb.content.plural_text("pocket watch", "pocket watches"),
    description = ccb.content.text("An old-fashioned pocket watch.  Tells the time and looks good doing it.  Can also be disassembled into some useful parts."),
    mass = "65 g",
    volume = "25 ml",
    price = "250 USD",
    survival_price = "1 USD",
    materials = { "gold", "glass" },
    symbol = ",",
    color = "light_gray",
    flags = { "WATCH" },
    tool = {},
}

ccb.content.define_item {
    id = "survival_marker",
    name = ccb.content.plural_text("survival marker", "survival markers"),
    description = ccb.content.text("A sharpened piece of charcoal used as an improvised pencil.  Almost guaranteed to get your hands all covered in charcoal.  Activate it to write something down."),
    mass = "113 g",
    volume = "15 ml",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "charcoal" },
    symbol = ",",
    color = "dark_gray",
    flags = { "WRITE_MESSAGE" },
    tool = { initial_charges = 100, max_charges = 100, charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = true,
            material_restricted = false,
        },
    },
}

ccb.content.define_item {
    id = "spray_can",
    name = "spray can",
    description = "An aerosol spray can filled with paint.  Activate it to make graffiti on the floor.",
    symbol = ";",
    color = "light_gray",
    mass = "340 g",
    volume = "250 ml",
    length = "21 cm",
    price = "5 USD",
    survival_price = "10 cent",
    flags = { "WRITE_MESSAGE", "NO_RELOAD", "NO_UNLOAD" },
    materials = { "aluminum" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { aerosol_paint = 10 },
        },
    },
    use_actions = {
        "SPRAY_CAN",
        { kind = "paint_vehicle" },
    },
    tool = { charges_per_use = 1 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "tear_gas_payload_act",
    category = "weapons",
    name = ccb.content.text_without_extraction("active tear gas payload"),
    description = ccb.content.text_without_extraction("This is a dummy item used by tear gas hacks that just so happens to be counting down.  You should never see it outside of debug."),
    symbol = "*",
    color = "dark_gray",
    flags = { "TRADER_AVOID", "ZERO_WEIGHT", "SPAWN_ACTIVE" },
    tool = {},
    countdown_action = {
        kind = "explosion",
        field = "fd_tear_gas",
        field_radius = 3,
        field_minimum = 1,
        field_maximum = 3,
    },
}

ccb.content.define_item {
    id = "teleumbrella",
    category = "tools",
    name = ccb.content.plural_text("telescoping umbrella (collapsed)", "telescoping umbrellas (collapsed)"),
    description = ccb.content.text("A telescoping umbrella which has been collapsed down for easy storage.  May be used to keep dry when extended and wielded."),
    mass = "411 g",
    volume = "1500 ml",
    length = "25 cm",
    price = "120 USD",
    survival_price = "1 USD",
    materials = { "plastic", "aluminum" },
    symbol = ",",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "ALLOWS_NATURAL_ATTACKS", "BELT_CLIP", "BELTED", "FRAGILE", "OVERSIZE", "PADDED" },
    melee_damage = { bash = 3 },
    armor = {
        sided = true,
        warmth = 0,
        thickness = 1,
        portions = {
            {
                encumbrance = 25,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                materials = { { id = "plastic", coverage = 100, thickness = 1 } },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Extend"),
            target = "teleumbrella-extended",
            message = ccb.content.text("You open your umbrella."),
        },
    },
}

ccb.content.define_item {
    id = "whistle_multitool",
    category = "tools",
    name = ccb.content.plural_text("whistle multitool", "whistle multitools"),
    description = ccb.content.text("A cheap gadget combining a whistle, thermometer, magnifying glass, and compass."),
    mass = "7 g",
    volume = "25 ml",
    price = "2 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = ";",
    color = "dark_gray",
    flags = { "FIRESTARTER", "THERMOMETER" },
    tool = {},
    use_actions = {
        {
            kind = "manualnoise",
            moves = 100,
            volume = 100,
            sound_message = ccb.content.text("FWEEEET!"),
            sound_id = "misc",
            sound_variant = "whistle",
            message = ccb.content.text("You blow the whistle."),
        },
        "WEATHER_TOOL",
        { kind = "firestarter", moves = 1000, slow_moves = 25000, need_sunlight = true },
    },
}
