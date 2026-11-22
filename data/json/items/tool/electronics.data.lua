local ccb = require("ccb")

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
