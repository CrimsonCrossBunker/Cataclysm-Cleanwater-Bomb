local ccb = require("ccb")

-- The leader of this bunch of vampire hunters.  He seeks nothing less than the total extermination of all vampires.
ccb.content.define_npc {
    id = "vampire_hunter_leader",
    suffix = ccb.content.text("chief hunter"),
    class = "NC_vampire_hunter_leader",
    unique_name = ccb.content.text("Leonard Mai"),
    gender = "male",
    attitude = 0,
    mission = "SHOPKEEP",
    age = 88,
    chat = "TALK_VAMPIRE_HUNTER_LEADER",
    personality = { aggression = 10, bravery = 10, collector = 2, altruism = 1 },
    faction = "vampire_hunters",
}

-- Good social and deduction but hasn't fought for a long time.  Their aptitude as a chief makes them not worth risking in battles.
-- That's also why he gets regular clothes.  If he is ever part of a fight, then something is very wrong.
ccb.content.define_npc_class {
    id = "NC_vampire_hunter_leader",
    name = ccb.content.text("hunters' leader"),
    job_description = ccb.content.text("I lead the hunt against vampires."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_Latin" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { -2, 1 } },
    dexterity = { rng = { 0, 1 } },
    intelligence = { rng = { 2, 3 } },
    perception = { rng = { 1, 2 } },
    worn = "VAMPIRE_HUNTER_LEADER_worn",
    weapon = "VAMPIRE_HUNTER_LEADER_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 1, 4 } }, { constant = 1 } } } },
        { skill = "rifle", bonus = { rng = { -1, 1 } } },
        { skill = "gun", bonus = { rng = { -1, 1 } } },
        { skill = "melee", bonus = { rng = { -1, 1 } } },
        { skill = "stabbing", bonus = { rng = { -1, 1 } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
        { skill = "deduction", bonus = { rng = { 4, 6 } } },
        { skill = "speech", bonus = { rng = { 6, 7 } } },
    },
}
