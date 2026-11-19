local ccb = require("ccb")

-- Mutant beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar5",
    unique_name = ccb.content.text("Yusuke Taylor"),
    gender = "male",
    suffix = ccb.content.text("Computer Technician"),
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_5",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_5",
    faction = "lobby_beggars",
}

-- This is the only beggar with some skills, sort of the leader.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_5",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 4 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { 0, 4 } },
    worn = "NC_BEGGAR_5_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "FUR" },
        { trait = "OPTIMISTIC" },
        { trait = "LIGHTSTEP" },
        { trait = "CLAWS_RETRACT" },
        { group = "Appearance_Mixed" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "electronics", bonus = { rng = { 3, 6 } } },
        { skill = "computer", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 0, 5 } } },
        { skill = "unarmed", bonus = { rng = { 0, 5 } } },
    },
}
