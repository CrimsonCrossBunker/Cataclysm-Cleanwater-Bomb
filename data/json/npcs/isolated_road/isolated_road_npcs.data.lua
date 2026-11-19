local ccb = require("ccb")

-- A blacksmith for the faction.
ccb.content.define_npc {
    id = "cody_miller",
    suffix = ccb.content.text("Blacksmith"),
    unique_name = ccb.content.text("Cody Miller"),
    gender = "female",
    class = "CODY_MILLER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_BLACKSMITH_SERVICES",
    faction = "isolated_artisans",
}

ccb.content.define_npc_class {
    id = "CODY_MILLER",
    name = ccb.content.text("Cody Miller"),
    job_description = ccb.content.text("A blacksmith who wants everyone to get along."),
    common = false,
    traits = {
        { trait = "TOUGH" },
        { trait = "FASTLEARNER" },
        { group = "Appearance_African" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 3 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { 1, 3 } },
    perception = { rng = { -1, 1 } },
    shop_groups = { { id = "CODY_MILLER_trade", rigid = true } },
    consumption_rates = "basic_shop_rates",
    worn = "CODY_MILLER_worn",
    carry = "CODY_MILLER_carry",
    weapon = "CODY_MILLER_wield",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 2, 3 } } },
        { skill = "gun", bonus = { rng = { 2, 5 } } },
        { skill = "melee", bonus = { rng = { 2, 5 } } },
        { skill = "cutting", bonus = { rng = { 2, 5 } } },
        { skill = "archery", bonus = { rng = { 3, 6 } } },
        { skill = "fabrication", bonus = { rng = { 7, 10 } } },
        { skill = "tailor", bonus = { rng = { 6, 9 } } },
    },
}

-- A gunsmith for the faction.
ccb.content.define_npc {
    id = "jay_ruckers",
    suffix = ccb.content.text("Banker"),
    unique_name = ccb.content.text("Jay Ruckers"),
    gender = "male",
    class = "JAY_RUCKERS",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_GUNSMITH_SERVICES",
    faction = "isolated_artisans",
}

ccb.content.define_npc_class {
    id = "JAY_RUCKERS",
    name = ccb.content.text("Jay Ruckers"),
    job_description = ccb.content.text("A gunsmith looking to become the new central bank."),
    common = false,
    traits = {
        { trait = "FASTLEARNER" },
        { group = "Appearance_Caucasian" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { 1, 3 } },
    perception = { rng = { 0, 3 } },
    shop_groups = { { id = "JAY_RUCKERS_trade", rigid = true } },
    consumption_rates = "basic_shop_rates",
    worn = "JAY_RUCKERS_worn",
    carry = "JAY_RUCKERS_carry",
    weapon = "JAY_RUCKERS_wield",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 2, 3 } } },
        { skill = "gun", bonus = { rng = { 2, 5 } } },
        { skill = "melee", bonus = { rng = { 0, 2 } } },
        { skill = "cutting", bonus = { rng = { 0, 2 } } },
        { skill = "fabrication", bonus = { rng = { 6, 8 } } },
        { skill = "mechanics", bonus = { rng = { 6, 10 } } },
        { skill = "rifle", bonus = { rng = { 3, 6 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
    },
}
