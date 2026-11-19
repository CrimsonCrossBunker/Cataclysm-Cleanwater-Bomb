local ccb = require("ccb")

ccb.content.define_npc {
    id = "HUB01_SNarayana",
    unique_name = ccb.content.text("Sunil Narayana"),
    gender = "male",
    suffix = ccb.content.text("server maintenance"),
    class = "NC_HUB01_SNarayana",
    attitude = 0,
    mission = "GUARD",
    chat = "HUB01_SNarayana_Intro",
    faction = "robofac",
}

-- HVAC maintenance.  Resident dungeon master.
ccb.content.define_npc_class {
    id = "NC_HUB01_SNarayana",
    name = ccb.content.text("Hub 01 Server Maintenance"),
    job_description = ccb.content.text("I'm part of Hub 01's maintenance crew."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { -1, 1 } },
    worn = "HUB01_SNarayana_worn",
    carry = "HUB01_SNarayana_carried",
    weapon = "HUB01_SNarayana_wield",
    traits = { { trait = "PROF_DICEMASTER" }, { group = "Appearance_demographics" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 0, 1 } } },
        { skill = "electronics", bonus = { rng = { 4, 5 } } },
    },
}
