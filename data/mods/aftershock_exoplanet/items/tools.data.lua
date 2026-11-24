local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_atomic_smartphone",
    name = ccb.content.plural_text("atomic smartphone", "atomic smartphones"),
    description = ccb.content.text("Never charge your phone again with the Rivtech atomic smartphone.  Rated for 10 million years of use, this cutting-edge gadget had been on public markets for less than a week when the Cataclysm hit, and their eye-watering price made them a rarity.  It includes an alarm clock, a high-resolution camera, and a bright flashlight."),
    mass = "300 g",
    volume = "50 ml",
    price = "2 kUSD",
    survival_price = "25 USD",
    materials = { "plastic", "aluminum" },
    looks_like = "cell_phone",
    symbol = ";",
    color = "light_green",
    flags = { "WATCH", "ALARMCLOCK", "NO_UNLOAD", "NO_RELOAD", "CALORIES_INTAKE" },
    pockets = {
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "1 TB",
        },
    },
    tool = { transfer_rate = "45 MB" },
    use_actions = {
        {
            kind = "transform",
            target = "afs_atomic_smartphone_flashlight",
            message = ccb.content.text("You activate the flashlight app."),
        },
        "CAMERA",
        {
            kind = "mp3",
            target = "afs_atomic_smartphone_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
    },
}

ccb.content.define_item {
    id = "afs_ipav_patch_kit",
    copy_from = "syringe",
    name = ccb.content.plural_text("IPAV patch kit", "IPAV patch kits"),
    description = ccb.content.text("A small applicator used to mend IPAV armor.  Official UICA doctrine dictates that IPAV armor is rated to survive a single combat encounter, and this kit is only to be used in emergency situations where resupply is not possible.  It contains a single dose of high density polymer gel that can be applied to damaged plates for temporary repair."),
    price = "400 USD",
    survival_price = "400 USD",
    tool = {},
}

ccb.content.define_item {
    id = "afs_motion_sensor",
    name = ccb.content.plural_text("motion scanner", "motion scanners"),
    description = ccb.content.text("A handheld motion scanner normally used for pest control within spaceships.  This model features an integrated screen to highlight the location of detected motion.  It must be activated to function."),
    mass = "680 g",
    volume = "650 ml",
    price = "6 kUSD",
    length = "20 cm",
    materials = { "plastic", "steel" },
    symbol = "(",
    color = "yellow",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "BELT_CLIP", "MUNDANE" },
    melee_damage = { bash = 6 },
    subtype_order = { "tool", "artifact" },
    tool = { charges_per_use = 1, ammo_types = { "battery" }, power_draw = "600 mW" },
    artifact = {
        enchantments = { "afs_motion_sensor_wield", "ITEM_ENCH_aftershock_exoplanet_afs_motion_sensor_1" },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Activate"),
            target = "afs_motion_sensor_on",
            need_charges = 1,
            message = ccb.content.text("The %s screen flashes on."),
        },
    },
}

ccb.content.define_item {
    id = "afs_atomic_smartphone_music",
    copy_from = "afs_atomic_smartphone",
    name = ccb.content.plural_text("atomic smartphone - music", "atomic smartphones - music"),
    description = ccb.content.text("This phone is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "afs_atomic_smartphone",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = {},
    use_actions = {
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "mp3",
            target = "afs_atomic_smartphone",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
    },
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "afs_wraitheon_smartphone",
    name = ccb.content.plural_text("Wraitheon executive's smartphone", "Wraitheon executive's smartphones"),
    copy_from = "afs_atomic_smartphone",
    description = ccb.content.text("Your custom crafted atomic smartphone.  Most notably a confidential executive-level override program allows you to remotely control most robots."),
    price = "200 kUSD",
    survival_price = "2 kUSD 500 USD",
    materials = { "superalloy", "aluminum" },
    pockets = {
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "1 TB",
        },
    },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            target = "afs_atomic_wraitheon_flashlight",
            message = ccb.content.text("You activate the flashlight app."),
        },
        "CAMERA",
        {
            kind = "mp3",
            target = "afs_atomic_wraitheon_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
        "ROBOTCONTROL",
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
    },
}

ccb.content.define_item {
    id = "afs_atomic_wraitheon_music",
    copy_from = "afs_wraitheon_smartphone",
    name = ccb.content.plural_text("Wraitheon executive's smartphone - music", "Wraitheon executive's smartphones - music"),
    description = ccb.content.text("This phone is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "afs_atomic_smartphone",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = {},
    use_actions = {
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "mp3",
            target = "afs_wraitheon_smartphone",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
    },
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "UPS_OFF",
    copy_from = "UPS_OFF",
    description = ccb.content.text("This is a unified power supply, or UPS.  It is a device developed jointly by military and scientific interests for use in combat and the field.  The UPS is designed to power armor and some guns, but drains batteries quickly.  It can be worn strapped to either leg for ease of access, and it's been waterproofed to protect the delicate electronics.  Has its own custom battery, rechargeable and with higher capacity, but not removable."),
    price = "1300 USD",
    survival_price = "1300 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1500 } } },
    flags = {
        "RECHARGE",
        "BELTED",
        "NO_UNLOAD",
        "NO_RELOAD",
        "FRAGILE",
        "OVERSIZE",
        "WATERPROOF",
        "IS_UPS",
    },
    materials = { "aluminum", "plastic" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 2,
                coverage = 13,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "UPS_ON",
    copy_from = "UPS_ON",
    description = ccb.content.text("This is a unified power supply, or UPS.  It is a device developed jointly by military and scientific interests for use in combat and the field.  The UPS is designed to power armor and some guns, but drains batteries quickly.  It can be worn strapped to either leg for ease of access, and it's been waterproofed to protect the delicate electronics.  Has its own custom battery, rechargeable and with higher capacity, but not removable."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1500 } } },
    flags = {
        "RECHARGE",
        "BELTED",
        "NO_UNLOAD",
        "NO_RELOAD",
        "FRAGILE",
        "OVERSIZE",
        "WATERPROOF",
        "IS_UPS",
    },
    materials = { "aluminum", "plastic" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 2,
                coverage = 13,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "afs_bionic_power_mod",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("cybernetic power port mod", "cybernetic power port mods"),
    description = ccb.content.text("This device replaces standard power connections and battery ports for electronic devices with a carefully-shaped port that hooks into bionic implants.  When applied, it will convert an item to run directly off of bionic power."),
    flags = { "USES_BIONIC_POWER", "NO_UNLOAD", "NO_RELOAD" },
    toolmod = { ammo_types = { "battery" } },
}

ccb.content.define_item {
    id = "vr_laptop",
    category = "tools",
    name = ccb.content.plural_text("portable virtual reality rig", "portable virtual reality rigs"),
    description = ccb.content.text("A portable virtual reality rig with glasses for the HUD and the computing functions wrapped around the torso.  When powered on it will provide an overlay on everything you experience."),
    symbol = ",",
    color = "dark_gray",
    materials = { "glass", "titanium" },
    copy_from = "sunglasses",
    flags = { "WATCH", "SKINTIGHT" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "1 TB",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 2, ammo_types = { "battery" } },
    armor = { portions = { { covers = { "eyes", "torso" } } } },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "PORTABLE_GAME",
        {
            kind = "transform",
            target = "vr_laptop_holosuite",
            message = ccb.content.text("The holosuite comes to life around you."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "vr_laptop_holosuite",
    copy_from = "vr_laptop",
    name = ccb.content.plural_text("VR rig - holosuite deployed", "VR rigs - holosuite deployed"),
    revert_to = "vr_laptop",
    flags = { "WATCH", "TRADER_AVOID", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "1 W" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_aftershock_exoplanet_vr_laptop_holosuite_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "vr_laptop",
            message = ccb.content.text("You power down the virtual overlay."),
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
        },
    },
}

ccb.content.define_item {
    id = "afs_shuttle_radiobeacon",
    name = "drone shuttle beacon",
    description = "A portable high-power radiobeacon.  Signals a drone shuttle from Port Augustmoon, which will make landfall in about 30 minutes and leave 4 hours later, whether you board it or not.  Single use, all expenses paid in advance, and non refundable.",
    symbol = ";",
    color = "yellow",
    category = "tools",
    mass = "340 g",
    volume = "1 L",
    price = "55 kUSD",
    survival_price = "55 kUSD",
    flags = { "NO_UNLOAD", "NO_RELOAD" },
    materials = { "plastic", "aluminum" },
    melee_damage = { bash = 6 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { afs_shuttle_beacon = 1 },
        },
    },
    accuracy = -1,
    tool = { ammo_types = "afs_shuttle_beacon" },
}

ccb.content.define_item {
    id = "syringe",
    name = ccb.content.plural_text("jet injector", "jet injectors"),
    description = ccb.content.text("A compact jet injector from a first aid kit.  A light based assistive injection system allows use without any medical training."),
    mass = "4240 mg",
    volume = "10ml",
    length = "10 cm",
    accuracy = { grip = "none", length = "hand", surface = "point", balance = "neutral" },
    price = "2 USD",
    survival_price = "2 USD",
    materials = { "plastic" },
    symbol = ",",
    color = "white",
    flags = { "FRAGILE_MELEE" },
    melee_damage = { stab = 1 },
    tool = {},
}

ccb.content.define_item {
    id = "afs_internal_battery_compartment",
    name = ccb.content.plural_text("high-voltage battery compartment", "high-voltage battery compartments"),
    description = ccb.content.text("A battery slot installed in your upper torso, designed to power bionic implants.  Compatible with the power cartridges used by laser weaponry."),
    volume = "750 ml",
    mass = "1 g",
    price = "0 cent",
    materials = { "plastic" },
    symbol = "(",
    color = "magenta",
    flags = {
        "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS",
        "BIONIC_FUEL_SOURCE", "SOFT", "TRADER_AVOID",
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "afs_cartridge", "afs_bootleg_cartridge", "afs_archeotech_cartridge" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {},
}

ccb.content.define_item {
    id = "nano_forge",
    name = "folded nanotech forge",
    description = "Matrioshka Fabritechnics created this portable nanotech forge for when expeditions are setting up a basecamp far from population centers.  Once deployed it can be used to craft ultratech marvels that otherwise are too minute for human crafting.",
    symbol = "u",
    color = "light_green",
    category = "tools",
    looks_like = "forge",
    mass = "8464 g",
    volume = "11356 ml",
    price = "50 USD",
    survival_price = "450 USD",
    flags = { "DURABLE_MELEE", "HEAVY_TOOL" },
    materials = { "superalloy" },
    melee_damage = { bash = 5 },
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { battery = 5000 },
        },
    },
    use_actions = {
        { kind = "deploy_furn", furn_type = "f_nano_forge" },
    },
    artifact = {
        charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true },
    },
}

ccb.content.define_item {
    id = "afs_cRTG",
    copy_from = "folding_solar_panel",
    name = "U-344 RTG",
    description = "A compact power source that employs the decay of transuranic elements to generate a small but constant amount of electricity and is commonly used in remote locations to power up equipment.  Must be integrated into a power grid before use.",
    symbol = "]",
    color = "light_green",
    mass = "17500 g",
    volume = "2 L",
    length = "30 cm",
    price = "5600 USD",
    survival_price = "5600 USD",
    materials = { "lead", "steel" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 1000 },
        },
    },
    use_actions = {
        { kind = "deploy_appliance", base = "afs_cRTG" },
    },
    artifact = {
        charge = { recharge_type = "periodic", interval = "5 m", regenerate_ammo = true },
    },
    inheritance = {
        add = {
            flags = { "RECHARGE", "NO_UNLOAD", "NO_RELOAD", "WATERPROOF", "LEAK_DAM", "RADIOACTIVE" },
        },
    },
}

-- Makes it look more sci-fi so it isn't out of place, not many actual changes otherwise.
ccb.content.define_item {
    id = "multi_cooker",
    copy_from = "multi_cooker",
    name = ccb.content.plural_text("micro-cooker", "micro-cookers"),
    description = ccb.content.text("A rugged kitchen in one tool, made for use within small spaceships or in the wilderness.  It can automatically prepare a variety of dishes while its owner focuses on other tasks."),
    mass = "5 kg",
    volume = "3 L",
    price = "1500 USD",
    survival_price = "1500 USD",
    accuracy = -3,
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "red",
    flags = { "ELECTRONIC", "ALLOWS_REMOTE_USE", "BELT_CLIP" },
    faults = { { group = "electronic_general" } },
    qualities = {
        { id = "COOK", level = 3 },
        { id = "BOIL", level = 2 },
        { id = "CONTAIN", level = 1 },
        { id = "HOTPLATE", level = 2 },
        { id = "CHEM", level = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "CONTAINER",
            watertight = true,
            rigid = true,
            capacity = "2 L",
            mass_limit = "4 kg",
            max_item_length = "35 cm",
            moves = 50,
        },
    },
    tool = { power_draw = "100 W", ammo_types = { "battery" } },
    use_actions = { "MULTICOOKER", { kind = "link_up", cable_length = 2, charge_rate = "1000 W" } },
    tick_actions = { "MULTICOOKER_TICK" },
}

ccb.content.define_item {
    id = "multi_cooker_filled",
    copy_from = "multi_cooker",
    name = ccb.content.plural_text("micro-cooker - cooking", "micro-cookers - cooking"),
    description = "This micro-cooker is currently cooking a dish.",
    tool = {},
    inheritance = {
        remove = {
            qualities = { "CONTAIN" },
        },
    },
}

ccb.content.define_item {
    id = "afs_survival_battery",
    copy_from = "storage_battery",
    name = ccb.content.plural_text("portable survival battery", "portable survival batteries"),
    description = "A storage battery fit for improvised shelters.",
    looks_like = "small_storage_battery",
    ascii_picture = "small_storage_battery",
    mass = "15 kg",
    volume = "5 L",
    price = "300 USD",
    survival_price = "300 USD",
    melee_damage = { bash = 7 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 10000 },
        },
    },
    use_actions = {
        { kind = "deploy_appliance", base = "afs_survival_battery" },
    },
    magazine = { capacity = 1000 },
}

ccb.content.define_item {
    id = "afs_atomic_headlamp",
    category = "clothing",
    symbol = "[",
    color = "blue",
    looks_like = "wearable_light_on",
    name = ccb.content.plural_text("atomic headlamp", "atomic headlamps"),
    description = ccb.content.text("A custom-made headlamp, salvaged from an atomic lamp.  While the weight on your head is light, you had to awkwardly find a way to carry the base of the lamp, which provided the actual power.  The base now proudly sits strapped to your back."),
    price = "40 USD",
    survival_price = "15 USD",
    materials = { "aluminum", "nylon" },
    flags = { "LEAK_DAM", "RADIOACTIVE", "OVERSIZE", "PADDED", "ALLOWS_NATURAL_ATTACKS", "SPAWN_ACTIVE" },
    light = 15,
    mass = "4 kg",
    volume = "1500 ml",
    melee_damage = { bash = 2 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2 } },
                encumbrance = 1,
                layers = { "BELTED" },
                coverage = 50,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                materials = { { id = "aluminum", coverage = 100, thickness = 5 } },
                encumbrance = 5,
                layers = { "NORMAL" },
                coverage = 50,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You close the headlamp's cover."),
            menu_text = ccb.content.text("Close cover"),
            target = "afs_atomic_headlamp_off",
        },
    },
}

ccb.content.define_item {
    id = "afs_atomic_headlamp_off",
    copy_from = "afs_atomic_headlamp",
    looks_like = "wearable_light",
    name = ccb.content.plural_text("atomic headlamp (covered)", "atomic headlamps (covered)"),
    description = ccb.content.text("A custom-made headlamp, salvaged from an atomic lamp.  While the weight on your head is light, you had to awkwardly find a way to carry the base of the lamp, which provided the actual power.  The base now proudly sits strapped to your back.  It is now covered, concealing the light."),
    flags = { "LEAK_DAM", "RADIOACTIVE", "OVERSIZE", "PADDED", "ALLOWS_NATURAL_ATTACKS" },
    light = 0,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You open the headlamp's cover."),
            menu_text = ccb.content.text("Open cover"),
            target = "afs_atomic_headlamp",
        },
    },
}
