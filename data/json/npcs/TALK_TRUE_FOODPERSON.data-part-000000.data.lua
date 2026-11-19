local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TRUE_FOODPERSON",
    line = {
        when = predicates.wears("speaker", "foodperson_mask"),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_has_talked" } }),
            yes = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } }),
                yes = ccb.content.text("Greetings friend, it's nice to see you."),
                no = ccb.content.gendered_line("So you're back… explain yourself!", { "speaker" }),
            },
            no = ccb.content.text("What sorcery is this?"),
        },
        no = {
            when = predicates.wears("speaker", "foodkid_badge"),
            yes = ccb.content.text("Welcome home Foodkid!"),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodperson_impressed" } }),
                yes = ccb.content.text("Greetings friend, it's nice to see you."),
                no = {
                    when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_has_talked" } }),
                    yes = ccb.content.text("Still here?  Take your time, it's rough out there."),
                    no = ccb.content.text("Greeting citizen, what brings you to the FoodLair?"),
                },
            },
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_foodperson_has_talked", "yes"),
            },
        },
    },
    replies = {
        {
            when = predicates.any({ predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_has_talked" } }), predicates.negate(predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") })) }), predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) }) }),
            text = ccb.content.text("Hey.  Let's chat for a second."),
            next_topic = "TALK_FOODPERSON_MAIN",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_has_talked" } })), predicates.all({ predicates.negate(predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") })), predicates.negate(predicates.wears("speaker", "foodkid_badge")) }) }),
            text = ccb.content.text("Greetings… Foodperson?"),
            next_topic = "TALK_FOODPERSON_INTRODUCTION",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } })), predicates.negate(predicates.has_trait("speaker", "PROF_FOODP")), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }),
            text = ccb.content.text("I am you but from an alternate reality."),
            trial = {
                kind = "lie",
                difficulty = 10,
                modifiers = { { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 1 } },
            },
            success = { next_topic = "TALK_FOODPERSON_MULTIVERSE", opinion = { trust = 2, value = 2 } },
            failure = { next_topic = "TALK_FOODPERSON_ONLYONE", opinion = { trust = -5, value = -5 } },
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } })), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }), predicates.has_trait("speaker", "PROF_FOODP") }),
            text = ccb.content.text("I am Foodperson, who are YOU?"),
            next_topic = "TALK_FOODPERSON_TWO",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } })), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }), predicates.has_trait("speaker", "PROF_FOODP") }),
            text = ccb.content.text("There is only one real Foodperson!"),
            next_topic = "TALK_FOODPERSON_ONLYONE",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } })), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }), predicates.negate(predicates.has_trait("speaker", "PROF_FOODP")) }),
            text = ccb.content.text("I am the REAL Foodperson!"),
            next_topic = "TALK_FOODPERSON_ONLYONE",
        },
        {
            text = ccb.content.text("So, you are a REAL FOODPERSON, right?  You know my <name_g> over there?  You know that you ruined his legacy?"),
            when = predicates.has_mission("MISSION_pizzaiolo_2"),
            next_topic = "TALK_TRUE_FOODPERSON_pizzaiolo",
        },
        {
            text = ccb.content.text("Nevermind me, I'm just going to leave."),
            next_topic = "TALK_DONE",
        },
    },
}
