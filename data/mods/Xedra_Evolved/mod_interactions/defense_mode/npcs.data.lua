local ccb = require("ccb")

-- Scenario specific NPC, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "follower_xedra_zebra_officer",
    class = "NC_ZEBRA_INVESTIGATOR",
    attitude = 3,
    mission = "NULL",
    chat = "TALK_FRIEND",
    faction = "your_followers",
}

ccb.content.define_npc_class {
    id = "NC_ZEBRA_INVESTIGATOR",
    name = ccb.content.text("Zebra Investigator"),
    job_description = ccb.content.text("I've seen things I don't want to remember, strange far worlds and stuff."),
    skills = {
        { skill = "speech", bonus = { rng = { 3, 3 } } },
        { skill = "gun", bonus = { rng = { 3, 3 } } },
        { skill = "pistol", bonus = { rng = { 3, 3 } } },
    },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 2 } },
    strength = { rng = { 0, 2 } },
    dexterity = { rng = { 0, 2 } },
    worn = "zebra_worn_override",
    carry = "zebra_carry_override",
    weapon = "zebra_weapon_override",
    traits = {
        { group = "Appearance_demographics" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
    },
}
