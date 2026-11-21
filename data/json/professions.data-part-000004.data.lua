local ccb = require("ccb")

ccb.content.define_profession {
    id = "reenactor",
    name = { male = "Historical Reenactor", female = "Ahistorical Reenactor" },
    description = {
        male = "You were on your way to the Annual All New England Revolutionary War Living History exhibition when the end of the world permanently derailed your plans.",
        female = "You were on your way to the Annual All New England Revolutionary War Living History exhibition when the end of the world made traditional gender roles obsolete.",
    },
    points = 2,
    proficiencies = {
        "prof_gunsmithing_basic",
        "prof_metalworking",
        "prof_gunsmithing_antique",
        "prof_gun_cleaning",
    },
    skills = {
        { level = 3, id = "gun" },
        { level = 3, id = "rifle" },
        { level = 3, id = "mechanics" },
        { level = 2, id = "tailor" },
        { level = 2, id = "cooking" },
    },
    items = {
        both = {
            entries = {
                { item = "stockings", variant = "stockings_white" },
                { item = "pockknife" },
                { group = "pipe_smoke" },
                { item = "backpack" },
                { item = "knee_high_boots" },
                { item = "breeches" },
                { item = "waistcoat" },
                { item = "peacoat" },
                { item = "leather_belt" },
                { item = "knit_scarf" },
                { item = "tricorne" },
                { item = "hatchet" },
                { item = "hardtack" },
                { item = "pipe_cleaner" },
                {
                    item = "rifle_flintlock",
                    ammo_item = "flintlock_ammo",
                    charges = 1,
                    contents_items = "shoulder_strap_simple",
                },
                { item = "flintlock_pouch", contents_groups = "flintlock_pouch_reenactor" },
                { item = "flintlock_ammo", charges = 15 },
                { item = "vinegar", container_item = "bottle_plastic_small" },
                { item = "lamp_oil", container_item = "bottle_plastic_small" },
                { group = "charged_smart_phone", contents_items = "tall_tales" },
                { group = "starter_wallet_full" },
                { group = "charged_matches" },
            },
        },
    },
}

ccb.content.define_profession {
    id = "reenactor2",
    name = { male = "Ahistorical Reenactor", female = "Historical Reenactor" },
    description = {
        male = "You were on your way to the Annual All New England Revolutionary War Living History exhibition when the end of the world made traditional gender roles obsolete.",
        female = "You were on your way to the Annual All New England Revolutionary War Living History exhibition when the end of the world permanently derailed your plans.",
    },
    points = 2,
    proficiencies = {
        "prof_spinning",
        "prof_closures",
        "prof_knitting",
        "prof_gun_cleaning",
    },
    skills = {
        { level = 4, id = "tailor" },
        { level = 4, id = "cooking" },
        { level = 2, id = "gun" },
        { level = 2, id = "rifle" },
    },
    items = {
        both = {
            entries = {
                { item = "stockings", variant = "stockings_white" },
                { item = "pockknife" },
                { group = "pipe_smoke" },
                { item = "backpack" },
                { item = "dress" },
                { item = "apron_leather" },
                { item = "boots" },
                { item = "gloves_leather" },
                { item = "long_knit_scarf" },
                { item = "hat_fur" },
                { item = "purse" },
                { item = "pot" },
                { item = "cornmeal", count = 4, container_item = "null", entry_wrapper = "box_small" },
                { item = "salt", count = 100, container_item = "null", entry_wrapper = "bag_plastic" },
                { item = "needle_wood", ammo_item = "thread", charges = 200 },
                { item = "oil_lamp", charges = 750 },
                { group = "charged_smart_phone", contents_items = "book_nonf_hard_homemk_handshome" },
                { group = "starter_wallet_full" },
                { group = "charged_matches" },
            },
        },
    },
}
