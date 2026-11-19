local ccb = require("ccb")

ccb.content.define_npc {
    id = "HUB01_JFarrier",
    unique_name = ccb.content.text("Jonathan Farrier"),
    gender = "male",
    suffix = ccb.content.text("assistant"),
    class = "NC_HUB01_JFarrier",
    attitude = 0,
    mission = "GUARD",
    chat = "HUB01_JFarrier_Intro",
    faction = "robofac",
}

-- Trucker and now general handyman.  Used to work as a cargo driver for a company supplying Hub 01, is only inside the lab by chance.
ccb.content.define_npc_class {
    id = "NC_HUB01_JFarrier",
    name = ccb.content.text("Hub 01 Assistant"),
    job_description = ccb.content.text("I do miscellaneous jobs within Hub 01."),
    common = false,
    strength = { rng = { -1, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "HUB01_JFarrier_worn",
    carry = "HUB01_JFarrier_carried",
    weapon = "HUB01_JFarrier_wield",
    traits = { { group = "Appearance_demographics" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "driving", bonus = { rng = { 4, 6 } } },
        { skill = "fabrication", bonus = { rng = { 0, 1 } } },
        { skill = "mechanics", bonus = { rng = { 1, 2 } } },
    },
}
