local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_BIONICS",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_surgery" } }),
        yes = ccb.content.text("If you mean something like pacemaker, then maybe.  What's the trouble?"),
        no = ccb.content.text("If you mean something like pacemaker, we can't really do much without anesthesia."),
    },
    replies = {
        {
            text = ccb.content.text("No, i mean something, eeh, more sci-fi.  There are robo-guys in a stone castle, they say they have such technology.  They even installed something into me, look!"),
            next_topic = "TALK_RANCH_DOCTOR_BIONICS_DUNNO",
            when = predicates.handler("dlg_p_dda_ccdeb4054639"),
        },
        {
            text = ccb.content.text("No, i mean something, eeh, more sci-fi.  There are robo-guys in a stone castle, they say they have such technology."),
            next_topic = "TALK_RANCH_DOCTOR_BIONICS_DUNNO",
            when = predicates.handler("dlg_p_dda_d84e565d8670"),
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_BIONICS_DUNNO",
    line = {
        when = predicates.handler("dlg_p_dda_ccdeb4054639"),
        yes = ccb.content.text("Curious.  Sorry, i have no idea how it works, and i'd be afraid to even touch this parts."),
        no = ccb.content.text("Are you all right?  Sci-fi bionic by robots in a stone castle?  I have some antipsychotics, if it helps."),
    },
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
