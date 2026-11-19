local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TANK",
    line = ccb.content.text("Kinda wonder why she didn't just get us to get her a compressor, but she probably has her reasons.\"  You notice a bit of an odd tone to his voice.  \"Maybe we could take apart a big compressor for her, the tank would probably be perfect."),
    on_enter = {
        {
            once = "liam_crush1",
            actions = { actions.set_actor_value("speaker", "u_liam_jenny_feelings", "crush_suspected") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Dude.  You have a crush on Jenny."),
            next_topic = "TALK_Liam_Jenny_CrushAccuse",
            when = predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })),
        },
        {
            text = ccb.content.text("Thanks, man.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXT",
    line = ccb.content.text("*blushes, for some reason.  \"Uh, yeah.  Gun books, hey?  I guess we should look in um, gun stores or libraries?  Or high school lockers, haha.  Oh, that made me sad.\""),
    on_enter = {
        {
            once = "liam_crush1",
            actions = { actions.set_actor_value("speaker", "u_liam_jenny_feelings", "crush_suspected") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Dude.  You have a crush on Jenny."),
            next_topic = "TALK_Liam_Jenny_CrushAccuse",
            when = predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })),
        },
        {
            text = ccb.content.text("Thanks, man.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
