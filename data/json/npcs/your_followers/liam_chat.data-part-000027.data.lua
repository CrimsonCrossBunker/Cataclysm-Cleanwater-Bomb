local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
    line = ccb.content.text("Yeah.  It sounds like we're gonna need some serious mechanical or electrical know-how if we're gonna take it down.  Big responsibility.  If we can pull it off, though, it'll be *so cool*."),
    replies = {
        {
            text = ccb.content.text("Do you think you know enough to handle the technical side?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills_hasskills",
            when = predicates.handler("dlg_p_dda_68153d1aa270"),
        },
        {
            text = ccb.content.text("Do you think you know enough to handle the technical side?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills_noskills",
            when = predicates.handler("dlg_p_dda_a8b242afed9f"),
        },
        {
            text = ccb.content.text("Yeah.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
