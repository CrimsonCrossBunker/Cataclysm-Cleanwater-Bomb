local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE",
    line = {
        joined = {
            ccb.content.text("*is a young man in his mid teens, wearing threadbare but clean work trousers and a plain shirt with a few holes in it.  He looks you up and down as you approach"),
            {
            when = predicates.wears("speaker", "badge_marshal"),
            yes = ccb.content.text(", then scowls as he spots the Old Guard Marshal badge gleaming on your chest.  \"I see that badge.  You should leave before my father spots it.\""),
            no = {
                when = predicates.any_equal({ "seen", { scope = "speaker", key = "isherwood_luke_marshal_badge" } }),
                yes = ccb.content.text(", and nods once when he sees you've taken off your marshal badge.  \"Tread carefully around here, we don't have a lot of respect for your type of lawman.\""),
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text(", then raises a hand to greet you.  \"Hello.\""),
                    no = ccb.content.text(", then raises his hand to his forehead in an old fashioned hat-tipping sort of gesture.  \"Hello.\""),
                },
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_LUKE",
            when = predicates.wears("speaker", "badge_marshal"),
            actions = { actions.set_actor_value("speaker", "isherwood_luke_marshal_badge", "seen") },
            opinion = { trust = -20, value = -20 },
        },
        {
            text = ccb.content.text("What's wrong with me being a marshal?"),
            next_topic = "TALK_ISHERWOOD_LUKE_Marshal",
            when = predicates.all({ predicates.any_equal({ "seen", { scope = "speaker", key = "isherwood_luke_marshal_badge" } }), predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
        {
            text = ccb.content.text("Your dad said you were out here fixing up this place."),
            next_topic = "TALK_ISHERWOOD_LUKE_TALK1",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Eddie_Isherwood" } }),
            actions = { actions.set_actor_value("speaker", "u_met_Luke_Isherwood", "yes"), actions.set_actor_value("speaker", "u_met_an_isherwood", "yes") },
        },
        {
            text = ccb.content.text("How are those books doing for you?"),
            next_topic = "TALK_ISHERWOOD_LUKE_BOOKS1",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_did_luke_missions" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } })) }),
        },
        {
            text = ccb.content.text("Chris and I have a little project for you that we've cooked up, if you're interested."),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb",
            when = predicates.handler("dlg_p_dda_da2ff9750594"),
        },
        {
            text = ccb.content.text("We've got the truck, what's next?"),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan_Part_2",
            when = predicates.handler("dlg_p_dda_06109bce9e89"),
        },
        {
            text = ccb.content.text("I've got the dynamite you requested, I can't wait to see how this works out."),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan_Done",
            when = predicates.all({ predicates.has_mission("MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES"), predicates.has_inventory("speaker", "dynamite", 20) }),
            actions = { actions.transfer_items("dynamite", 20), actions.finish_mission("MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES", { success = true }) },
        },
        {
            text = ccb.content.text("How are those books doing for you?"),
            next_topic = "TALK_ISHERWOOD_LUKE_BOOKS2",
            when = predicates.handler("dlg_p_dda_17932503160e"),
        },
        {
            text = ccb.content.text("How are those books doing for you?"),
            next_topic = "TALK_ISHERWOOD_LUKE_BOOKS3",
            when = predicates.handler("dlg_p_dda_a0ce66305f5e"),
        },
        {
            text = ccb.content.text("Hey, what are you doing out here?"),
            next_topic = "TALK_ISHERWOOD_LUKE2",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Marshal",
    line = ccb.content.text("I don't see how it's much of your business what our story is.  You can try asking my dad, Eddie, if you really want.  Just don't start acting like some little piece of tin in your pocket means you can come in like you own the place."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "isherwood_luke_marshal_questions", "known") },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
