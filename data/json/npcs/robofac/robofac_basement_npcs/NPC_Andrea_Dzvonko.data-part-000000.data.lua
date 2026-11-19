local ccb = require("ccb")

ccb.content.define_npc {
    id = "HUB01_ADzvonko",
    unique_name = ccb.content.text("Andrea Dzvonko"),
    gender = "female",
    suffix = ccb.content.text("software engineer"),
    class = "NC_HUB01_ADzvonko",
    attitude = 0,
    mission = "GUARD",
    chat = "HUB01_ADzvonko_Intro",
    faction = "robofac",
}

-- Andrea Dzvonko is a software engineer with a limited understanding of how melchior actually functions.
ccb.content.define_npc_class {
    id = "NC_HUB01_ADzvonko",
    name = ccb.content.text("Hub 01 Software Engineer"),
    job_description = ccb.content.text("I work for Hub 01 as a software engineer."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 0, 4 } },
    perception = { rng = { -2, 2 } },
    worn = "HUB01_ADzvonko_worn",
    carry = "HUB01_ADzvonko_carried",
    weapon = "HUB01_ADzvonko_wield",
    traits = { { trait = "FASTLEARNER" }, { group = "Appearance_Caucasian" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "computer", bonus = { rng = { 4, 6 } } },
    },
}
