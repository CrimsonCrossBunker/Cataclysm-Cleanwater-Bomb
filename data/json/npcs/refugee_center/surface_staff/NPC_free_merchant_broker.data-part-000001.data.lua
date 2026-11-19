local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- table of contents - these options will appear in the listed dialogue topics
ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANT_STOCKS", "TALK_FREE_MERCHANT_STOCKS_NEW", "TALK_FREE_MERCHANT_STOCKS_ALL",
        "TALK_FREE_MERCHANT_STOCKS_BACKGROUND", "TALK_FREE_MERCHANT_STOCKS_FMCN",
        "TALK_FREE_MERCHANT_STOCKS_REFUGEES", "TALK_FREE_MERCHANT_STOCKS_BEGGARS",
        "TALK_FREE_MERCHANT_STOCKS_SEALED1", "TALK_FREE_MERCHANT_STOCKS_SEALED2",
        "TALK_FREE_MERCHANT_STOCKS_RANCH", "TALK_FREE_MERCHANT_STOCKS_Boris_Mission_1",
    },
    replies = {
        {
            text = ccb.content.text("I'm here to deliver some food supplies."),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_DELIVER",
        },
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you offer any help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_Boris_Mission_1",
        },
        {
            text = ccb.content.text("Are you able to buy some canning supplies?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_JARS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMBroker_Mission1" } }),
        },
        {
            text = ccb.content.text("I was told you had work for me?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission5" } }),
        },
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_FREE_MERCHANT_STOCKS_NEW" },
        {
            text = ccb.content.text("What's the deal with this written-on paper money you guys use?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_FMCN",
        },
        {
            text = ccb.content.text("The refugees stuck up here seem a bit disgruntled."),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_REFUGEES",
        },
        {
            text = ccb.content.text("Do you know about those beggars in the lobby?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_BEGGARS",
        },
        {
            text = ccb.content.text("What's the deal with the closed-off areas of the building?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_SEALED1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } })),
        },
        {
            text = ccb.content.text("What are you going to do with that back bay area now that I've cleaned it out for you?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_SEALED2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } }),
        },
        {
            text = ccb.content.text("Tell me more about that ranch of yours."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_flag_tacoma_started" } }),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_RANCH",
        },
        { text = ccb.content.text("What were you saying before that?"), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
