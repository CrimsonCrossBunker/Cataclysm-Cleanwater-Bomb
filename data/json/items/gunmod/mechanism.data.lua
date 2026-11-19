local ccb = require("ccb")

ccb.content.define_item {
    id = "match_trigger",
    name = ccb.content.plural_text("match trigger", "match triggers"),
    description = ccb.content.text("A precision weighted trigger assembly that slightly improves a firearm's accuracy."),
    mass = "120 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "15 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = ":",
    color = "dark_gray",
    gunmod = {
        location = ccb.content.text("mechanism"),
        targets = {
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
        install_time = "30 m",
        dispersion_modifier = -1,
    },
    minimum_skills = { { id = "weapon", count = 4 }, { id = "mechanics", count = 3 }, { id = "gun", count = 2 } },
}

-- Install time short since it drops in, hinging open the AR being all the 'skill' necessary. Precision drop marginal since it'd change how semi and FA trigger pulls feel.
-- -1
ccb.content.define_item {
    id = "dias",
    name = ccb.content.plural_text("drop-in auto sear", "drop-in auto sears"),
    description = ccb.content.text("A vaguely 'U'-shaped piece of metal with a vaguely 'T'-shaped flapper on a pin.  Once tucked into an AR-15's lower receiver, the rifle will become selective fire-capable.  The handcrafted-sear surface isn't as good as actual full-auto parts, so precision and reliability suffer slightly."),
    mass = "113 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    integral_mass = "0 g",
    price = "650 USD",
    survival_price = "3 USD",
    materials = { "steel" },
    symbol = ":",
    color = "red",
    gunmod = {
        location = ccb.content.text("mechanism"),
        targets = {
            ccb.content.text("modular_ar15", "gun_type_type"),
            ccb.content.text("ar_pistol", "gun_type_type"),
            ccb.content.text("modular_ar_pistol", "gun_type_type"),
        },
        install_time = "5 m",
        dispersion_modifier = 10,
        modes = { { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 750 } },
    },
    minimum_skills = { { id = "rifle", count = 2 } },
}

-- Sort of long install time. Gotta grind down the carrier trip to SP1-ish length. Unfortunately, since you're sort of guessing how long that is, the AR's timing with this installed will be borked.(disco might be disengaged at non-ideal times).
-- -3
ccb.content.define_item {
    id = "llink",
    name = ccb.content.plural_text("lightning link", "lightning links"),
    description = ccb.content.text("Originally designed for the Colt SP-1, this 'reproduction' is intended to convert an AR-15 into a full-auto only rifle.  Once the necessary modifications are made and the link is in place, semi-auto is disabled and full-auto is enabled.  Reliability and precision suffer greatly due to questionable craftsmanship and lack of unobtainium SP-1 parts."),
    mass = "60 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    price = "240 USD",
    survival_price = "3 USD",
    materials = { "steel" },
    symbol = ":",
    color = "red",
    flags = { "CONSUMABLE" },
    gunmod = {
        location = ccb.content.text("mechanism"),
        targets = {
            ccb.content.text("modular_ar15", "gun_type_type"),
            ccb.content.text("ar_pistol", "gun_type_type"),
            ccb.content.text("modular_ar_pistol", "gun_type_type"),
        },
        install_time = "25 m",
        dispersion_modifier = 40,
        consume_chance = 300,
        consume_divisor = 110,
        modes = { { id = "DEFAULT", label = ccb.content.text("auto-rpm"), rpm = 750 } },
    },
    minimum_skills = { { id = "mechanics", count = 2 }, { id = "rifle", count = 3 } },
}

-- Install time should be short as it is simply a replacement back plate, installed by slightly more than field stripping the gun.
-- -1
ccb.content.define_item {
    id = "glocksear",
    name = ccb.content.plural_text("Glock auto sear plate", "Glock auto sear plates"),
    description = ccb.content.text("A relatively simple switch or button mechanism that replaces the back plate of a Glock slide, allowing it to function as a select-fire machine pistol.  A highly illegal modification, but the feds are zombie food anyway.  This will fit any standard Glock pistol in 9mm, .40, .45, 10mm, or .357 caliber."),
    mass = "55 g",
    volume = "20 ml",
    price = "95 USD",
    survival_price = "2 USD",
    materials = { "steel" },
    symbol = ":",
    color = "red",
    gunmod = {
        location = ccb.content.text("mechanism"),
        targets = {
            ccb.content.text("glock_19", "gun_type_type"),
            ccb.content.text("glock_17", "gun_type_type"),
            ccb.content.text("glock_22", "gun_type_type"),
            ccb.content.text("glock_31", "gun_type_type"),
            ccb.content.text("glock_21", "gun_type_type"),
            ccb.content.text("glock_20", "gun_type_type"),
            ccb.content.text("glock_29", "gun_type_type"),
            ccb.content.text("glock_40", "gun_type_type"),
        },
        install_time = "5 m",
        modes = { { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1200 } },
    },
    minimum_skills = { { id = "pistol", count = 2 } },
}

ccb.content.define_item {
    id = "bars",
    name = ccb.content.plural_text("balanced recoil system", "balanced recoil systems"),
    description = ccb.content.text("A complex set of parts designed to minimize recoil using a reciprocating counterweight."),
    mass = "60 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    price = "240 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = ":",
    color = "red",
    flags = { "IRREMOVABLE" },
    gunmod = {
        location = ccb.content.text("mechanism"),
        targets = { ccb.content.text("kord", "gun_type_type") },
        install_time = "15 m",
        handling_modifier = 15,
    },
    minimum_skills = { { id = "mechanics", count = 2 }, { id = "rifle", count = 3 } },
}

-- -3
ccb.content.define_item {
    id = "m249semi",
    name = ccb.content.plural_text("M249 select fire trigger", "M249 select fire triggers"),
    description = ccb.content.text("A trigger modification that allows the M249 to switch between semi and full automatic modes."),
    mass = "60 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    price = "240 USD",
    survival_price = "3 USD 50 cent",
    materials = { "steel" },
    symbol = ":",
    color = "red",
    flags = { "INSTALL_DIFFICULT", "CONSUMABLE" },
    gunmod = {
        location = ccb.content.text("mechanism"),
        targets = { ccb.content.text("m249", "gun_type_type") },
        install_time = "2 h",
        dispersion_modifier = 5,
        consume_chance = 50,
        consume_divisor = 110,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 850 },
        },
    },
    minimum_skills = { { id = "mechanics", count = 4 }, { id = "rifle", count = 5 } },
}

ccb.content.define_item {
    id = "condenser_pristine",
    name = ccb.content.plural_text("pristine condenser", "pristine condensers"),
    description = ccb.content.text("A condenser unit for the Caotel Sr2.2, seemingly in perfect condition."),
    mass = "380 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    price = "840 USD",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    flags = { "IRREMOVABLE" },
    gunmod = {
        install_time = "20 m",
        location = ccb.content.text("condenser"),
        targets = {
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
        },
        heat_per_shot_modifier = -5,
        cooling_multiplier = 3,
    },
    minimum_skills = { { id = "weapon", count = 4 }, { id = "electronics", count = 5 } },
}

-- -3
ccb.content.define_item {
    id = "m240semi",
    name = ccb.content.plural_text("M240 select fire trigger", "M240 select fire triggers"),
    description = ccb.content.text("A trigger modification that allows the M240 to switch between semi and full automatic modes."),
    mass = "60 g",
    volume = "250 ml",
    integral_volume = "0 ml",
    price = "240 USD",
    survival_price = "3 USD 50 cent",
    materials = { "steel" },
    symbol = ":",
    color = "red",
    flags = { "INSTALL_DIFFICULT", "CONSUMABLE" },
    gunmod = {
        location = ccb.content.text("mechanism"),
        targets = { ccb.content.text("m240", "gun_type_type") },
        install_time = "2 h",
        dispersion_modifier = 5,
        consume_chance = 50,
        consume_divisor = 110,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 650 },
        },
    },
    minimum_skills = { { id = "mechanics", count = 4 }, { id = "rifle", count = 5 } },
}
