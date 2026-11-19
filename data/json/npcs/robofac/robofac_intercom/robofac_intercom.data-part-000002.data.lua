local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM_DAY",
    copy_from = "NC_ROBOFAC_INTERCOM_BASE",
    name = ccb.content.text("intercom (day)"),
    job_description = ccb.content.text("."),
    work_hours = { 6, 18 },
    worn = "NC_ROBOFAC_SCIENTIST_worn",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "INTERCOM_OPERATOR" },
        { trait = "IGNORE_SOUND" },
    },
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM_NIGHT",
    copy_from = "NC_ROBOFAC_INTERCOM_BASE",
    name = ccb.content.text("intercom (night)"),
    job_description = ccb.content.text("."),
    work_hours = { 18, 6 },
    worn = "NC_ROBOFAC_SCIENTIST_worn",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "INTERCOM_OPERATOR" },
        { trait = "IGNORE_SOUND" },
    },
}

-- Day shift operator for Hub 01 intercom. Placed at z=-1 ops room.
ccb.content.define_npc {
    id = "robofac_intercom_day",
    suffix = ccb.content.text("Intercom Operator"),
    class = "NC_ROBOFAC_INTERCOM_DAY",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_INTERCOM",
    faction = "robofac",
}

-- Night shift operator for Hub 01 intercom. Placed at z=-1 ops room.
ccb.content.define_npc {
    id = "robofac_intercom_night",
    suffix = ccb.content.text("Intercom Operator"),
    class = "NC_ROBOFAC_INTERCOM_NIGHT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_INTERCOM",
    faction = "robofac",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM_SUPPLY",
    copy_from = "NC_ROBOFAC_INTERCOM",
    name = ccb.content.text("Hub 01 representative"),
    job_description = ccb.content.text("."),
    worn = "NC_ROBOFAC_SCIENTIST_worn",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "TRADE_BACKEND" },
    },
}

-- Backend trade actor for Hub 01 intercom. Holds shared shop inventory.
ccb.content.define_npc {
    id = "robofac_intercom_supply",
    suffix = ccb.content.text("Hub 01 Representative"),
    class = "NC_ROBOFAC_INTERCOM_SUPPLY",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_INTERCOM",
    faction = "robofac",
}
