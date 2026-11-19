local ccb = require("ccb")

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
