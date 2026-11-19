local ccb = require("ccb")

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_2",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_3",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_4",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_5",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

-- just a grunt
ccb.content.define_npc {
    id = "robofac_chop_shop_merc_6",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

ccb.content.define_npc_class {
    id = "NC_ANCILLA_GRUNT_CHOP_SHOP",
    name = ccb.content.text("Mercenary"),
    job_description = ccb.content.text("Fighting in the name of Hub 01 and money, mostly money."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_ANCILLA_GRUNT_CHOP_SHOP_worn",
    carry = "NC_ANCILLA_GRUNT_CHOP_SHOP_carry",
    weapon = "NC_ANCILLA_GRUNT_CHOP_SHOP_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
}
