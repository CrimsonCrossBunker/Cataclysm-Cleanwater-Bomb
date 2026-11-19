local ccb = require("ccb")

ccb.content.define_npc {
    id = "HUB01_DNovak",
    unique_name = ccb.content.text("Darla Novak"),
    gender = "female",
    suffix = ccb.content.text("building maintenance"),
    class = "NC_HUB01_DNovak",
    attitude = 0,
    mission = "GUARD",
    chat = "HUB01_DNovak_Intro",
    faction = "robofac",
}

-- HVAC maintenance.  Keeps melchior from boiling to death and you from choking on stale bunker air.
ccb.content.define_npc_class {
    id = "NC_HUB01_DNovak",
    name = ccb.content.text("Hub 01 HVAC maintenance"),
    job_description = ccb.content.text("I'm part of Hub 01's maintenance crew."),
    common = false,
    strength = { rng = { -1, 2 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -1, 2 } },
    worn = "HUB01_DNovak_worn",
    carry = "HUB01_DNovak_carried",
    weapon = "HUB01_DNovak_wield",
    traits = { { group = "Appearance_demographics" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "fabrication", bonus = { rng = { 0, 3 } } },
        { skill = "mechanics", bonus = { rng = { 4, 5 } } },
    },
}
