local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_7.50mm_caseless",
    name = ccb.content.plural_text("7.50mm caseless", "7.50mm caseless"),
    description = ccb.content.text("An intermediate bullet with an acceptable all-round performance.  Due to their role as UICA's standard issue rifle cartridge, these are ubiquitous wherever Earth makes its presence be known."),
    mass = "12 g",
    volume = "194 ml",
    price = "70 USD 50 cent",
    materials = { "lead" },
    symbol = "=",
    color = "yellow",
    stack_size = 47,
    flags = { "CASELESS_ROUNDS" },
    ammunition = {
        count = 30,
        type = "afs_7.50mm",
        range = 36,
        damage = { type = "bullet", amount = 45, penetration = 15 },
        dispersion = 30,
        recoil = 1500,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "afs_7.50mm_ap_caseless",
    name = ccb.content.plural_text("7.50mm AP caseless", "7.50mm AP caseless"),
    description = ccb.content.text("Armor piercing 7.50mm ammunition with a tungsten carbide penetrator.  These rounds are designed to defeat body armor and other hard targets, but have reduced stopping power against unarmored targets."),
    mass = "12 g",
    volume = "194 ml",
    price = "94 USD 80 cent",
    materials = { "lead" },
    symbol = "=",
    color = "yellow",
    stack_size = 47,
    flags = { "CASELESS_ROUNDS" },
    ammunition = {
        count = 30,
        type = "afs_7.50mm",
        range = 36,
        damage = { type = "bullet", amount = 35, penetration = 30 },
        dispersion = 30,
        recoil = 1500,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "afs_7.50mm_rp",
    name = ccb.content.plural_text("7.50mm RP", "7.50mm RP"),
    description = ccb.content.text("Civilian-legal 7.50mm ammunition featuring a reduced propellant case and unjacketed projectiles.  The 7.50mm RP round is extremely weak with very low stopping power, short range, and negligible recoil.  While cheaper than military grade rounds, it's only really useful for rifle training, and for hunting small animals."),
    mass = "3 g",
    volume = "65 ml",
    price = "1 USD 50 cent",
    materials = { "lead" },
    symbol = "=",
    color = "yellow",
    stack_size = 100,
    flags = { "CASELESS_ROUNDS" },
    ammunition = {
        count = 80,
        type = "afs_7.50mm",
        range = 13,
        damage = { type = "bullet", amount = 12 },
        dispersion = 60,
        recoil = 150,
        effects = { "COOKOFF" },
    },
}

-- tiny guided rockets.
ccb.content.define_item {
    id = "afs_7.50mm_smart",
    name = ccb.content.plural_text("7.50mm SDART", "7.50mm SDART"),
    description = ccb.content.text("High precision 7.50mm microjet darts for use in smart weaponry.  These low velocity rounds can adjust mid-flight to exploit weaknesses in the target's defenses."),
    mass = "18 g",
    volume = "14 ml",
    price = "875 USD",
    materials = { "superalloy", "powder", "plastic" },
    symbol = "=",
    color = "pink",
    stack_size = 1,
    flags = { "CASELESS_ROUNDS" },
    ammunition = {
        count = 80,
        type = "afs_7.50mm_smart",
        range = 20,
        recoil = 100,
        damage = { type = "bullet", amount = 35, penetration = 25 },
        critical_multiplier = 10,
        dispersion = 0,
    },
}
