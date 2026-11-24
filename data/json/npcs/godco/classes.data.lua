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

ccb.content.define_npc_class {
    id = "NC_godco_russell",
    name = ccb.content.text("Hunter"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { -1, 0 } },
    perception = 4,
    worn = "GODCO_russell_worn",
    carry = "GODCO_russell_carried",
    weapon = "GODCO_russell_wield",
    proficiencies = { "prof_traps", "prof_trapsetting", "prof_tanning_basic" },
    shop_groups = {
        { id = "GODCO_russell_sell", rigid = true },
        {
            id = "GODCO_russell_carried",
            rigid = true,
            refusal = ccb.content.text("<npcname> will never sell this"),
            condition_handler = "shopkeeper_stock_override_enabled",
        },
    },
    traits = {
        { trait = "NIGHTVISION" },
        { trait = "OUTDOORSMAN" },
        { trait = "EAGLEEYED" },
        { group = "Appearance_demographics" },
        { trait = "FACIAL_HAIR_BEARD" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 2, 3 } } },
        { skill = "fabrication", bonus = { rng = { 1, 2 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "cutting", bonus = { rng = { 1, 2 } } },
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_tom",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -1, 0 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { -2, 1 } },
    worn = "GODCO_tom_worn",
    carry = "GODCO_tom_carried",
    weapon = "GODCO_tom_wield",
    traits = {
        { trait = "FASTREADER" },
        { trait = "SLOWRUNNER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 1, 2 } } },
        { skill = "fabrication", bonus = 1 },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_kostas",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -1, 1 } },
    perception = { rng = { 0, 2 } },
    worn = "GODCO_kostas_worn",
    carry = "GODCO_kostas_carried",
    shop_groups = "GODCO_kostas_carried",
    weapon = "GODCO_kostas_wield",
    proficiencies = { "prof_fibers", "prof_fibers_rope", "prof_knapping" },
    traits = {
        { trait = "ANIMALEMPATH" },
        { trait = "SPIRITUAL" },
        { trait = "OUTDOORSMAN" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 5, 7 } } },
        { skill = "melee", bonus = { rng = { 2, 3 } } },
        { skill = "fabrication", bonus = { rng = { 1, 2 } } },
        { skill = "cutting", bonus = 1 },
        { skill = "firstaid", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_greenwood",
    name = ccb.content.text("Clergyman"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { -2, 0 } },
    intelligence = { rng = { 2, 4 } },
    perception = { rng = { -2, 0 } },
    worn = "GODCO_greenwood_worn",
    carry = "GODCO_greenwood_carried",
    weapon = "GODCO_greenwood_wield",
    traits = {
        { trait = "SPIRITUAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 3, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_jane",
    name = ccb.content.text("Doctor"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 0 } },
    dexterity = { rng = { 0, 1 } },
    intelligence = { rng = { 1, 3 } },
    perception = { rng = { -1, 1 } },
    worn = "GODCO_jane_worn",
    carry = "GODCO_jane_carried",
    weapon = "GODCO_jane_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 5, 6 } } },
        { skill = "speech", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_corrie",
    name = ccb.content.text("joinee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { -1, 1 } },
    worn = "GODCO_corrie_worn",
    carry = "GODCO_corrie_carried",
    weapon = "GODCO_corrie_wield",
    proficiencies = { "prof_plasticworking", "prof_elec_soldering", "prof_welding_basic" },
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -4 } } } } } },
        },
        { skill = "mechanics", bonus = { rng = { 4, 5 } } },
        { skill = "fabrication", bonus = { rng = { 2, 3 } } },
        { skill = "electronics", bonus = { rng = { 3, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_felicity",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -1, 0 } },
    dexterity = { rng = { 0, 1 } },
    intelligence = { rng = { -1, 2 } },
    perception = { rng = { -1, 1 } },
    worn = "GODCO_felicity_worn",
    carry = "GODCO_felicity_carried",
    weapon = "GODCO_felicity_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { trait = "SPIRITUAL" },
        { group = "Appearance_Mixed" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { bonus = 1, skill = "speech" },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_theresa",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -3, -2 } },
    dexterity = { rng = { -3, -2 } },
    intelligence = { rng = { -1, 2 } },
    perception = { rng = { -3, -1 } },
    worn = "GODCO_theresa_worn",
    carry = "GODCO_theresa_carried",
    weapon = "GODCO_theresa_wield",
    proficiencies = { "prof_knitting", "prof_knitting_speed" },
    traits = {
        { trait = "SLOWRUNNER" },
        { trait = "BADHEARING" },
        { trait = "BADKNEES" },
        { trait = "FLIMSY" },
        { trait = "ANIMALEMPATH" },
        { trait = "HYPEROPIC" },
        { trait = "hair_long", variant = "white" },
        { trait = "natural_hair_color_white" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -2, -5 } } } } } },
        },
        { skill = "tailor", bonus = { rng = { 5, 6 } } },
        { skill = "cooking", bonus = { rng = { 5, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_jeremiah",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the group."),
    common = false,
    strength = { rng = { -1, 0 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { 0, 1 } },
    perception = { rng = { -2, 0 } },
    worn = "GODCO_jeremiah_worn",
    carry = "GODCO_jeremiah_carried",
    weapon = "GODCO_jeremiah_wield",
    traits = {
        { trait = "MYOPIC" },
        { trait = "PROF_DICEMASTER" },
        { group = "NPC_starting_traits" },
        { group = "Hair_Brown" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { bonus = 2, skill = "speech" },
        { bonus = 1, skill = "survival" },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_olwen",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -1, 0 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { -1, 1 } },
    worn = "GODCO_olwen_worn",
    carry = "GODCO_olwen_carried",
    weapon = "GODCO_olwen_wield",
    traits = {
        { trait = "WAKEFUL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "computer", bonus = { rng = { 5, 6 } } },
        { skill = "electronics", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_maria",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -1, 0 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { -1, 1 } },
    worn = "GODCO_maria_worn",
    carry = "GODCO_maria_carried",
    weapon = "GODCO_maria_wield",
    proficiencies = { "prof_closures", "prof_leatherworking_basic", "prof_leatherworking" },
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "tailor", bonus = { rng = { 5, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_godco_arturo",
    name = ccb.content.text("Member"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { -1, 0 } },
    dexterity = { rng = { -1, 0 } },
    intelligence = { rng = { -1, 2 } },
    perception = { rng = { -2, -1 } },
    worn = "GODCO_arturo_worn",
    carry = "naked_prisoner",
    weapon = "naked_prisoner",
    traits = {
        { trait = "SCHIZOPHRENIC" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 5 }, { sum = { { dice = { 1, 3 } }, { rng = { 0, -5 } } } } } },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_EVAC_GODCO_TRADER",
    name = ccb.content.text("Merchant"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = "NC_GODCO_MERCHANT_sell",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_TRADER_PREDATORY",
    name = ccb.content.text("Trader"),
    job_description = ccb.content.text("I'm collecting gear and selling it at a high interest."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    shop_groups = { { id = "NC_EVAC_SHOPKEEP_misc", rigid = true } },
    price_rules = {
        { item = "icon", price = 100 },
        { group = "NC_EVAC_SHOPKEEP_misc", markup = 3, condition_handler = "godco_representative_unpaid" },
    },
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
}
