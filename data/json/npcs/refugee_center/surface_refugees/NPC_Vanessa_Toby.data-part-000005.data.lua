local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Situation",
    line = {
        joined = {
            {
            when = predicates.handler("dlg_p_dda_defb5ab5fdd2"),
            yes = ccb.content.text("Well, I'm stuck in a dank shitty brick building with two dozen strangers, the world's dead"),
            no = ccb.content.text("You want the sarcastic version, or the really sarcastic version?  I'm stuck in a dank shitty brick building with two dozen strangers, the world's dead"),
        },
            {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_flag_tacoma_started" } }),
            yes = ccb.content.text(", and all anyone will talk about is this new ranch they're building, as though it'll solve all our food problems"),
            no = ccb.content.text(", and there's not enough food to go around"),
        },
            {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Vanessa_Mission1" } }),
            yes = ccb.content.text(".  At least I can do some work to keep me busy though, and the extra merch does go a long way to keeping my belly full.  People like getting a good haircut."),
            no = ccb.content.text(".  Why don't you fuckin' figure it out?"),
        },
        },
    },
}
