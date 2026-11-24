local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_electro_anomaly_rifle",
    copy_from = "laser_rifle",
    name = ccb.content.text("R-PROTON ENR"),
    description = ccb.content.text("Within the solid barrel of the Raaz PROTON, an electrical anomaly is carefully duplicated through magnetic stimulation and projected outwards.  Freed from containment, the anomaly will temporarily settle in the physical world and quickly emit its stored electrical charge before dissipating."),
    price = "200 kUSD",
    survival_price = "200 kUSD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "75 ml",
            allowed_items = { "afs_voltaic_cartridge" },
        },
    },
    flags = { "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE" },
    gun = {
        ammunition = { "battery" },
        ammo_per_shot = 0,
        energy_drain = "50 kJ",
        modes = { { id = "DEFAULT", label = ccb.content.text("pulse"), quantity = 1 } },
        damage = { { type = "electric", amount = 10 }, { type = "pure", amount = 25 } },
        effects = { "ELECTRO_ANOMALY" },
    },
}

-- High energy drain due to the damage dealt by the chain effect.
ccb.content.define_item {
    id = "afs_archangel_enr",
    copy_from = "laser_rifle",
    name = ccb.content.plural_text("W3310 Archangel ENR", "W3310 Archangel ENRs"),
    description = ccb.content.text("A powerful anti-drone defense weapon, the W3310 Archangel is capable of firing a chain of electrical discharges that can arc between multiple targets.  Most effective against groups of lightly armored foes, use within closed spaces is not recommended due to the risk of self-inflicted injury."),
    price = "22 kUSD",
    survival_price = "22 kUSD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "75 ml",
            allowed_items = { "afs_voltaic_cartridge" },
        },
    },
    flags = { "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE", "MUNDANE", "WONT_TRAIN_MARKSMANSHIP" },
    subtype_order = { "artifact", "gun" },
    artifact = { enchantments = { "ench_smart_gun" } },
    gun = {
        ammunition = { "battery" },
        ammo_per_shot = 0,
        mod_locations = { { id = ccb.content.text("sling"), count = 1 } },
        energy_drain = "70 kJ",
        modes = { { id = "DEFAULT", label = ccb.content.text("pulse"), quantity = 1 } },
        skill = ccb.content.text("smartgun", "gun_type_type"),
        range = 30,
        damage = { { type = "electric", amount = 15 } },
        effects = { "ELECTRIC_CHAIN" },
    },
}

ccb.content.define_item {
    id = "afs_voltaic_pistol",
    copy_from = "laser_rifle",
    name = ccb.content.plural_text("W3100 Volt", "W3100 Volts"),
    description = ccb.content.text("Wraitheon Armories' premier electrolaser personal defense weapon.  The W3100 Volt adjustable power settings make it adaptable to most conflict situations, lethal or otherwise, and make it a favorite among well-off security forces and law enforcement corps."),
    price = "12 kUSD",
    survival_price = "12 kUSD",
    mass = "780 g",
    volume = "480 ml",
    length = "205 mm",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "75 ml",
            allowed_items = { "afs_voltaic_cartridge" },
        },
    },
    flags = { "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE", "MUNDANE", "WONT_TRAIN_MARKSMANSHIP" },
    subtype_order = { "artifact", "gun" },
    artifact = { enchantments = { "ench_smart_gun" } },
    gun = {
        ammunition = { "battery" },
        ammo_per_shot = 0,
        energy_drain = "20 kJ",
        skill = ccb.content.text("smartgun", "gun_type_type"),
        range = 15,
        modes = { { id = "DEFAULT", label = ccb.content.text("pulse"), quantity = 1 } },
        damage = { { type = "electric", amount = 10 } },
        mod_locations = {
            { id = ccb.content.text("grip"), count = 1 },
            { id = ccb.content.text("rail"), count = 1 },
            { id = ccb.content.text("sights"), count = 1 },
            { id = ccb.content.text("stock"), count = 1 },
            { id = ccb.content.text("underbarrel"), count = 1 },
        },
        effects = { "BEANBAG" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "afs_mine_shocker",
    symbol = "%",
    color = "blue",
    name = ccb.content.text_without_extraction("mine shocker"),
    description = ccb.content.text_without_extraction("How shocking!"),
    materials = { "qt_steel" },
    flags = {
        "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR", "WATERPROOF_GUN", "NO_SALVAGE",
        "NO_UNLOAD", "NO_TURRET",
    },
    mass = "12 g",
    volume = "12 ml",
    length = "25 cm",
    accuracy = 1,
    melee_damage = { bash = 2 },
    gun = {
        skill = "pistol",
        effects = { "LIGHTNING" },
        damage = { type = "electric", amount = 4 },
        reload_noise_volume = 2,
        loudness = 2,
        range = 12,
        dispersion = 150,
        durability = 8,
    },
}
