local ccb = require("ccb")

-- A cold ex-mercenary from a third world country you have never heard of before.  Third in charge after Melchior and Director Cohen.
-- He needs unique dialogue.  But for now he's just the boss enemy of Hub 01, if the player attempts to invade the lab.
ccb.content.define_npc {
    id = "hub_security_head",
    unique_name = ccb.content.text("U. Rourke"),
    suffix = ccb.content.text("Head of Security"),
    gender = "male",
    class = "NC_ROBOFAC_SECURITY_HEAD",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_HUB_SECURITY",
    faction = "robofac",
}

-- Needs his own unique background.
ccb.content.define_npc_class {
    id = "NC_ROBOFAC_SECURITY_HEAD",
    name = ccb.content.text("Head of security"),
    job_description = ccb.content.text("I'm part of the Hub security team."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { "TOUGH2", 100 },
        { "PAINRESIST", 100 },
        { "GOODCARDIO", 100 },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 2, 4 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { 2, 4 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -1 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "smg", bonus = { rng = { 2, 6 } } },
    },
    carry = "NC_robofac_security_head_misc",
    worn = "NC_robofac_security_head_worn",
    weapon = "NC_robofac_security_head_weapon",
}
