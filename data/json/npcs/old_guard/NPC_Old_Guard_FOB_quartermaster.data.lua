local ccb = require("ccb")

-- Old guard quatermaster
ccb.content.define_npc {
    id = "OG_base_qmaster",
    suffix = ccb.content.text("Quartermaster"),
    class = "NC_SOLDIER_QMASTER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SOLDIER_QMASTER",
    missions_offered = "MISSION_FREE_MERCHANTS_EVAC_1",
    faction = "old_guard",
}

ccb.content.define_npc_class {
    id = "NC_SOLDIER_QMASTER",
    name = ccb.content.text("Merchant"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = "NC_SOLDIER_QMASTER_misc",
    carry = "NC_SOLDIER_QMASTER_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 3, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SOLDIER_QMASTER",
    line = {
        choices = {
            ccb.content.text("Welcome to camp Arabella, What will it be?"),
            ccb.content.text("I'm the camp quartermaster.  Come and see me if you have anything valuable to trade."),
            ccb.content.text("If you're looking to trade you've come to the right place."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's trade then."),
            native_actions = { "start_trade" },
            next_topic = "TALK_SOLDIER_QMASTER",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
