local ccb = require("ccb")

ccb.content.define_item {
    id = "mom_pulse_rifle_ammo",
    name = ccb.content.plural_text("LV429 pulse shot", "LV429 pulse shot"),
    description = ccb.content.text("A charge for the LV429."),
    mass = "1 g",
    volume = "1 ml",
    price = "1 USD 60 cent",
    survival_price = "8 USD",
    materials = { "superalloy", "steel" },
    symbol = "=",
    color = "red",
    stack_size = 1,
    ammunition = {
        count = 1,
        type = "mom_pulse_rifle_ammo",
        range = 40,
        dispersion = 0,
        recoil = 0,
        damage = { type = "psi_photokinetic_damage", amount = 55, penetration = 4 },
    },
}

ccb.content.define_item {
    id = "psionic_charge_power",
    category = "spare_parts",
    price = "10 USD",
    name = ccb.content.plural_text("matrix charge", "matrix charge"),
    symbol = "=",
    color = "white",
    description = ccb.content.text("Power charge for matrix technology."),
    flags = { "TRADER_AVOID", "ZERO_WEIGHT" },
    mass = "0 mg",
    volume = "0 ml",
    materials = { "nether_crystal" },
    ammunition = { type = "psionic_charge_power", count = 100 },
}

ccb.content.define_item {
    id = "noetic_charge_power",
    copy_from = "psionic_charge_power",
    name = ccb.content.plural_text("noetic energy", "noetic energy"),
    ammunition = { type = "noetic_charge_power" },
}

ccb.content.define_item {
    id = "exodii_exodii_stungun_mag",
    category = "tool_magazine",
    name = ccb.content.text("Onšut power pack"),
    description = ccb.content.text("A power pack for the Onšut §A.  After a catastrophic failure the Exodii stopped attempting to modify their Onšut §As to accept a more standardized power source and worked on adapting their charging stations to recharge the existing power packs, which they eventually managed."),
    mass = "50 g",
    volume = "17 ml",
    length = "20 mm",
    price = "101 cent",
    survival_price = "6 cent",
    materials = { { id = "plastic", portions = 9 }, { id = "nether_crystal", portions = 1 } },
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { psionic_charge_power = 36 } } },
    magazine = { ammunition = { "psionic_charge_power" }, capacity = 36 },
}
