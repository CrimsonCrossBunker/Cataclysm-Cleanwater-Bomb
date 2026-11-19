local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_StanBorichenko",
    unique_name = ccb.content.text("Stan Borichenko"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Stan",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Stan_1",
    faction = "free_merchants",
}

-- Stan is a broken man since he and Boris lost their son in the Cataclysm.  It might be possible to help put him back together slowly.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Stan",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Stan_worn",
    carry = "REFUGEE_Stan_carried",
    weapon = "REFUGEE_Stan_wield",
    traits = {
        { trait = "MYOPIC" },
        { group = "Appearance_Germanic" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "cooking", bonus = { rng = { 3, 4 } } },
        { skill = "computer", bonus = { rng = { 1, 2 } } },
    },
}
