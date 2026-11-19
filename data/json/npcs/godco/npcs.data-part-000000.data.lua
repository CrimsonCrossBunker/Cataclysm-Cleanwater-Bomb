local ccb = require("ccb")

ccb.content.define_npc {
    id = "godco_helena",
    unique_name = ccb.content.text("Helena Misinter"),
    gender = "female",
    suffix = ccb.content.text("prophet"),
    class = "NC_godco_helena",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Helena_1",
    missions_offered = "MISSION_GODCO_HELENA_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_chef",
    suffix = ccb.content.text("cook"),
    class = "NC_SURVIVOR_CHEF",
    unique_name = ccb.content.text("Simon Weaver"),
    gender = "male",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_chef",
    missions_offered = "MISSION_GODCO_COOK_FOOD_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_guard_food",
    suffix = ccb.content.text("guard"),
    class = "NC_godco_guard",
    unique_name = ccb.content.text("Eddie McKenzie"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_guard_food",
    missions_offered = "MISSION_GODCO_FOOD_GUARD_BOOK",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_chloe_taylor",
    unique_name = ccb.content.text("Chloe Taylor King"),
    gender = "female",
    suffix = ccb.content.text("member"),
    age = 17,
    class = "NC_godco_chloe_taylor",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_chloe",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_sonia",
    unique_name = ccb.content.text("Sonia Greene"),
    suffix = ccb.content.text("joinee"),
    gender = "female",
    class = "NC_godco_sonia",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Sonia",
    missions_offered = "MISSION_GODCO_GET_GUITAR_STRING",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_zachary_montes",
    suffix = ccb.content.text("joinee"),
    class = "NC_godco_zachary_montes",
    unique_name = ccb.content.text("Zachary Montes"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Zachary",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_darryl",
    unique_name = ccb.content.text("Darryl Johnstone"),
    suffix = ccb.content.text("member"),
    gender = "male",
    class = "NC_godco_darryl",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Darryl_1",
    missions_offered = "MISSION_GODCO_DARRYL_WELL1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_katherine",
    unique_name = ccb.content.text("Katherine Weaver"),
    suffix = ccb.content.text("member"),
    gender = "female",
    class = "NC_godco_katherine",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Katherine_1",
    missions_offered = "MISSION_GODCO_KATHERINE_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_julian",
    unique_name = ccb.content.text("Julian Ray"),
    gender = "male",
    suffix = ccb.content.text("dorm leader"),
    class = "NC_godco_julian",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Julian_1",
    missions_offered = "MISSION_GODCO_JULIAN_PAPER",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_gemma",
    unique_name = ccb.content.text("Gemma Johnstone"),
    suffix = ccb.content.text("dorm leader"),
    gender = "female",
    class = "NC_godco_gemma",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Gemma_1",
    missions_offered = { "MISSION_GODCO_GEMMA_SUPPLEMENTS", "MISSION_GODCO_GEMMA_SEEDS" },
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_russell",
    unique_name = ccb.content.text("Russell Connelly"),
    suffix = ccb.content.text("member"),
    gender = "male",
    class = "NC_godco_russell",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Russell_1",
    missions_offered = "MISSION_GODCO_RUSSELL_TROPHY1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_tom",
    unique_name = ccb.content.text("Tom Powell"),
    suffix = ccb.content.text("member"),
    gender = "male",
    class = "NC_godco_tom",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Tom_1",
    missions_offered = "MISSION_GODCO_TOM_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_kostas",
    unique_name = ccb.content.text("Kostas Walsman"),
    gender = "male",
    suffix = ccb.content.text("member"),
    class = "NC_godco_kostas",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Kostas_1",
    missions_offered = "MISSION_GODCO_KOSTAS_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_greenwood",
    unique_name = ccb.content.text("Father Greenwood"),
    suffix = ccb.content.text("clergyman"),
    gender = "male",
    class = "NC_godco_greenwood",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Greenwood_1",
    missions_offered = "MISSION_GODCO_GREENWOOD_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_jane",
    unique_name = ccb.content.text("Jane Schulz"),
    gender = "female",
    suffix = ccb.content.text("joinee"),
    class = "NC_godco_jane",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Jane_1",
    missions_offered = "MISSION_GODCO_JANE_PILLS",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_corrie",
    unique_name = ccb.content.text("Corrie Kaja Dosia"),
    gender = "female",
    suffix = ccb.content.text("joinee"),
    class = "NC_godco_corrie",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Corrie_1",
    missions_offered = "MISSION_GODCO_CORRIE_MACHINE1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_felicity",
    unique_name = ccb.content.text("Felicity Powell"),
    gender = "female",
    suffix = ccb.content.text("member"),
    class = "NC_godco_felicity",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Felicity_1",
    missions_offered = "MISSION_GODCO_FELICITY_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_theresa",
    unique_name = ccb.content.text("Theresa Monoco"),
    gender = "female",
    suffix = ccb.content.text("member"),
    age = 86,
    class = "NC_godco_theresa",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Theresa_1",
    missions_offered = "MISSION_GODCO_THERESA_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_jeremiah",
    unique_name = ccb.content.text("Jeremiah Weaver"),
    suffix = ccb.content.text("member"),
    gender = "male",
    age = 16,
    class = "NC_godco_jeremiah",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Jeremiah_1",
    missions_offered = "MISSION_GODCO_JEREMIAH_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_olwen",
    unique_name = ccb.content.text("Olwen Powell"),
    gender = "female",
    suffix = ccb.content.text("member"),
    class = "NC_godco_olwen",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Olwen_1",
    missions_offered = "MISSION_GODCO_OLWEN_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_maria",
    unique_name = ccb.content.text("Maria Serrano"),
    gender = "female",
    suffix = ccb.content.text("member"),
    class = "NC_godco_maria",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Maria",
    missions_offered = "MISSION_GODCO_MARIA_1",
    faction = "gods_community",
}

ccb.content.define_npc {
    id = "godco_arturo",
    unique_name = ccb.content.text("Arturo Maldonado"),
    gender = "male",
    suffix = ccb.content.text("member"),
    class = "NC_godco_arturo",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_GODCO_Arturo_1",
    faction = "gods_community",
}

-- Random NPC, can direct you to the free merchants and sell you things.
ccb.content.define_npc {
    id = "FM_godco_merchant_random",
    suffix = ccb.content.text("Caravan Merchant"),
    class = "NC_EVAC_GODCO_TRADER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_CARAVAN_MERCHANT_1",
    faction = "free_merchants",
}
