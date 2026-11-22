local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ISHERWOOD_CHRIS" },
    replies = {
        {
            text = ccb.content.text("Hi, your dad asked me to come find you, said you've been looking for your uncle."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TALK1",
            when = predicates.handler("dlg_p_dda_a01355dd84c8"),
            actions = { actions.set_actor_value("speaker", "u_met_Chris_Isherwood", "yes"), actions.set_actor_value("speaker", "u_met_an_isherwood", "yes") },
        },
        {
            text = ccb.content.text("I was talking to Luke earlier, said you had some interesting ideas about the world ending.  Is it tied to Barry's abduction?"),
            next_topic = "TALK_CHRIS_THEORIES",
            when = predicates.handler("dlg_p_dda_4a15715ed8e3"),
        },
        {
            text = ccb.content.text("Hi, what have you been up to lately."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TALK2",
            when = predicates.handler("dlg_p_dda_3563a6faba65"),
        },
        {
            text = ccb.content.text("Can I hear your ideas about the world ending, now that we saved Barry?"),
            next_topic = "TALK_CHRIS_THEORIES",
            when = predicates.handler("dlg_p_dda_c60e2fef403c"),
        },
        {
            text = ccb.content.text("Have you had any ideas for what your family could do?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN",
            when = predicates.handler("dlg_p_dda_e23779bc32b5"),
        },
        {
            text = ccb.content.text("Do you think we're ready to try this again?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
            when = predicates.handler("dlg_p_dda_9a6581117466"),
        },
        {
            text = ccb.content.text("Do you think we're ready to try this again?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN2",
            when = predicates.handler("dlg_p_dda_1b4379fba2e7"),
        },
        {
            text = ccb.content.text("I've got some SWAT gear that should work for the assault."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_352673c69d29"),
        },
        {
            text = ccb.content.text("I've got enough SWAT gear to set everyone up for the assault."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Done",
            when = predicates.handler("dlg_p_dda_58b387811876"),
            actions = { actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1_GET_GEAR", { success = true }) },
        },
        {
            text = ccb.content.text("[LIE] I tried to get the SWAT gear, but it looks like someone looted it before I could get there."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Fail",
            when = predicates.handler("dlg_p_dda_f3dffbfae44f"),
            actions = { actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1_GET_GEAR", { success = false }) },
        },
        {
            text = ccb.content.text("I've got enough bags to set up a defensive wall."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall_Done",
            when = predicates.handler("dlg_p_dda_c74ca0bd1916"),
            actions = { actions.transfer_items("bag_canvas", 20), actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS", { success = true }) },
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS",
    line = {
        joined = {
            ccb.content.text("*is a young man, perhaps in his early twenties or late teens.  He eyes you up and down.  \""),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text("I see that badge.  You need to leave our land, my relatives have no fondness for Marshals.\""),
                no = {
                    when = predicates.any_equal({ "seen", { scope = "speaker", key = "isherwood_chris_marshal_badge" } }),
                    yes = ccb.content.gendered_line("I see you took the badge off.  Fine, then, but you'd better not let anyone here know you've got ties to the Marshals.\"", { "speaker" }),
                    no = ccb.content.text("Hi, what's up?\""),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_CHRIS",
            actions = { actions.set_actor_value("speaker", "isherwood_chris_marshal_badge", "seen") },
            opinion = { trust = -5, value = -5 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
    },
}
