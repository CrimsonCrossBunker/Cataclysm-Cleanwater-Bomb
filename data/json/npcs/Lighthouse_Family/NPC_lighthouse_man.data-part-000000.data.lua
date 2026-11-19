local ccb = require("ccb")

ccb.content.define_npc {
    id = "NPC_lighthouse_man",
    gender = "male",
    class = "NC_NONE",
    unique_name = ccb.content.text("Mikhail Frolov"),
    suffix = ccb.content.text("Fisherman"),
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_lighthouse_man_1",
    faction = "fisherman_family",
    missions_offered = "MISSION_lighthouse_man_1",
}

ccb.content.define_npc_class {
    id = "NC_lighthouse_man",
    common = false,
    name = ccb.content.text("Fisherman"),
    job_description = ccb.content.text("I'm just wandering."),
    shop_groups = "NPC_lighthouse_man_shop",
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_Caucasian" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
    },
}
