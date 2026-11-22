local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MENTOR",
    line = {
        when = predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" }),
        yes = ccb.content.text("Sorry I must go.  Bye!"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_mentor" } }),
            yes = {
                choices = {
                    ccb.content.text("Welcome back."),
                    ccb.content.text("Hello again."),
                },
            },
            no = ccb.content.text("Welcome.  What do you seek here?  Fortune?  Safety?  A friend?  A mentor?  What brought you here?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I want to talk."),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("I want a mentor."),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("I want to kill vampires."),
            next_topic = "TALK_VAMPIRE_MENTOR_KILLING",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("I've done it.  I am now a true vampire."),
            next_topic = "TALK_VAMPIRE_MENTOR_TRUEVAMP",
            when = predicates.all({ predicates.has_trait("speaker", "VAMPIRE4"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "told_about_trueness" } })), predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })) }),
            actions = { actions.set_actor_value("speaker", "told_about_trueness", "yes") },
        },
        {
            text = ccb.content.text("Before, you said there was more that I needed to learn?"),
            next_topic = "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH",
            when = predicates.handler("dlg_p_xedra_evolved_35cc231b3499"),
        },
        {
            text = ccb.content.text("I've lost the book you gave me.  Do you have another?"),
            next_topic = "TALK_VAMPIRE_MENTOR_BOOK_NEED_NEW",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "received_mentor_book" } }), predicates.negate(predicates.has_item("speaker", "vampire_mentor_book")), predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })) }),
        },
        {
            text = ccb.content.text("I have brought back the components you need for the ritual."),
            next_topic = "TALK_VAMPIRE_MENTOR_MAKE_TIER_5",
            when = predicates.all({ predicates.has_mission("GET_COMPONENTS_FOR_TIER_5"), predicates.has_item("speaker", "stormwrought_blood_charged"), predicates.has_inventory("speaker", "concentrated_underhill_essence", 400), predicates.has_item("speaker", "dream_drainer_heart"), predicates.has_item("speaker", "moonstruck_pearl"), predicates.has_item("speaker", "abyssal_hunger_shard") }),
            actions = { actions.transfer_items("stormwrought_blood_charged"), actions.transfer_items("concentrated_underhill_essence", 400), actions.transfer_items("dream_drainer_heart"), actions.transfer_items("moonstruck_pearl"), actions.transfer_items("abyssal_hunger_shard") },
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" }),
            actions = { actions.handler("dlg_a_xedra_evolved_aa606712f66b") },
        },
        {
            text = ccb.content.text("Do you want to chat for a bit?"),
            next_topic = "TALK_MENTOR_NO_CHAT",
            when = predicates.all({ predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })), predicates.has_trait("interlocutor", "PSYCHOPATH") }),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("Do you want to chat for a bit?"),
            next_topic = "TALK_MENTOR_CHAT",
            when = predicates.all({ predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOPATH")) }),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("Just passing through, don't mind me."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_TALK" },
    line = ccb.content.text("What do you wish to discuss?"),
    replies = {
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_VAMPIRE_MENTOR_SELF" },
        { text = ccb.content.text("What is this place?"), next_topic = "TALK_VAMPIRE_MENTOR_PLACE" },
        {
            text = ccb.content.text("Can I do something for you?"),
            next_topic = "TALK_VAMPIRE_MENTOR_ASSISTANCE",
        },
        {
            text = ccb.content.text("What did you meant by \"mentor\"?"),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}
