local ccb = require("ccb")

ccb.content.define_npc {
    id = "boann",
    unique_name = ccb.content.text("Lady Boann"),
    class = "xe_fae_noblewoman_boann",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_BOANN_INTRO",
    missions_offered = "MISSION_BRING_BOANN_JABBERWOCK_HEART",
    gender = "female",
}

ccb.content.define_npc_class {
    id = "xe_fae_noblewoman_boann",
    name = ccb.content.text("fae noblewoman"),
    job_description = ccb.content.text("I'm in charge of the faeries of my court."),
    common = false,
    traits = {
        { trait = "hair_super_princess", variant = "blond" },
        { trait = "natural_hair_color_blond" },
        { trait = "SKIN_DARK" },
        { trait = "FAERIECREATURE" },
        { trait = "THRESH_FAIR_FOLK_NOBLE" },
        { trait = "IRON_ALLERGY" },
        { trait = "CHANGELING_MAGIC" },
        { trait = "DISIMMUNE" },
        { trait = "BEAUTIFUL2" },
        { trait = "PARACLESIAN_FAE_SIGHT_2" },
        { trait = "PARACLESIAN_INT_PER_2" },
        { trait = "PARACLESIAN_STR_DEX_2" },
        { trait = "PARACLESIAN_MAKE_GOSSAMER" },
        { trait = "CHANGELING_NOBLE_MOVEMENT_BUFFS" },
        { trait = "CHANGELING_NOBLE_BURNING_WEAPON" },
        { trait = "BOANN_RETALIATION" },
    },
    dexterity = { rng = { 4, 10 } },
    intelligence = { rng = { 2, 5 } },
    worn = "NC_BOANN_WORN_GEAR",
    carry = "EMPTY_GROUP",
    weapon = "NC_BOANN_WEAPON",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "melee", bonus = { rng = { 1, 5 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
        { skill = "cooking", bonus = { rng = { 6, 8 } } },
    },
}
