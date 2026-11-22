local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_INTERCOM",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_balthazar_u_discovered_balthazar_fac" } }),
        yes = {
            choices = {
                ccb.content.text("As soon as you walk up to the intercom it turns on"),
                ccb.content.text("Once you get close enough, the intercom crackles on"),
                ccb.content.text("The wiring on this intercom is out for anyone to see"),
                ccb.content.text("You hear some static come through the tinny speaker"),
            },
        },
        no = ccb.content.text("After some brief static you hear a voice coming through with a crackle and a pop \"..llo?  Hello?  Is someone there?\""),
    },
    replies = {
        {
            text = ccb.content.text("Hello?"),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_balthazar_u_discovered_balthazar_fac" } }),
        },
        {
            text = ccb.content.text("[Clear your throat.]"),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_balthazar_u_discovered_balthazar_fac" } }),
        },
        {
            text = ccb.content.text("I'm here."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_balthazar_u_discovered_balthazar_fac" } })),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_d928477b785d") },
            success = { next_topic = "TALK_BALTHAZAR_MEET_WEAK" },
            failure = { next_topic = "TALK_BALTHAZAR_MEET_STRONG" },
        },
        {
            text = ccb.content.text("Who is this?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_balthazar_u_discovered_balthazar_fac" } })),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_d928477b785d") },
            success = { next_topic = "TALK_BALTHAZAR_MEET_WEAK" },
            failure = { next_topic = "TALK_BALTHAZAR_MEET_STRONG" },
        },
        {
            text = ccb.content.text("Walk away."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_INTERCOM_MAIN",
    line = {
        choices = {
            ccb.content.text("Yes?"),
            ccb.content.text("Hmm?"),
            ccb.content.text("What is it?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can we trade?"),
            next_topic = "TALK_BALTHAZAR_NO_TRADE_YET",
        },
        {
            text = ccb.content.text("Tell me your story."),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_d928477b785d") },
            success = { next_topic = "TALK_BALTHAZAR_SELF_WEAK" },
            failure = { next_topic = "TALK_BALTHAZAR_SELF_STRONG" },
        },
        {
            text = ccb.content.text("Why don't these robots attack me?"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_d928477b785d") },
            success = { next_topic = "TALK_BALTHAZAR_ROBOTS_WEAK" },
            failure = { next_topic = "TALK_BALTHAZAR_ROBOTS_STRONG" },
        },
        {
            text = ccb.content.text("Here are the solar panels."),
            next_topic = "TALK_BALTHAZAR_SOLAR_PANEL",
            when = predicates.has_mission("MISSION_GET_SOLAR_PANELS_BALTHAZAR"),
        },
        {
            text = ccb.content.text("Walk away."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SOLAR_PANEL",
    line = ccb.content.text("You brought solar panels?!"),
    replies = {
        {
            text = ccb.content.text("Here you go."),
            next_topic = "TALK_BALTHAZAR_SOLAR_PANEL_REWARD_SMALL",
            when = predicates.handler("dlg_p_dda_f72fc90979eb"),
            switch = true,
        },
        {
            text = ccb.content.text("Here you go."),
            next_topic = "TALK_BALTHAZAR_SOLAR_PANEL_REWARD_MEDIUM",
            when = predicates.handler("dlg_p_dda_d930ca90f1e9"),
            switch = true,
        },
        {
            text = ccb.content.text("Here you go."),
            next_topic = "TALK_BALTHAZAR_SOLAR_PANEL_REWARD_BIG",
            when = predicates.handler("dlg_p_dda_e34b358e0efc"),
            switch = true,
        },
        {
            text = ccb.content.text("On second thought, I need a bit longer."),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
        {
            text = ccb.content.text("Walk away."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SOLAR_PANEL_REWARD_SMALL",
    line = ccb.content.text("Thank you so much, I'll send some bullets and a gun over."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_5aa3e3b65e71"), actions.finish_mission("MISSION_GET_SOLAR_PANELS_BALTHAZAR", { success = true }), actions.handler("dlg_a_dda_d6b240115975") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SOLAR_PANEL_REWARD_MEDIUM",
    line = ccb.content.text("Thank you so much, I'll give you all I have to give right now."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_2ac011cb8367"), actions.finish_mission("MISSION_GET_SOLAR_PANELS_BALTHAZAR", { success = true }), actions.handler("dlg_a_dda_fcbb73a97021") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SOLAR_PANEL_REWARD_BIG",
    line = ccb.content.text("Thank you so much.  As promised, all I can spare and a bot."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_c677088fadf6"), actions.finish_mission("MISSION_GET_SOLAR_PANELS_BALTHAZAR", { success = true }), actions.handler("dlg_a_dda_395bc59621fd") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}
