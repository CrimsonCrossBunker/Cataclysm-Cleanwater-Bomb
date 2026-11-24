local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- Include ZERO_WEIGHT flag to avoid errors when instantiating pseudo items.
ccb.content.define_item {
    id = "fake_item",
    abstract = true,
    name = ccb.content.text_without_extraction("fake item"),
    description = ccb.content.text_without_extraction("Dummy item.  If you see this description, it is a bug."),
    flags = { "ZERO_WEIGHT", "TRADER_AVOID", "DEBUG_ONLY" },
    mass = "1 g",
    volume = "1 ml",
    symbol = "@",
    color = "red",
}

ccb.content.define_item {
    id = "internal_mp3_music",
    copy_from = "fake_item",
    name = ccb.content.plural_text("WearMan Music", "WearMan Musics"),
    description = ccb.content.text("A set of speakers implanted into your skull, that can receive local radiowaves and play downloaded music at a concert hall quality.  It is currently playing \"Rubik's Mickse\"."),
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "internal_mp3_radio",
    copy_from = "fake_item",
    name = ccb.content.plural_text("WearMan Radio", "WearMan Radios"),
    description = ccb.content.text("A set of speakers implanted into your skull, that can receive local radiowaves and play downloaded music at a concert hall quality.  It is currently listening to the radio."),
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = { "RADIO_ON" },
    tick_actions = { "RADIO_TICK" },
}

ccb.content.define_item {
    id = "integrated_pat_transponder_on",
    copy_from = "integrated_pat_transponder",
    name = ccb.content.plural_text("Infolink: Pat's Transponder (on)", "Infolink: Pat's Transponder (on)"),
    description = ccb.content.text("Custom software installed on your Infolink CBM for connecting to Pat's radio frequency.  If you have an integrated AR system CBM, or a compatible AR headset, this will put you in constant contact with Pat.  It is currently active.  Activate it to turn it off."),
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Disconnect from Pat's system and stop transmitting data"),
            message = ccb.content.text("You switch off the transponder."),
            target = "integrated_pat_transponder",
        },
    },
}

ccb.content.define_item {
    id = "integrated_nl_psyshield",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Cranial EMF Shielding", "Cranial EMF Shieldings"),
    description = ccb.content.text("Your skull is coated in a microscopically thin layer of some non-newtonian fluid.  It can protect you from some types of electromagnetic fields."),
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "PERSONAL",
        "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS",
        "PSYSHIELD_PARTIAL",
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "integrated_nl_dimensional_anchor",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Dimensional Anchor", "Dimensional Anchors"),
    description = ccb.content.text("Your body has been wired with advanced technology that locks you into your native dimensionality, protecting you from unwanted teleportation and some other phase altering effects.  It is currently active and draining bionic power."),
    flags = {
        "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS",
        "DIMENSIONAL_ANCHOR", "SPAWN_ACTIVE",
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "fake_appliance_tool",
    abstract = true,
    name = ccb.content.text_without_extraction("fake appliance tool"),
    copy_from = "fake_item",
    pockets = { { kind = "MAGAZINE_WELL" } },
    inheritance = { add = { flags = { "ALLOWS_REMOTE_USE", "PSEUDO" } } },
    tool = { ammo_types = { "battery" } },
}

ccb.content.define_item {
    id = "integrated_ar",
    copy_from = "fake_item",
    name = "Integrated AR System",
    description = "Extremely thin lenses provide user with augmented reality overlay allowing the user to zoom, and it displays handy information about local topology.",
    e_port = "phone",
    flags = {
        "ZOOM",
        "WATCH",
        "ALARMCLOCK",
        "SUN_GLASSES",
        "THERMOMETER",
        "INTEGRATED",
        "UNBREAKABLE",
        "PERSONAL",
        "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS",
        "USES_BIONIC_POWER",
    },
    materials = { "plastic" },
    variables = { browsed = "true" },
    pockets = {
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "2 TB",
            weight_multiplier = 0.0,
            rigid = true,
        },
    },
    use_actions = { "CAMERA", "PORTABLE_GAME", "EBOOKSAVE", "E_FILE_DEVICE" },
    tool = { charges_per_use = 1, transfer_rate = "140 MB" },
    armor = {},
    subtype_order = { "tool", "armor" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "pseudo_magazine",
    category = "spare_parts",
    name = ccb.content.text_without_extraction("pseudo magazine"),
    description = ccb.content.text_without_extraction("Pseudo magazine for use in dirty vehicle hacks."),
    flags = { "PSEUDO", "ZERO_WEIGHT", "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "DEBUG_ONLY" },
    pockets = {
        {
            kind = "MAGAZINE",
            airtight = true,
            watertight = true,
            rigid = true,
            ammunition = { battery = 1000000, propane = 1000000 },
        },
    },
    symbol = "@",
    color = "red",
    magazine = { ammunition = { "battery" }, capacity = 1000000 },
}

-- This is used exclusively in the rescue mission for Barry to blow a hole in the scout tower.
-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "fake_dynamite_50lbs",
    category = "weapons",
    name = ccb.content.text_without_extraction("fake 50lbs dynamite car bomb"),
    description = ccb.content.text_without_extraction("Several sticks of explosives, bundled together with a fuse attached.  Use this item to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  Shortly after lighting the fuse, this item will explode, so get away!"),
    mass = "22680 g",
    volume = "15020 ml",
    price = "60 USD",
    survival_price = "10 USD",
    materials = { { id = "tnt", portions = 95 }, { id = "paper", portions = 5 } },
    symbol = "*",
    color = "red",
    explode_in_fire = true,
    flags = { "BOMB" },
    melee_damage = { bash = 4 },
    tool = {},
    countdown_action = { kind = "explosion", blast = { power = 18779, max_noise = 0 } },
    countdown_interval = "1 seconds",
    blast = { power = 18779 },
}

ccb.content.define_item {
    id = "integrated_pat_radio",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Infolink: Call Pat", "Infolink: Call Pat"),
    description = "Custom software installed in your Infolink CBM for talking to Pat on your agreed-upon radio frequency.  Activate it to hail Pat.",
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS" },
    tool = {},
    armor = {},
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "integrated_pat_transponder",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Infolink: Pat's Transponder (off)", "Infolink: Pat's Transponder (off)"),
    description = "Custom software installed on your Infolink CBM for connecting to Pat's radio frequency.  If you have an integrated AR system CBM, or a compatible AR headset, activating this will put you in constant contact with Pat.  It is currently inactive.  Activate it to turn it on.",
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS" },
    use_actions = {
        {
            kind = "transform",
            target = "integrated_pat_transponder_on",
            message = "You switch on the transponder.",
            menu_text = "Connect to Pat's system and start transmitting data",
        },
    },
    tool = {},
    armor = {},
    subtype_order = { "tool", "armor" },
}
