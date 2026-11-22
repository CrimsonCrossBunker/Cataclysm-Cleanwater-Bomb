local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_9",
    line = ccb.content.text("Say, I don't mean to get you in any trouble or nothing, if any folks still care about that, but you haven't seen any green around town, have ya?"),
    replies = {
        {
            text = ccb.content.text("What?"),
            next_topic = "TALK_REFUGEE_Draco_10_question",
        },
        {
            text = ccb.content.text("WHAT."),
            next_topic = "TALK_REFUGEE_Draco_10_disapprove",
        },
        {
            text = ccb.content.text("Oh yeah, some people've been growing it in their basements."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
            actions = { actions.handler("dlg_a_dda_4776232023da") },
        },
        {
            text = ccb.content.text("I'm not comfortable with where this is going."),
            next_topic = "TALK_REFUGEE_Draco_10_disapprove",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_question",
    line = ccb.content.gendered_line("Where you say you're from again?  You're not as worldly as you look.  I'm talking about weed.  Marijuana.  Wondered if you've happened upon any.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Oh.  Uh, sure."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
        },
        {
            text = ccb.content.text("Right, of course I knew that!  There's tons of the stuff out there for the taking."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
            actions = { actions.handler("dlg_a_dda_4776232023da") },
        },
        {
            text = ccb.content.text("Nope, sorry."),
            next_topic = "TALK_REFUGEE_Draco_10_hasnt_found_weed",
        },
        {
            text = ccb.content.text("I'm not doing this."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_disapprove",
    line = ccb.content.text("Hey, don't get all serious on me all of a sudden.  It helps me relax.  Lubricates my joints.  Eases the pain, ya know?  Makes every day a bit more bearable."),
    replies = {
        {
            text = ccb.content.text("I can help."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
            actions = { actions.handler("dlg_a_dda_4776232023da") },
        },
        {
            text = ccb.content.text("Find somebody else, dude."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_approve",
    line = {
        when = predicates.has_effect("interlocutor", "u_sold_to_Draco"),
        yes = ccb.content.text("Yeah, no worries, though.  I'm good at the moment.  Ask me again later and maybe I'll have scrounged up some more cash for you."),
        no = ccb.content.text("Amazing!  My lucky day.  Let's see here.  What can I offer… I can scrounge up some merch bucks for, say, five joints or joints-worth of the good stuff."),
    },
    replies = {
        {
            text = ccb.content.text("You have yourself a deal.  Here's the marijuana."),
            next_topic = "TALK_REFUGEE_Draco_10_sold",
            when = predicates.all({ predicates.has_inventory("speaker", "weed", 5), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } })), predicates.negate(predicates.has_effect("interlocutor", "u_sold_to_Draco")) }),
            actions = { actions.transfer_items("weed", 5), actions.handler("dlg_a_dda_9fa754efa91b"), actions.add_effect("interlocutor", "u_sold_to_Draco", { turns = 240000 }) },
        },
        {
            text = ccb.content.text("You have yourself a deal.  Here's the marijuana."),
            next_topic = "TALK_REFUGEE_Draco_10_sold",
            when = predicates.all({ predicates.has_inventory("speaker", "weed", 5), predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } }), predicates.negate(predicates.has_effect("interlocutor", "u_sold_to_Draco")) }),
            actions = { actions.transfer_items("weed", 5), actions.handler("dlg_a_dda_16fda14fd72a"), actions.add_effect("interlocutor", "u_sold_to_Draco", { turns = 200000 }) },
        },
        {
            text = ccb.content.text("You have yourself a deal.  Here's some joints."),
            next_topic = "TALK_REFUGEE_Draco_10_sold",
            when = predicates.all({ predicates.has_inventory("speaker", "joint", 5), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } })), predicates.negate(predicates.has_effect("interlocutor", "u_sold_to_Draco")) }),
            actions = { actions.transfer_items("joint", 5), actions.handler("dlg_a_dda_9fa754efa91b"), actions.add_effect("interlocutor", "u_sold_to_Draco", { turns = 240000 }) },
        },
        {
            text = ccb.content.text("You have yourself a deal.  Here's some joints."),
            next_topic = "TALK_REFUGEE_Draco_10_sold",
            when = predicates.all({ predicates.has_inventory("speaker", "joint", 5), predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } }), predicates.negate(predicates.has_effect("interlocutor", "u_sold_to_Draco")) }),
            actions = { actions.transfer_items("joint", 5), actions.handler("dlg_a_dda_16fda14fd72a"), actions.add_effect("interlocutor", "u_sold_to_Draco", { turns = 200000 }) },
        },
        {
            text = ccb.content.text("Oh, alright.  I'll be back later with the goods."),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        {
            text = ccb.content.text("On second thought, maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}
