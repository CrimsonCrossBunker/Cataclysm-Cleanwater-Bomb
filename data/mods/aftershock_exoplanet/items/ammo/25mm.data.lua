local ccb = require("ccb")

-- expensive illegal ammo
ccb.content.define_item {
    id = "afs_25mm_ball",
    name = ccb.content.plural_text("25mm Ball", "25mm Ball"),
    description = ccb.content.text("Standard issue UICA 25mm rounds, loading a single lead-core steel-jacketed projectile.  Suitable for general purpose and anti-personnel use, these are the most common 25mm rounds in circulation."),
    mass = "130 g",
    volume = "230 ml",
    price = "1350 USD",
    materials = { "superalloy", "powder", "lead" },
    symbol = "=",
    color = "pink",
    stack_size = 1,
    ammunition = {
        count = 15,
        type = "afs_25mm",
        casing = "afs_25_casing",
        range = 110,
        damage = { type = "bullet", amount = 80, penetration = 30 },
        dispersion = 15,
        recoil = 2200,
    },
}

ccb.content.define_item {
    id = "afs_25mm_shot",
    copy_from = "afs_25mm_ball",
    name = ccb.content.plural_text("25mm canister shot", "25mm canister shot"),
    description = ccb.content.text("A 25mm round with a canister shot load, deals devastating damage against lightly armored foes within mid to close range.  Relatively low tech and affordable when compared to other 25mm grenades, these are often fielded by frontier outfits due to their adequate performance in anti-drone and close quarters combat."),
    price = "80 USD",
    ammunition = {
        count = 15,
        type = "afs_25mm",
        range = 24,
        projectile_count = 15,
        damage = { type = "bullet", amount = 60 },
        shot_damage = { type = "bullet", amount = 16, penetration = 15 },
        dispersion = 75,
    },
}

-- expensive illegal ammo
ccb.content.define_item {
    id = "afs_25mm_frag",
    copy_from = "afs_25mm_ball",
    name = ccb.content.plural_text("25mm FRAG", "25mm FRAG"),
    description = ccb.content.text("Standard issue UICA 25mm rounds, each loading a plastic explosive charge within a frangible ceramic projectile."),
    price = "1350 USD",
    materials = { "steel", "powder", "ceramic" },
    symbol = "=",
    color = "pink",
    ammunition = {
        count = 15,
        type = "afs_25mm",
        range = 110,
        effects = { "FRAG_25mm" },
        damage = { type = "bullet", amount = 70, penetration = 15 },
        dispersion = 15,
    },
}

-- expensive illegal ammo
ccb.content.define_item {
    id = "afs_25mm_apfsds",
    copy_from = "afs_25mm_ball",
    name = ccb.content.plural_text("25mm APFSDS", "25mm APFSDS"),
    description = ccb.content.text("Standard issue UICA 25mm rounds, each concealing a finned tungsten-alloy kinetic penetrator within a biodegradable plastic sabot.  Designed to defeat modern personal and light-vehicle armor, these are illegal to own, and thus are seldomly seen outside of military armories."),
    price = "1350 USD",
    materials = { "superalloy", "powder", "plastic" },
    symbol = "=",
    color = "pink",
    ammunition = {
        count = 5,
        type = "afs_25mm",
        range = 110,
        damage = { type = "bullet", amount = 70, penetration = 45 },
        dispersion = 15,
    },
}

-- tiny guided rockets.
ccb.content.define_item {
    id = "afs_25mm_smart",
    name = ccb.content.plural_text("25mm SDART", "25mm SDART"),
    description = ccb.content.text("High precision 25mm microjet darts.  These low velocity rounds can adjust mid-flight to exploit weaknesses in the target's defenses."),
    mass = "42 g",
    volume = "60 ml",
    price = "55000 USD",
    materials = { "superalloy", "powder", "plastic" },
    symbol = "=",
    color = "pink",
    stack_size = 1,
    flags = { "CASELESS_ROUNDS" },
    ammunition = {
        count = 5,
        type = "afs_25mm_smart",
        range = 110,
        recoil = 100,
        damage = { type = "bullet", amount = 60, penetration = 30 },
        critical_multiplier = 10,
        dispersion = 0,
    },
}
