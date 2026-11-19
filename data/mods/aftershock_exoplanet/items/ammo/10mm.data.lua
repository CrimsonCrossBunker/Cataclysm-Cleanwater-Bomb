local ccb = require("ccb")

-- 10mm ammo is used exclusively in Light weapons.
ccb.content.define_item {
    id = "afs_10mm_caseless_FMJ",
    name = ccb.content.plural_text("10mm FMJ caseless", "10mm FMJ caseless"),
    description = ccb.content.text("Standardized 10mm ammunition with a brass jacketed projectile.  For as long as you can remember bullets like these have been used for military, law enforcement, and civilian use."),
    mass = "9 g",
    volume = "117 ml",
    price = "40 USD",
    materials = { "lead" },
    symbol = "=",
    color = "yellow",
    stack_size = 40,
    flags = { "CASELESS_ROUNDS" },
    ammunition = {
        count = 60,
        type = "afs_10mm",
        range = 14,
        damage = { type = "bullet", amount = 21, penetration = 15 },
        dispersion = 60,
        recoil = 650,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "afs_10mm_caseless_JHP",
    name = ccb.content.plural_text("10mm JHP caseless", "10mm JHP caseless"),
    description = ccb.content.text("Standardized 10mm ammunition with a hollow point projectile.  While they have inferior penetration to FMJ rounds, their expansion slightly increases stopping power against unarmed targets and reduces overpenetration."),
    mass = "7 g",
    volume = "115 ml",
    price = "40 USD",
    materials = { "lead" },
    symbol = "=",
    color = "yellow",
    stack_size = 40,
    flags = { "CASELESS_ROUNDS" },
    ammunition = {
        count = 40,
        type = "afs_10mm",
        range = 14,
        damage = { type = "bullet", amount = 31 },
        dispersion = 60,
        recoil = 600,
        effects = { "COOKOFF" },
    },
}

-- tiny guided rockets.
ccb.content.define_item {
    id = "afs_10mm_smart",
    name = ccb.content.plural_text("10mm SDART", "10mm SDART"),
    description = ccb.content.text("High precision 10mm microjet darts.  These low velocity rounds can adjust mid-flight to exploit weaknesses in the target's defenses."),
    mass = "7 g",
    volume = "115 ml",
    price = "840 USD ",
    materials = { "superalloy", "powder", "plastic" },
    symbol = "=",
    color = "pink",
    stack_size = 42,
    flags = { "CASELESS_ROUNDS" },
    ammunition = {
        count = 42,
        type = "afs_10mm_smart",
        range = 14,
        damage = { type = "bullet", amount = 20, penetration = 15 },
        dispersion = 0,
        recoil = 600,
        critical_multiplier = 4,
        effects = { "COOKOFF" },
    },
}
