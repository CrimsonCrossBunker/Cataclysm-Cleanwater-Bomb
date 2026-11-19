local ccb = require("ccb")

-- Based off of the Riley Defense RAK74-C and RAK74-C-SF, respectively.
ccb.content.define_item {
    id = "ak74_semi",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("Russian AK rifle"),
    description = ccb.content.text("Flaunting classically iconic lines and a profile instantly recognizable to any viewer, this American semi-automatic weapon is a replica of the AK-47 rifle's technological descendant, the AK-74, a weapon with more notable differences from its elder sibling than simply flipping the order of its name's numbers.  Firing the rare, at least for the United States, 5.45x39mm Soviet cartridge, this clone makes use of original 5.45mm banana magazines.  Considering the scarcity of its munitions, you might be obliged to resort to hand-loading your own ammunition."),
    variant_kind = "gun",
    variants = {
        {
            id = "ak74_fixed",
            name = ccb.content.plural_text("Kalashnikov AK-74", "Kalashnikov AK-74 rifles"),
            description = ccb.content.text("A rifle of the Cold War, or at least a dead ringer for it, this weapon is a semi-automatic clone of the Soviet Union's standard assault rifle following 1974.  Either a locally-built replica or produced from an imported, foreign parts kit, fitted with a fixed wooden buttstock, a side-mounted optics rail, and a barrel threaded for suppressors, the rifle's chambered for the Russian 5.45x39mm cartridge and feeds from AK-74 magazines.  A Communist gun built in Capitalist America; bar hoofing it to eastern Europe, the weapon's likely the closest you'll ever get to laying your palms on a Russian Kalashnikov."),
        },
        {
            id = "ak74_folding",
            name = ccb.content.plural_text("Kalashnikov AKS-74", "Kalashnikov AKS-74 rifles"),
            description = ccb.content.text("An American copy of a Soviet assault rifle, a strange piece of ordinance using some weird proprietary Russian ammunition—all these terms and more can describe this rifle: a semi-automatic clone of the Kalashnikov AKS-74, the descendant of the iconic AKM.  Either a locally-built replica or produced from an imported, foreign parts kit, the firearm possesses a triangular, folding buttstock, a side-mounted optics rail, and a threaded barrel for attaching muzzle devices.  The weapon fires the Soviet 5.45x39mm cartridge—a unicorn even in the American gun wilderness—and feeds said unicorn ammunition from AK-74 magazines."),
        },
    },
    mass = "3400 g",
    volume = "2418 ml",
    length = "895 mm",
    price = "1 kUSD 115 USD",
    survival_price = "35 USD",
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "ak74mag", "rpk74mag", "casket74mag" } } },
    gun = {
        barrel_length = "413 mm",
        ammunition = { "545x39" },
        dispersion = 200,
        min_cycle_recoil = 1260,
        default_mods = { "offset_sight_rail" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
            { id = "muzzle", count = 1 },
        },
    },
}

-- An exceptionally new AK style gun found illicitly as part of a quest.
ccb.content.define_item {
    id = "kord",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("Kord AK rifle"),
    description = ccb.content.text("A special forces Russian rifle chambered in 5.45.  This version uses standard Picatinny rails, has modern lightweight furniture and a unique complex recoil balance system for high fire rate with minimal recoil.  It combines the reliability of the AK series with the high-velocity, lightweight 5.45x39mm cartridge and accepts standard AK-74M magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "kord",
            name = ccb.content.text("Kord 6P67 rifle"),
            description = ccb.content.text("A special forces Russian rifle chambered in 5.45.  This version uses standard Picatinny rails, has modern lightweight furniture and a unique complex recoil balance system for high fire rate with minimal recoil.  It combines the reliability of the AK series with the high-velocity, lightweight 5.45x39mm cartridge and accepts standard AK-74M magazines."),
        },
    },
    mass = "3250 g",
    volume = "2418 ml",
    length = "96 cm",
    price = "39 kUSD",
    survival_price = "40 USD",
    materials = { "steel", "plastic" },
    flags = { "MISSION_ITEM" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "ak74mag", "rpk74mag", "casket74mag" } } },
    gun = {
        barrel_length = "415 mm",
        ammunition = { "545x39" },
        dispersion = 120,
        min_cycle_recoil = 1260,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 900, quantity = 2 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 900 },
        },
        barrel_volume = "250 ml",
        default_mods = { "bars", "wire_stock" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
