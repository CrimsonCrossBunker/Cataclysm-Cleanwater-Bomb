local ccb = require("ccb")

ccb.content.define_item {
    id = "mossberg_500_20",
    copy_from = "mossberg_500",
    name = ccb.content.text("5-round hunting shotgun, 20 gauge"),
    description = ccb.content.text("Classic all-purpose shotgun, adapted to use 20 bore shells.  While being somewhat weaker than classic 12 bore, 26 inch of barrel length allow it to kick reasonable punch, without being as heavy as it's bigger brothers."),
    variant_kind = "gun",
    variants = {
        {
            id = "mossberg_500_20",
            name = ccb.content.text("Mossberg 500, 20 gauge"),
            description = ccb.content.text("Classic, famous Mossberg 500 Hunting All Purpose Field, adapted to use 20 bore shells.  While being somewhat weaker than classic 12 bore, 26 inch of barrel length allow it to kick reasonable punch, without being as heavy as it's bigger brothers."),
        },
    },
    mass = "3175 g",
    volume = "2000 ml",
    length = "1149 mm",
    price = "545 USD",
    survival_price = "3 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["20shot"] = 5 } } },
    gun = { barrel_length = "660 mm", clip_size = 5, ammunition = { "20shot" } },
}

ccb.content.define_item {
    id = "remington_870_20",
    copy_from = "remington_870",
    name = ccb.content.text("4-round hunting shotgun, 20 gauge"),
    description = ccb.content.text("The most widely recognizable pump shotgun frame ever created.  When tv shows or movies picked a shotgun for civilian use, this or a replica like it were the most commonly used.  It comes in many shell sizes, this one is for 20 bore shells."),
    variant_kind = "gun",
    variants = {
        {
            id = "remington_870_20",
            name = ccb.content.text("Remington 870 Wingmaster shotgun, 20 gauge"),
            description = ccb.content.text("The most widely recognizable pump shotgun frame ever created.  When tv shows or movies picked a shotgun for civilian use, this or a replica like it were the most commonly used.  It comes in many shell sizes, this one is for 20 bore shells."),
        },
    },
    ascii_picture = "remington870",
    mass = "2778 g",
    volume = "2300 ml",
    length = "1181 mm",
    price = "1023 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["20shot"] = 4 } } },
    gun = { barrel_length = "660 mm", clip_size = 4, ammunition = { "20shot" } },
}

ccb.content.define_item {
    id = "savage_model_220",
    copy_from = "gun_base_shotgun_manual",
    name = ccb.content.text("bolt-action shotgun, 20 gauge"),
    description = ccb.content.text("Child of Massachusetts gunmakers, this is a rifled bolt-action shotgun, designed mainly to be used with slugs, with two round detachable magazine.  Using it for anything but a casual hunting would be a challenge of it's own."),
    variant_kind = "gun",
    variants = {
        {
            id = "savage_model_220",
            name = ccb.content.text("Savage 220 Slug, 20 gauge"),
            description = ccb.content.text("Child of Massachusetts gunmakers, this is a rifled bolt-action shotgun, designed mainly to be used with slugs, with two round detachable magazine.  Using it for anything but a casual hunting would be a challenge of it's own."),
        },
    },
    mass = "3330 g",
    volume = "2800 ml",
    length = "1092 mm",
    price = "719 USD",
    survival_price = "3 USD",
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "savage_220_magazine" } } },
    melee_damage = { bash = 3 },
    inheritance = { add = { flags = { "BOLT_ACTION" } } },
    gun = {
        barrel_length = "559 mm",
        dispersion = 395,
        durability = 7,
        barrel_volume = "252 ml",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "loading port", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        ammunition = { "20shot" },
    },
}

ccb.content.define_item {
    id = "browning_citori_20",
    copy_from = "gun_base_shotgun_manual",
    name = ccb.content.text("double-barreled shotgun, 20 gauge"),
    description = ccb.content.text("Manufactured in Japan, this 28 inch over-under double-barreled shotgun, loaded with 20 bore shells, is a classy tool to hunt a deer and to kill a man."),
    variant_kind = "gun",
    variants = {
        {
            id = "browning_citori_20",
            name = ccb.content.text("Browning Citori 20 gauge shotgun"),
            description = ccb.content.text("Manufactured in Japan, this 28 inch over-under double-barreled shotgun, loaded with 20 bore shells, is a classy tool to hunt a deer and to kill a man."),
        },
    },
    mass = "3231 g",
    volume = "1819 ml",
    length = "1143 mm",
    price = "2640 USD",
    survival_price = "3 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["20shot"] = 2 } } },
    gun = {
        clip_size = 2,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("single"), quantity = 1 },
            {
                id = "DOUBLE",
                label = ccb.content.text("double"),
                quantity = 2,
                flags = { "VOLLEY" },
            },
        },
        barrel_length = "711 mm",
        barrel_volume = "494 ml",
        ammunition = { "20shot" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
