local ccb = require("ccb")

ccb.content.define_profession {
    id = "redsmith",
    copy_from = "redsmith",
    name = "Redsmith",
    description = "When you were young, you were selected to be part of a secret fellowship and learned the rites necessary to melt and mold copper into tools.  You have spent long hours over the forge, lit by the glow of molten metal",
    npc_background = "BG_survival_story_WORKER_COMMERCIAL",
    skills = { { level = 6, id = "fabrication" }, { level = 2, id = "swimming" } },
    proficiencies = { "prof_metalworking", "prof_redsmithing", "prof_redsmithing_adv" },
    recipes = {},
    items = {
        both = {
            entries = {
                { item = "mocassins" },
                { item = "torch" },
                { item = "water_clean", charges = 6, container_item = "waterskin" },
                { item = "tunic" },
                { item = "apron_leather" },
                { item = "gloves_wraps_leather" },
                { item = "hammer_bronze" },
                { item = "crucible_clay" },
            },
        },
        male = { entries = { { item = "loincloth_leather" } } },
        female = { entries = { { item = "chestwrap_leather" }, { item = "loincloth_leather" } } },
    },
}

ccb.content.define_profession {
    id = "tribal_arbalist",
    name = "Tribal Archer",
    description = "From your first hunt, you showed talent with a bow.  While the tribe was well guarded by your aim, you're all alone now.",
    points = 3,
    proficiencies = {
        "prof_bow_basic",
        "prof_bow_expert",
        "prof_fletching",
        "prof_knives_familiar",
        "prof_gross_anatomy",
    },
    skills = {
        { level = 4, id = "archery" },
        { level = 3, id = "gun" },
        { level = 2, id = "swimming" },
        { level = 2, id = "survival" },
    },
    items = {
        both = {
            entries = {
                { item = "leathersandals" },
                { item = "helmet_larmor" },
                { item = "vambrace_larmor" },
                { item = "socks" },
                { item = "skirt_grass" },
                { item = "vest_leather" },
                { item = "legguard_larmor" },
                { item = "longbow" },
                { item = "quiver_birchbark", contents_groups = "quiver_bow_hunter" },
                { item = "quiver_large_birchbark", contents_groups = "quiver_arbalist" },
                { item = "copper_knife", container_item = "sheath_birchbark" },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "tribal_warrior_expert",
    name = "Seasoned Tribal Warrior",
    description = "You are veteran of many a raid and have fought in defense of your people against the things in the wild when they try to invade your home.  You have been scarred by weapon, by claw, and by things you'd rather not remember.  This latest ordeal is just another battle to be won.",
    points = 8,
    proficiencies = {
        "prof_bow_basic",
        "prof_bow_expert",
        "prof_knives_familiar",
        "prof_spears_familiar",
        "prof_spears_pro",
        "prof_gross_anatomy",
    },
    skills = {
        { level = 2, id = "gun" },
        { level = 3, id = "archery" },
        { level = 5, id = "stabbing" },
        { level = 4, id = "melee" },
        { level = 4, id = "dodge" },
        { level = 3, id = "swimming" },
    },
    traits = { "TOUGH", "PAINRESIST" },
    items = {
        both = {
            entries = {
                { item = "helmet_larmor" },
                { item = "armor_larmor" },
                { item = "socks" },
                { item = "boots_larmor" },
                { item = "gauntlets_larmor" },
                { item = "water_clean", charges = 6, container_item = "waterskin" },
                { item = "quiver_birchbark", contents_groups = "quiver_bow_hunter" },
                { item = "spear_copper", container_item = "spearsling" },
                { item = "copper_knife", container_item = "sheath_birchbark" },
                { item = "longbow", contents_items = { "primitive_bow_silencer" } },
            },
        },
        male = { entries = { { item = "loincloth_leather" } } },
        female = { entries = { { item = "chestwrap_leather" }, { item = "loincloth_leather" } } },
    },
}
