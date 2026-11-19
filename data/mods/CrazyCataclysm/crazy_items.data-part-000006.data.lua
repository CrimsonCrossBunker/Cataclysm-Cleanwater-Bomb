local ccb = require("ccb")

ccb.content.define_item {
    id = "party_rock",
    symbol = "*",
    color = "pink",
    name = ccb.content.text("party rock"),
    description = ccb.content.text("Party rock condensed into physical form.  This should be too much for any mere mortal to handle."),
    category = "spare_parts",
    materials = { "stone" },
    flags = { "TRADER_AVOID", "NPC_THROWN", "SLING_PROJECTILE" },
    mass = "657 g",
    volume = "250 ml",
    qualities = { { id = "HAMMER", level = 1 } },
    melee_damage = { bash = 7 },
    ammunition = {
        type = "rock",
        damage = { type = "bash", amount = 2 },
        range = 10,
        dispersion = 14,
        loudness = 0,
        effects = { "NON_FOULING", "RECOVER_80" },
    },
}

ccb.content.define_item {
    id = "akmag90",
    looks_like = "stanag30",
    name = ccb.content.text("AK 90-round magazine"),
    description = ccb.content.text("A homemade AK magazine made out of welding magazines together.  Looks really stupid, and doesn't work."),
    mass = "978 g",
    volume = "1137 ml",
    length = "675 mm",
    price = "2 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 90 } } },
    magazine = { ammunition = { "762" }, reload_time = 200, jam_multiplier = 1200 },
}

ccb.content.define_item {
    id = "aksemi",
    copy_from = "aksemi",
    name = ccb.content.text("AK-47 rifle"),
    description = ccb.content.text("Civilian-legal clones of the AK-47, with no ability to fire full-auto.  Despite lacking that ability, they're still reliable and useful rifles, even if much rarer ammo and magazine wise than the more common AR-15 platform."),
    variant_kind = "gun",
    variants = {
        {
            id = "aksemi_vska",
            name = ccb.content.text("Century Arms VSKA"),
            description = ccb.content.text("This one is a VSKA, manufactured in the USA by Century Arms."),
            weight = 16,
            append = true,
        },
        {
            id = "aksemi_wasr",
            name = ccb.content.text("Century Arms WASR-10"),
            description = ccb.content.text("This one is a WASR-10, imported by Century Arms."),
            weight = 8,
            append = true,
        },
        {
            id = "aksemi_zpap",
            name = ccb.content.text("Zastava ZPAP M70"),
            description = ccb.content.text("This one is a ZPAP M70, imported by Zastava."),
            weight = 5,
            append = true,
        },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag30", "akmag10", "akmag20", "akmag40", "akmag90", "akdrum75" },
        },
    },
    gun = {},
}

ccb.content.define_item {
    id = "ak47",
    copy_from = "ak47",
    name = ccb.content.text("AKM rifle"),
    description = ccb.content.text("One of the most recognizable assault rifles ever made, the AKM is renowned for its durability even under the worst conditions."),
    variant_kind = "gun",
    variants = {
        {
            id = "ak47",
            name = ccb.content.text("AKM"),
            description = ccb.content.text("Arguably the most mass-produced firearm ever made, the AKM has cemented itself in history, and a few country flags.  Designed after WW2, it was meant to replace the PPSh-41's role, but soon became the main infantry rifle.  While many believe it is a copy of the German StG-44, it more resembles an M1 Garand in operation.  Despite it's age, it still sees plenty of use in conflicts today."),
        },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag30", "akmag10", "akmag20", "akmag40", "akmag90", "akdrum75" },
        },
    },
    gun = {},
}

ccb.content.define_item {
    id = "mk47",
    copy_from = "mk47",
    name = ccb.content.text("American AK rifle"),
    description = ccb.content.text("The CMMG Mk47 Mutant is an American rifle, natively chambered for 7.62x39mm ammo.  Features a characteristic free-floating handguard, with a similar action mechanism to the AR-15, repurposed for the bigger, more potent ammo."),
    variant_kind = "gun",
    variants = {
        {
            id = "mk47",
            name = ccb.content.text("Mk47 Mutant rifle"),
            description = ccb.content.text("The CMMG Mk47 Mutant is an American rifle, natively chambered for 7.62x39mm ammo.  Features a characteristic free-floating handguard, with a similar action mechanism to the AR-15, repurposed for the bigger, more potent ammo."),
        },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag30", "akmag10", "akmag20", "akmag40", "akmag90", "akdrum75" },
        },
    },
    gun = {},
}
