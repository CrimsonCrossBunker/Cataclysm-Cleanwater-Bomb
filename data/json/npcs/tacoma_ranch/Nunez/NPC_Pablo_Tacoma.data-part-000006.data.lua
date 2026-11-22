local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_TACOMA_Pablo_2", "TALK_TACOMA_Pablo_Trailer1", "TALK_TACOMA_Pablo_Accounting1", "TALK_TACOMA_Pablo_Bakery1", "TALK_TACOMA_Pablo_Bakery-Firebricks1", "TALK_TACOMA_Pablo_Bakery-Engineer1", "TALK_TACOMA_Pablo_Bakery-RootCellar1" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("I heard you might be willing to trade for propane?"),
            next_topic = "TALK_TACOMA_Pablo_Propane1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_propane_scavenging" } }),
        },
        {
            text = ccb.content.text("Dana said you had some plans to build a bakery?"),
            next_topic = "TALK_TACOMA_Pablo_Bakery1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_tacoma_bakery" } }),
        },
        {
            text = ccb.content.text("I don't mind keeping my eye out for some firebricks for you."),
            next_topic = "TALK_TACOMA_Pablo_Bakery-Firebricks1",
            when = predicates.all({ predicates.any_equal({ "known_deleted", { scope = "speaker", key = "firebricks_tacoma_bakery" } }), predicates.negate(predicates.any_equal({ "helped", { scope = "speaker", key = "firebricks_tacoma_bakery" } })) }),
        },
        {
            text = ccb.content.text("I can pass a note to Jenny about helping with the mill designs, if you want."),
            next_topic = "TALK_TACOMA_Pablo_Bakery-Engineer1",
            when = predicates.all({ predicates.any_equal({ "known_deleted", { scope = "speaker", key = "message_jenny_tacoma_mill" } }), predicates.negate(predicates.any_equal({ "helped", { scope = "speaker", key = "message_jenny_tacoma_mill" } })) }),
        },
        {
            text = ccb.content.text("[Survival 4, Fabrication 4] I know how to build a good root cellar.  Here, let me show you."),
            next_topic = "TALK_TACOMA_Pablo_Bakery-RootCellar1",
            when = predicates.handler("dlg_p_dda_2a7e7eb6a6b0"),
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_TACOMA_Pablo_Firebrick",
    name = ccb.content.text("Get Pablo some fire bricks."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    item = "fire_brick",
    item_count = 20,
    dialogue = {
        describe = ccb.content.text("Find some fire bricks to help Pablo build an oven."),
        offer = ccb.content.text("n/a"),
        accepted = ccb.content.text("n/a"),
        rejected = ccb.content.text("n/a"),
        advice = ccb.content.text("n/a"),
        inquire = ccb.content.text("n/a"),
        success = ccb.content.text("n/a"),
        success_lie = ccb.content.text("n/a"),
        failure = ccb.content.text("n/a"),
    },
}

ccb.content.define_mission {
    id = "MISSION_TACOMA_Pablo_Message",
    name = ccb.content.text("Pass a message to Jenny Forcette."),
    goal = "MGOAL_NULL",
    difficulty = 2,
    value = 1000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Ask Jenny Forcette if she can help Pablo Nunez with his mill designs."),
        offer = ccb.content.text("n/a"),
        accepted = ccb.content.text("n/a"),
        rejected = ccb.content.text("n/a"),
        advice = ccb.content.text("n/a"),
        inquire = ccb.content.text("n/a"),
        success = ccb.content.text("n/a"),
        success_lie = ccb.content.text("n/a"),
        failure = ccb.content.text("n/a"),
    },
}
