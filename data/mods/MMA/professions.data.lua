local ccb = require("ccb")

ccb.content.define_profession {
    id = "mma_battle_angel",
    name = "Battle Angel",
    description = "A combat-ready cyborg once salvaged from an obscure junkyard…",
    points = 8,
    martial_arts = { "style_mma_panzer" },
    proficiencies = {
        "prof_unarmed_familiar",
        "prof_unarmed_pro",
        "prof_bionic_swords_familiar",
        "prof_bionic_swords_pro",
        "prof_bionics_familiar",
        "prof_gross_anatomy",
        "prof_wp_cyborg",
    },
    skills = { { level = 3, id = "unarmed" }, { level = 3, id = "melee" }, { level = 1, id = "dodge" } },
    items = {
        both = {
            entries = {
                { item = "wetsuit" },
                { item = "trenchcoat" },
                { item = "gloves_fingerless" },
                { item = "knee_pads" },
                { item = "boots" },
            },
        },
    },
    traits = { "CBM_Interface" },
    bionics = {
        "bio_power_storage_mkII",
        "bio_armor_arms",
        "bio_armor_head",
        "bio_armor_legs",
        "bio_armor_torso",
        "bio_blade",
        "bio_metabolics",
    },
}

ccb.content.define_profession {
    id = "mma_hylian_adventurer",
    name = "Hylian Adventurer",
    description = "Sucked through a vortex into what appears to be a shadow realm, you will continue to fight for justice.",
    points = 6,
    traits = { "ELFAEYES", "ELFA_EARS" },
    martial_arts = { "style_mma_hylian" },
    proficiencies = { "prof_medium_swords_familiar", "prof_medium_swords_pro", "prof_gross_anatomy" },
    skills = { { level = 3, id = "cutting" }, { level = 3, id = "melee" }, { level = 1, id = "dodge" } },
    items = {
        both = {
            entries = {
                { item = "combat_shirt" },
                { item = "cloak" },
                { item = "gloves_fingerless" },
                { item = "antarvasa" },
                { item = "ragpouch" },
                { item = "socks" },
                { item = "boots" },
                { item = "sword_wood", custom_flags = { "auto_wield" } },
            },
        },
    },
}
