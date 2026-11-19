local ccb = require("ccb")

ccb.content.define_npc {
    id = "mysterious_stranger",
    unique_name = ccb.content.text("Mysterious Stranger"),
    class = "NC_MYSTERIOUS_STRANGER",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_MYSTERIOUS_STRANGER",
    name = ccb.content.text("Mysterious Stranger"),
    job_description = ccb.content.text("I'm just here for the paycheck."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    proficiencies = { "prof_gunsmithing_basic", "prof_spotting" },
    strength = { rng = { 2, 3 } },
    dexterity = { one_in = 2 },
    intelligence = { rng = { 2, 3 } },
    aggression = { rng = { 70, 80 } },
    bravery = { rng = { 70, 80 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "dodge", bonus = { rng = { 3, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 4 } } },
        { skill = "unarmed", bonus = { rng = { 3, 4 } } },
        { skill = "rifle", bonus = { rng = { 5, 7 } } },
        { skill = "gun", bonus = { rng = { 5, 7 } } },
    },
}
