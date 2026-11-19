local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_ARMY",
    name = ccb.content.text("Soldier"),
    job_description = ccb.content.text("I'm just here for the paycheck."),
    traits = {
        { group = "BG_survival_story_SOLDIER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    proficiencies = { "prof_gunsmithing_basic", "prof_spotting" },
    common = true,
    strength = { rng = { 0, 2 } },
    dexterity = { one_in = 2 },
    intelligence = { rng = { 0, -2 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "unarmed", bonus = { rng = { 1, 2 } } },
        { skill = "rifle", bonus = { rng = { 3, 5 } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_OPS",
    name = ccb.content.text("Operator"),
    job_description = ccb.content.text("I'm just here for the paycheck."),
    traits = {
        { group = "BG_survival_story_SOLDIER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    proficiencies = { "prof_gunsmithing_basic", "prof_spotting" },
    common = true,
    strength = { rng = { 0, 2 } },
    dexterity = { one_in = 2 },
    intelligence = { rng = { 0, 2 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "dodge", bonus = { rng = { 1, 4 } } },
        { skill = "melee", bonus = { rng = { 1, 4 } } },
        { skill = "unarmed", bonus = { rng = { 1, 4 } } },
        { skill = "rifle", bonus = { rng = { 3, 8 } } },
        { skill = "gun", bonus = { rng = { 2, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_HACKER",
    name = ccb.content.text("Hacker"),
    job_description = ccb.content.text("I'm looking for some choice systems to hack."),
    traits = {
        { group = "BG_survival_story_TEENAGER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -4, 0 } },
    dexterity = { rng = { -2, 0 } },
    intelligence = { rng = { 1, 5 } },
    perception = { rng = { -2, 0 } },
    aggression = { rng = { -3, -1 } },
    bravery = { rng = { -2, 0 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -2 } } } } } },
        },
        { skill = "electronics", bonus = { rng = { 1, 4 } } },
        { skill = "computer", bonus = { rng = { 3, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_TRADER",
    name = ccb.content.text("Trader"),
    job_description = ccb.content.text("I'm collecting gear and selling it."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    collector = { rng = { 1, 5 } },
}

ccb.content.define_npc_class {
    id = "NC_NINJA",
    name = ccb.content.text("Ninja"),
    job_description = ccb.content.text("I'm a wandering master of martial arts."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -1, 0 } },
    dexterity = { rng = { 0, 2 } },
    perception = { rng = { 0, 2 } },
    bravery = { rng = { 0, 3 } },
    collector = { rng = { -6, -1 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -2 } } } } } },
        },
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 1, 4 } } },
        { skill = "unarmed", bonus = { rng = { 4, 6 } } },
        { skill = "throw", bonus = { rng = { 0, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_SCIENTIST",
    name = ccb.content.text("Scientist"),
    job_description = ccb.content.text("I'm looking for clues concerning these monsters' origins…"),
    traits = {
        { group = "BG_survival_story_LAB" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -1, -3 } },
    dexterity = { rng = { -1, 0 } },
    intelligence = { rng = { 2, 5 } },
    aggression = { rng = { -5, -1 } },
    bravery = { rng = { -8, -2 } },
    collector = { rng = { 0, 2 } },
    proficiencies = {
        "prof_intro_chemistry",
        "prof_intro_biology",
        "prof_organic_chemistry",
        "prof_biochemistry",
        "prof_intro_chem_synth",
        "prof_chem_synth",
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -2 } } } } } },
        },
        { skill = "computer", bonus = { rng = { 1, 5 } } },
        { skill = "electronics", bonus = { rng = { 1, 5 } } },
        { skill = "chemistry", bonus = { rng = { 4, 7 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_MOTORHEAD",
    name = ccb.content.text("Motorhead"),
    job_description = ccb.content.text("I'm just about ready to ride off into the sunset…"),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 2 } },
    dexterity = { rng = { 1, 3 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { 0, 2 } },
    proficiencies = { "prof_metalworking", "prof_welding_basic", "prof_welding" },
    weapon = "NC_MOTORHEAD_wield",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -2 } } } } } },
        },
        { skill = "bashing", bonus = 1 },
        { skill = "driving", bonus = { rng = { 2, 8 } } },
        { skill = "electronics", bonus = { rng = { 1, 3 } } },
        { skill = "firstaid", bonus = 1 },
        { skill = "mechanics", bonus = { rng = { 2, 8 } } },
    },
}
