local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_godco_helena",
    name = ccb.content.text("Leader"),
    job_description = ccb.content.text("I am the leader of the New England Church Community."),
    common = false,
    strength = 1,
    dexterity = { rng = { -1, 0 } },
    intelligence = { rng = { 0, 2 } },
    perception = 2,
    worn = "GODCO_helena_worn",
    carry = "GODCO_helena_carried",
    weapon = "GODCO_helena_wield",
    traits = {
        { trait = "SPIRITUAL" },
        { trait = "EAGLEEYED" },
        { trait = "hair_long", variant = "brown" },
        { trait = "natural_hair_color_brown" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -3 } } } } } },
        },
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "speech", bonus = { rng = { 2, 3 } } },
        { skill = "rifle", bonus = { rng = { 1, 2 } } },
        { skill = "survival", bonus = { rng = { 1, 2 } } },
        { skill = "fabrication", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_guard",
    name = ccb.content.text("Guard"),
    job_description = ccb.content.text("I'm protecting stuff."),
    common = false,
    strength = { rng = { -1, 2 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { -1, 1 } },
    perception = { rng = { 1, 3 } },
    worn = "GODCO_guard_worn",
    carry = "GODCO_guard_carried",
    weapon = "GODCO_guard_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_chloe_taylor",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -3, -2 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, -2 } },
    perception = { rng = { 0, 2 } },
    worn = "GODCO_chloe_taylor_worn",
    carry = "GODCO_chloe_taylor_carried",
    weapon = "GODCO_chloe_taylor_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Skin_Any" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "melee", bonus = 1 },
        { skill = "stabbing", bonus = 1 },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_sonia",
    name = ccb.content.text("Joinee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -3, -1 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { 0, 1 } },
    worn = "GODCO_sonia_worn",
    carry = "GODCO_sonia_carried",
    weapon = "GODCO_sonia_wield",
    traits = {
        { trait = "PRETTY" },
        { trait = "PACIFIST" },
        { group = "NPC_starting_traits" },
        { trait = "hair_long", variant = "blond" },
        { trait = "natural_hair_color_blond" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "bashing", bonus = 1 },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_zachary_montes",
    name = ccb.content.text("Joinee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { 0, 2 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -1, 1 } },
    perception = { rng = { -1, 1 } },
    worn = "GODCO_zachary_montes_worn",
    carry = "GODCO_zachary_montes_carried",
    weapon = "GODCO_zachary_montes_wield",
    proficiencies = { "prof_carpentry_basic", "prof_carving" },
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "FACIAL_HAIR_BEARD" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "melee", bonus = 1 },
        { skill = "cutting", bonus = { rng = { 1, 2 } } },
        { skill = "survival", bonus = { rng = { 1, 2 } } },
        { skill = "bashing", bonus = { rng = { 2, 3 } } },
        { skill = "fabrication", bonus = { rng = { 3, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_darryl",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { 0, 2 } },
    dexterity = { rng = { 0, 1 } },
    intelligence = { rng = { -1, 0 } },
    perception = { rng = { -1, 0 } },
    worn = "GODCO_darryl_worn",
    carry = "GODCO_darryl_carried",
    weapon = "GODCO_darryl_wield",
    traits = {
        { trait = "SPIRITUAL" },
        { group = "Appearance_demographics" },
        { trait = "ANIMALEMPATH" },
        { trait = "OUTDOORSMAN" },
        { group = "Exp_Agriculture_Nofake" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 2, 3 } } },
        { skill = "fabrication", bonus = { rng = { 2, 3 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "bashing", bonus = { rng = { 1, 2 } } },
        { skill = "cutting", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_katherine",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -2, 0 } },
    dexterity = { rng = { -1, 0 } },
    intelligence = { rng = { -1, 2 } },
    perception = { rng = { -1, 1 } },
    worn = "GODCO_katherine_worn",
    carry = "GODCO_katherine_carried",
    weapon = "GODCO_katherine_wield",
    proficiencies = { "prof_knitting" },
    traits = {
        { trait = "GLASSJAW" },
        { trait = "SPIRITUAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_Caucasian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { bonus = 2, skill = "cooking" },
        { bonus = 2, skill = "tailor" },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_julian",
    name = ccb.content.text("Dorm leader"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { -1, 1 } },
    perception = 2,
    worn = "GODCO_julian_worn",
    carry = "GODCO_julian_carried",
    weapon = "GODCO_julian_wield",
    traits = {
        { group = "Appearance_demographics" },
        { trait = "NIGHTVISION" },
        { trait = "SPIRITUAL" },
        { trait = "INSOMNIA" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "gun", bonus = 3 },
        { skill = "pistol", bonus = 2 },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_gemma",
    name = ccb.content.text("Dorm leader"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 1 } },
    intelligence = { rng = { -1, 1 } },
    perception = { rng = { -1, 1 } },
    worn = "GODCO_gemma_worn",
    carry = "GODCO_gemma_carried",
    weapon = "GODCO_gemma_wield",
    traits = {
        { trait = "SPIRITUAL" },
        { trait = "NIGHTVISION" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 2, 3 } } },
        { skill = "fabrication", bonus = { rng = { 3, 5 } } },
    },
}
