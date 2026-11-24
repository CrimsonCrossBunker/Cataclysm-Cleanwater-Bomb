local ccb = require("ccb")

-- swappable, but proprietary 80g Li-Ion battery
ccb.content.define_item {
    id = "camera",
    copy_from = "abstract_camera",
    name = ccb.content.plural_text("camera", "cameras"),
    description = ccb.content.text("A point-and-shoot digital camera with a digital viewfinder, a backup 'iron-sight', and flash.  You can look at your photos on the digital screen, or transfer them with any standard electronic device."),
    mass = "907 g",
    volume = "250 ml",
    price = "200 USD",
    survival_price = "50 cent",
    symbol = ";",
    color = "yellow",
    pockets = {
        { kind = "MAGAZINE", rigid = true, ammunition = { battery = 50 } },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "32 GB",
        },
    },
    tool = {},
    use_actions = { "CAMERA", { kind = "link_up", cable_length = 3, charge_rate = "20 W" } },
}

-- swappable, but proprietary 160g Li-Ion battery
ccb.content.define_item {
    id = "camera_pro",
    copy_from = "abstract_camera",
    name = ccb.content.plural_text("professional camera", "professional cameras"),
    description = ccb.content.text("A 35 mm digital SLR (single-lens reflex) camera with optical and digital viewfinders, a zoom lens with auto-focus and stabilizer, and flash.  You can look at your photos on the digital screen or transfer them with any standard electronic device.  Before the Cataclysm, you could have taken professional-grade photos using this."),
    mass = "2268 g",
    volume = "1250 ml",
    price = "8 kUSD",
    survival_price = "1 USD",
    symbol = ";",
    color = "yellow",
    flags = { "NO_UNLOAD", "NO_RELOAD", "WATER_BREAK_ACTIVE", "ELECTRONIC", "CAMERA_PRO", "ALWAYS_TWOHAND" },
    faults = { { group = "electronic_general" } },
    pockets = {
        { kind = "MAGAZINE", rigid = true, ammunition = { battery = 100 } },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "64 GB",
        },
    },
    tool = {},
    use_actions = { "CAMERA", { kind = "link_up", cable_length = 3, charge_rate = "50 W" } },
}

-- obsolete; remove after 0.I
-- Based on https://www.amazon.com/dp/B015CH1PJU
ccb.content.define_item {
    id = "usb_drive",
    copy_from = "abstract_usb_drive",
    symbol = ",",
    color = "white",
    name = ccb.content.plural_text("USB drive", "USB drives"),
    description = ccb.content.text("A USB thumb drive.  Useful for holding electronic data."),
    price = "12 USD",
    survival_price = "10 cent",
    mass = "4536 mg",
    volume = "4 ml",
    length = "5 cm",
    pockets = {
        { kind = "SOFTWARE", capacity = "1 L", mass_limit = "1 kg" },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "128 GB",
        },
    },
    tool = {},
}

-- Based on https://www.amazon.com/Seagate-Portable-External-Hard-Drive/dp/B07CRG94G3
ccb.content.define_item {
    id = "portable_hard_drive",
    copy_from = "abstract_usb_drive",
    symbol = ",",
    color = "white",
    name = ccb.content.plural_text("portable hard drive", "portable hard drives"),
    description = ccb.content.text("A portable external hard drive, the best in affordable mass storage.  Useful for holding lots of electronic data."),
    price = "100 USD",
    survival_price = "50 cent",
    mass = "190 g",
    volume = "138 ml",
    length = "12 cm",
    pockets = {
        { kind = "SOFTWARE", capacity = "1 L", mass_limit = "1 kg" },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "2 TB",
        },
    },
    tool = {},
}

-- https://www.amazon.com/dp/B0D6Z664QC, battery is FRANGWAT01
ccb.content.define_item {
    id = "laptop",
    copy_from = "abstract_laptop",
    category = "tools",
    name = ccb.content.plural_text("laptop computer", "laptop computers"),
    description = ccb.content.text("A portable computer, a ubiquitous tool both before and after the cataclysm.  While you no longer have internet access, you still can load it with books and other useful software."),
    symbol = ",",
    color = "dark_gray",
    price = "1049 USD",
    survival_price = "2 USD 50 cent",
    mass = "1319 g",
    volume = "703 ml",
    length = "322 mm",
    pockets = {
        { kind = "MAGAZINE", rigid = true, ammunition = { battery = 200 } },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "1 TB",
        },
    },
    tool = {},
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "PORTABLE_GAME",
        {
            kind = "transform",
            target = "laptop_screen_lit",
            message = ccb.content.text("You light up the screen."),
            menu_text = ccb.content.text("Light up the screen"),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "link_up", cable_length = 5, charge_rate = "140 W" },
    },
}

-- Sony NWE394 Walkman
ccb.content.define_item {
    id = "mp3",
    name = ccb.content.plural_text("mp3 player (off)", "mp3 players (off)"),
    description = ccb.content.text("This battery-powered device is loaded up with someone's music collection.  Fortunately, there's lots of songs you like, and listening to it will raise your morale slightly.  Use it to turn it on."),
    mass = "40 g",
    volume = "36 ml",
    price = "40 USD",
    survival_price = "2 cent",
    materials = { { id = "aluminum", portions = 75 }, { id = "plastic", portions = 25 } },
    ascii_picture = "mp3",
    symbol = ";",
    color = "dark_gray",
    flags = { "NO_UNLOAD", "NO_RELOAD", "WATER_BREAK_ACTIVE", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 50 } } },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "mp3",
            target = "mp3_on",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
        { kind = "link_up", cable_length = 2, charge_rate = "5 W" },
    },
}

ccb.content.define_item {
    id = "mp3_on",
    copy_from = "mp3",
    name = ccb.content.plural_text("mp3 player (on)", "mp3 players (on)"),
    description = ccb.content.text("This mp3 player is turned on and playing some great tunes, raising your morale steadily while on your person.  It runs through batteries quickly; you can turn it off by using it.  It also obscures your hearing."),
    revert_to = "mp3",
    faults = { { group = "electronic_general" } },
    flags = { "NO_UNLOAD", "NO_RELOAD", "TRADER_AVOID", "WATER_BREAK", "ELECTRONIC", "SPAWN_ACTIVE" },
    tool = { power_draw = "1 W" },
    use_actions = {
        {
            kind = "mp3",
            target = "mp3",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
        { kind = "link_up", cable_length = 2, charge_rate = "5 W" },
    },
    tick_actions = { "MP3_ON" },
}

-- stats from samsung galaxy s24
ccb.content.define_item {
    id = "smart_phone",
    copy_from = "abstract_smart_phone",
    name = ccb.content.plural_text("smartphone", "smartphones"),
    description = ccb.content.text("A popular, fancy smartphone.  Capable of taking photos with its integrated camera and illuminating an area with its flashlight app, assuming it has enough charge.  The smartphone also has a clock app that includes an alarm and an app for tracking consumed calories.  Runs on a small, rechargeable power cell compatible with a Unified Power Supply."),
    mass = "233 g",
    volume = "111 ml",
    length = "15 cm",
    price = "1299 USD",
    survival_price = "1 USD",
    looks_like = "cell_phone",
    symbol = ";",
    color = "light_gray",
    faults = { { group = "electronic_general" } },
    pockets = {
        { kind = "MAGAZINE", rigid = true, ammunition = { battery = 56 } },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "256 GB",
        },
    },
    tool = {},
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        {
            kind = "mp3",
            target = "smartphone_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        {
            kind = "transform",
            target = "smart_phone_flashlight",
            message = ccb.content.text("You activate the flashlight app."),
            menu_text = ccb.content.text("Turn on flashlight"),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
}

ccb.content.define_item {
    id = "smartphone_music",
    copy_from = "smart_phone",
    name = ccb.content.plural_text("smartphone - music", "smartphones - music"),
    description = ccb.content.text("This phone is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "smart_phone",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = { power_draw = "300 mW" },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_phone",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "smart_phone_locked_flashlight",
    copy_from = "smart_phone_locked",
    name = ccb.content.plural_text("smartphone (locked) - Flashlight", "smartphones (locked) - Flashlight"),
    revert_to = "smart_phone_locked",
    light = 20,
    inheritance = { add = { flags = { "CHARGEDIM", "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = { power_draw = "1500 mW" },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "smart_phone_locked",
            message = ccb.content.text("You deactivate the flashlight app."),
            menu_text = ccb.content.text("Turn off flashlight"),
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
}

-- Intended as an inverter that attaches to a battery, therefore it's volume will expand based on the size of battery attached.
ccb.content.define_item {
    id = "UPS_ON",
    name = ccb.content.plural_text("UPS (on)", "UPSes (on)"),
    description = ccb.content.text("A unified power supply, or UPS.  It is a device developed jointly by military and scientific interests for use in combat and the field.  The UPS is designed to power tools, smartphones, armor, and some guns, but drains batteries quickly."),
    mass = "680 g",
    volume = "2500 ml",
    price = "2 kUSD 800 USD",
    survival_price = "15 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "uneven" },
    materials = { "aluminum", "plastic" },
    symbol = ";",
    color = "light_gray",
    flags = { "IS_UPS" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_plus_battery_cell",
        },
    },
    melee_damage = { bash = 8 },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "UPS_OFF",
            message = ccb.content.text("You turn off the %s."),
            menu_text = ccb.content.text("Turn off"),
        },
    },
}

-- Intended as an inverter that attaches to a battery, therefore it's volume will expand based on the size of battery attached.
ccb.content.define_item {
    id = "UPS_OFF",
    name = ccb.content.plural_text("UPS (off)", "UPSes (off)"),
    description = ccb.content.text("A unified power supply, or UPS.  It is a device developed jointly by military and scientific interests for use in combat and the field.  The UPS is designed to power tools, smartphones, armor, and some guns, but drains batteries quickly.  Use it to turn it on."),
    mass = "680 g",
    volume = "2500 ml",
    price = "2 kUSD 800 USD",
    survival_price = "15 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "uneven" },
    materials = { "aluminum", "plastic" },
    symbol = ";",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_plus_battery_cell",
        },
    },
    melee_damage = { bash = 8 },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "UPS_ON",
            message = ccb.content.text("You turn on the %s."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "gas_charger",
    name = ccb.content.plural_text("gas-powered UPS (off)", "gas-powered UPSes (off)"),
    description = ccb.content.text("A compact thermoelectric generator.  Burns propane gas to charge UPS devices.  Use it to turn it on."),
    mass = "680 g",
    volume = "2500 ml",
    price = "2 kUSD 800 USD",
    survival_price = "15 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "uneven" },
    materials = { "aluminum", "plastic" },
    symbol = ";",
    color = "light_gray",
    flags = { "IS_UPS", "ALLOWS_REMOTE_USE" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GAS_TANK" },
            default_magazine = "small_propane_tank",
        },
    },
    melee_damage = { bash = 8 },
    tool = { charges_per_use = 1, ammo_types = { "propane" } },
    use_actions = {
        {
            kind = "transform",
            target = "gas_charger_on",
            message = ccb.content.text("You turn on the %s."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The charger's tank is empty."),
        },
    },
}

ccb.content.define_item {
    id = "gas_charger_on",
    copy_from = "gas_charger",
    name = ccb.content.plural_text("gas-powered UPS (on)", "gas-powered UPSes (on)"),
    description = ccb.content.text("A compact thermoelectric generator.  When connected to a propane tank, it will slowly charge UPS-compatible devices."),
    revert_to = "gas_charger",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = { power_draw = "60 mW", fuel_efficiency = 0.3 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "gas_charger",
            message = ccb.content.text("The charger is extinguished."),
            menu_text = ccb.content.text("Turn off"),
        },
    },
}

-- I estimate this thing is about 130 decibels.  Commercial amps can hit similar noise levels at a 100-200w of power input, the survivor's is less efficient.
ccb.content.define_item {
    id = "noise_emitter_super",
    name = ccb.content.plural_text("super noise emitter (off)", "super noise emitters (off)"),
    description = ccb.content.text("This is a noisemaker that has been further enhanced with a series of amplifiers.  It's about as loud something can get without making you vomit from sound-induced nausea, and it's as sure to attract every zombie in town as it is to give you permanent hearing damage."),
    mass = "6 kg",
    volume = "4 L",
    length = "30 cm",
    price = "0 cent",
    survival_price = "90 cent",
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "plastic", "aluminum", "steel" },
    symbol = ";",
    color = "yellow",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "WATER_BREAK" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    melee_damage = { bash = 6 },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            target = "noise_emitter_super_on",
            message = ccb.content.text("You turn on the %s."),
        },
    },
}

ccb.content.define_item {
    id = "exodii_wrist_computer",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("Exodii wrist computer", "Exodii wrist computers"),
    description = ccb.content.text("A small device that resembles a wrist-mounted industrial computer.  It's operated with a pressure-activated resistance touchscreen, made annoyingly difficult to use by its thick plastic screen protector.  The alien glyphs on the analog screen mean nothing to you.  Thankfully, Rubik showed you how to use the two-way radio and the \"wobble door scanner\", which can locate entrances to so-called \"labyrinths\"."),
    price = "12 USD",
    survival_price = "10 USD",
    materials = { "plastic", "aluminum" },
    mass = "750 g",
    volume = "750 ml",
    faults = { { group = "electronic_general" } },
    flags = {
        "BELTED", "FRAGILE", "ALLOWS_NATURAL_ATTACKS", "OVERSIZE", "NO_UNLOAD", "WATER_BREAK",
        "ELECTRONIC", "TWO_WAY_RADIO", "TRADER_AVOID",
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 734 } } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        sided = true,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 10,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = {
        { kind = "link_up", cable_length = 3, charge_rate = "5 W" },
        {
            kind = "transform",
            message = ccb.content.text("You tap the computer screen and switch on the scanner."),
            target = "exodii_wrist_computer_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "exodii_wrist_computer_on",
    copy_from = "exodii_wrist_computer",
    name = ccb.content.plural_text("Exodii wrist computer (on)", "Exodii wrist computers (on)"),
    looks_like = "exodii_wrist_computer",
    revert_to = "exodii_wrist_computer",
    flags = {
        "BELTED",
        "FRAGILE",
        "ALLOWS_NATURAL_ATTACKS",
        "OVERSIZE",
        "NO_UNLOAD",
        "WATER_BREAK",
        "ELECTRONIC",
        "TWO_WAY_RADIO",
        "TRADER_AVOID",
        "SPAWN_ACTIVE",
    },
    use_actions = {
        { kind = "link_up", charge_rate = "5 W", cable_length = 3 },
        {
            kind = "transform",
            target = "exodii_wrist_computer",
            ammo_scale = 0,
            message = "You tap the computer screen and switch off the scanner.",
            menu_text = "Turn off",
        },
    },
    tool = { turns_per_charge = 360 },
    armor = {},
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "smart_phone_locked",
    copy_from = "smart_phone",
    name = ccb.content.plural_text("smartphone (locked)", "smartphones (locked)"),
    description = "A popular, fancy smartphone.  Sadly for you, its previous user used its security features, rendering you unable to use most of its qualities.  You are still able to check the time and use a flashlight.  Runs on a small, rechargeable power cell compatible with a Unified Power Supply.",
    e_port = "",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 56 },
        },
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "256 GB",
            weight_multiplier = 0.0,
            rigid = true,
            forbidden = true,
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    use_actions = {
        {
            kind = "transform",
            target = "smart_phone_locked_flashlight",
            need_charges = 1,
            message = "You activate the flashlight app.",
            menu_text = "Turn on flashlight",
            need_charges_message = "The batteries are dead.",
        },
        { kind = "link_up", charge_rate = "20 W", cable_length = 3 },
    },
    tool = { transfer_rate = "0 MB" },
}

ccb.content.define_item {
    id = "abstract_camera",
    abstract = true,
    name = "camera",
    e_port = "camera",
    flags = { "NO_UNLOAD", "NO_RELOAD", "WATER_BREAK_ACTIVE", "ELECTRONIC" },
    materials = { "plastic", "steel" },
    melee_damage = { bash = 1 },
    variables = { browsed = "true" },
    faults = {
        { group = "electronic_general" },
    },
    tool = {
        charges_per_use = 1,
        transfer_rate = "20 MB",
        ammo_types = { "battery" },
    },
}

ccb.content.define_item {
    id = "abstract_laptop",
    abstract = true,
    name = "laptop",
    e_port = "laptop",
    flags = {
        "NO_UNLOAD",
        "NO_RELOAD",
        "WATCH",
        "WATER_BREAK",
        "ELECTRONIC",
        "ALLOWS_REMOTE_USE",
        "CAN_USE_IN_DARK",
    },
    materials = {
        { id = "aluminum", portions = 75 },
        { id = "plastic", portions = 25 },
    },
    melee_damage = { bash = 6 },
    faults = {
        { group = "electronic_general" },
    },
    tool = {
        charges_per_use = 1,
        transfer_rate = "30 MB",
        ammo_types = { "battery" },
    },
}

ccb.content.define_item {
    id = "abstract_smart_phone",
    abstract = true,
    name = "smartphone",
    e_port = "phone",
    flags = {
        "WATCH",
        "WATER_BREAK",
        "ELECTRONIC",
        "ALARMCLOCK",
        "CALORIES_INTAKE",
        "CAN_USE_IN_DARK",
        "USE_UPS",
        "NO_UNLOAD",
        "NO_RELOAD",
    },
    e_ports_banned = { "USB-A" },
    materials = {
        { id = "aluminum", portions = 75 },
        { id = "plastic", portions = 25 },
    },
    tool = {
        charges_per_use = 1,
        transfer_rate = "30 MB",
        ammo_types = { "battery" },
    },
}

ccb.content.define_item {
    id = "abstract_tablet",
    abstract = true,
    name = "e-ink tablet",
    e_port = "tablet",
    flags = { "NO_UNLOAD", "NO_RELOAD", "WATCH", "WATER_BREAK", "ELECTRONIC" },
    e_ports_banned = { "USB-A" },
    variables = { browsed = "false" },
    faults = {
        { group = "electronic_general" },
    },
    tool = {
        charges_per_use = 1,
        transfer_rate = "30 MB",
        ammo_types = { "battery" },
    },
}

ccb.content.define_item {
    id = "abstract_usb_drive",
    abstract = true,
    name = "USB drive",
    e_port = "USB-A",
    materials = { "plastic", "aluminum" },
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "clumsy" },
    tool = { transfer_rate = "20 MB" },
}

ccb.content.define_item {
    id = "abstract_memory_card",
    abstract = true,
    name = "memory card",
    looks_like = "mobile_memory_card",
    ascii_picture = "memory_card",
    mass = "1 g",
    volume = "1 ml",
    e_port = "memory card",
    flags = { "MC_MOBILE" },
    materials = { "plastic" },
    tool = { transfer_rate = "12 MB" },
}
