local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_recoil",
    category = "exosuit",
    name = ccb.content.plural_text("recoil mitigation system (off)", "recoil mitigation systems (off)"),
    description = ccb.content.text("This module takes partial control of the exosuit while firing, damping recoil.  Activate before firing."),
    mass = "500 g",
    volume = "500 ml",
    materials = { "qt_steel", "plastic" },
    symbol = "o",
    color = "white",
    flags = { "USE_UPS", "CANT_WEAR", "EXO_SMALL_GADGET" },
    max_worn = 1,
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    armor = {},
    artifact = { enchantments = { "afs_ench_exo_recoil" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your suit's recoil dampeners."),
            target = "exo_recoil_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("There is not enough charge to activate the module."),
        },
    },
}

ccb.content.define_item {
    id = "exo_bio_oxygen",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit air supply module", "exosuit air supply modules"),
    description = ccb.content.text("This is a SCBA, a self-contained breathing apparatus.  A series of tanks contain a tailored bacteria that processes Co2 back into breathable air over time."),
    mass = "2 kg",
    volume = "2500 ml",
    materials = { "plastic", "qt_steel" },
    symbol = "=",
    looks_like = "rebreather",
    color = "light_gray",
    flags = {
        "WATER_FRIENDLY",
        "CANT_WEAR",
        "STURDY",
        "NO_UNLOAD",
        "NO_RELOAD",
        "REBREATHER",
        "EXO_MEDIUM_GADGET",
    },
    max_worn = 1,
    pockets = {
        {
            kind = "MAGAZINE",
            airtight = true,
            rigid = true,
            watertight = true,
            ammunition = { oxygen = 120 },
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "oxygen" } },
    armor = { portions = { { encumbrance = 5, coverage = 100, covers = { "mouth" } } } },
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "30 s" } },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Activate"),
            message = ccb.content.text("You activate your %s."),
            target = "exo_bio_oxygen_on",
            need_charges_message = ccb.content.text("The %s's tank is exhausted."),
        },
    },
}

ccb.content.define_item {
    id = "exo_bio_oxygen_on",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit air supply module (on)", "exosuit air supply modules (on)"),
    description = ccb.content.text("This is a SCBA, a self-contained breathing apparatus.  A series of tanks contain a tailored bacteria that processes Co2 back into breathable air over time.  It is activated and will supply breathable air."),
    mass = "2 kg",
    volume = "2500 ml",
    materials = { "plastic", "qt_steel" },
    symbol = "=",
    looks_like = "rebreather",
    color = "light_gray",
    flags = {
        "WATER_FRIENDLY", "CANT_WEAR", "STURDY", "NO_UNLOAD", "NO_RELOAD", "REBREATHER",
        "EXO_MEDIUM_GADGET", "SPAWN_ACTIVE",
    },
    max_worn = 1,
    pockets = {
        {
            kind = "MAGAZINE",
            airtight = true,
            rigid = true,
            watertight = true,
            ammunition = { oxygen = 120 },
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { turns_per_charge = 30, ammo_types = { "oxygen" } },
    armor = {
        environmental_protection = 15,
        portions = { { encumbrance = 5, coverage = 100, covers = { "mouth" } } },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Deactivate"),
            message = ccb.content.text("You deactivate your %s."),
            target = "exo_bio_oxygen",
            need_charges_message = ccb.content.text("The %s's tank is exhausted."),
        },
    },
}

ccb.content.define_item {
    id = "exo_climb",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit climbing assist module", "exosuit climbing assist modules"),
    description = ccb.content.text("This module uses a combination of spikes, hooks, and magnets to aid the wearer in climbing."),
    mass = "5 kg",
    volume = "2500 ml",
    materials = { "plastic", "qt_steel" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "light_gray",
    flags = { "CANT_WEAR", "EXO_MEDIUM_GADGET" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        portions = {
            {
                encumbrance = 5,
                covers = { "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r", "foot_l", "foot_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_aftershock_exoplanet_exo_climb_0" } },
}

ccb.content.define_item {
    id = "exo_trickle_charger",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit microgenerator", "exosuit microgenerators"),
    description = ccb.content.text("This is a compact radioactive power unit that attaches to an exosuit hardpoint.  While it charges slowly, the fuel source will last years."),
    mass = "5 kg",
    volume = "2500 ml",
    materials = { "plastic", "qt_steel" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "light_gray",
    flags = {
        "FRAGILE",
        "CANT_WEAR",
        "WATERPROOF",
        "IS_UPS",
        "EXO_MEDIUM_GADGET",
        "LEAK_DAM",
        "RADIOACTIVE",
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "60 s" } },
}
