local ccb = require("ccb")

-- Couldn't find any information regarding weight and prices, so the numbers used here are broad guesses and are likely incorrect.
ccb.content.define_item {
    id = "retool_cz600_223rem",
    name = ccb.content.plural_text("CZ .223 barrel-assembly", "CZ .223 barrel-assemblies"),
    description = ccb.content.text("This is a quick-detach .223-caliber barrel assembly and bolt-head, installable within the frame of a CZ 600 rifle, and secured with three fasteners.  With this assembly installed, a rifle is capable of feeding ammunition from standard STANAG-style magazines."),
    mass = "1000 g",
    volume = "500 ml",
    length = "406 mm",
    integral_volume = "500 ml",
    integral_mass = "1000 g",
    integral_length = "406 mm",
    price = "250 USD",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = ":",
    color = "green",
    gunmod = {
        barrel_length = "406 mm",
        location = ccb.content.text("bore"),
        targets = { ccb.content.text("cz600", "gun_type_type") },
        install_time = "2 m",
        ammo_types = { "223" },
        magazine_adapters = {
            {
                ammo_type = "223",
                magazines = {
                    "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                    "stanag20ranger", "stanag30ranger", "stanag40", "stanag40ranger", "stanag50",
                    "stanag60", "stanag60drum", "stanag90", "stanag100", "stanag100drum", "stanag150",
                    "survivor223mag",
                },
            },
        },
        added_pockets = {
            {
                kind = "MAGAZINE_WELL",
                allowed_items = {
                    "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                    "stanag20ranger", "stanag30ranger", "stanag40", "stanag40ranger", "stanag50",
                    "stanag60", "stanag60drum", "stanag90", "stanag100", "stanag100drum", "stanag150",
                    "survivor223mag",
                },
            },
        },
        added_slots = { { id = "muzzle", count = 1 } },
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

-- Couldn't find any information regarding weight and prices, so the numbers used here are broad guesses and are likely incorrect.
ccb.content.define_item {
    id = "retool_cz600_762",
    name = ccb.content.plural_text("CZ 7.62x39mm barrel-assembly", "CZ 7.62x39mm barrel-assemblies"),
    description = ccb.content.text("This is a quick-detach 7.62mm barrel assembly and bolt head, installable within the frame of a CZ 600 rifle, and secured with three fasteners.  With this assembly installed, a rifle is rendered compatible with 7.62x39mm CZ Bren 2 magazines."),
    mass = "1000 g",
    volume = "500 ml",
    length = "406 mm",
    integral_volume = "500 ml",
    integral_mass = "1000 g",
    integral_length = "406 mm",
    price = "250 USD",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = ":",
    color = "green",
    gunmod = {
        barrel_length = "406 mm",
        location = ccb.content.text("bore"),
        targets = { ccb.content.text("cz600", "gun_type_type") },
        install_time = "2 m",
        ammo_types = { "762" },
        magazine_adapters = { { ammo_type = "762", magazines = { "akmag10", "akmag30" } } },
        added_pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "akmag10", "akmag30" } } },
        added_slots = { { id = "muzzle", count = 1 } },
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}
