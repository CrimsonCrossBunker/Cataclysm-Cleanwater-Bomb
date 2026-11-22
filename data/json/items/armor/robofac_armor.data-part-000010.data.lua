local ccb = require("ccb")

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
