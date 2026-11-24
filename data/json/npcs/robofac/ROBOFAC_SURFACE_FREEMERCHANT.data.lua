local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- A free merchant caravanner that temporarily supplies the hq with foodstuff.
ccb.content.define_npc {
    id = "roabofac_free_merchant",
    suffix = ccb.content.text("Free Merchant"),
    class = "NC_ROBOFAC_FREE_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_FREE_MERCHANT",
    faction = "free_merchants",
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_ROBOFAC_FREE_MERCHANT",
    name = ccb.content.text("Caravaneer"),
    job_description = ccb.content.text("I'm the owner of a trade caravan."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = { { id = "NC_ROBOFAC_FREE_MERCHANT_misc", rigid = true } },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "computer", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 3, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_FREE_MERCHANT",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            choices = {
                ccb.content.text("Still plenty of outlaws in the roads, perhaps you should tend to your job, marshal…"),
                ccb.content.text("You see anything you want, marshal?"),
                ccb.content.text("Oh, a U.S. marshal, how quaint."),
            },
        },
        no = {
            choices = {
                ccb.content.text("Welcome…"),
                ccb.content.text("Here to trade, I hope?"),
                ccb.content.text("Safe travels, scavenger."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_ROBOFAC_FREE_MERCHANT",
        },
        {
            text = ccb.content.text("When is the next shipment?"),
            next_topic = "TALK_ROBOFAC_FREE_MERCHANT_INTERVAL",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_ROBOFAC_FREE_MERCHANT_DOING",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_FREE_MERCHANT_DOING",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("I keep to my own business, and you keep to yours, marshal.  Seems like a fair deal?"),
        no = ccb.content.text("We have been supplying this lab here with food from a few hunting and farming communities nearby.  The roads are tough and dangerous, but it makes good money, and beats scavenging the cities for scraps."),
    },
    replies = { { text = ccb.content.text("Keep safe, then."), next_topic = "TALK_ROBOFAC_FREE_MERCHANT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_FREE_MERCHANT_INTERVAL",
    line = ccb.content.text("Around <restock_time_point>, if the caravan doesn't run into trouble."),
    replies = { { text = ccb.content.text("Thanks for the info, bye."), next_topic = "TALK_DONE" } },
}
