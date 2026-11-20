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
