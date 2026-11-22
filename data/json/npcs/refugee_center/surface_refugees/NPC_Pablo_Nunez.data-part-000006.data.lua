local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Situation",
    line = {
        when = predicates.handler("dlg_p_dda_defb5ab5fdd2"),
        yes = ccb.content.text("It's pretty tough here.  People have made so much effort to make things better, and the group is kind of coming together, but I just don't feel like I could ever belong, you know?  I need somewhere with a sky, and a little privacy."),
        no = ccb.content.text("It's pretty tough here.  We're packed into too small a location with too many people.  Everyone is dealing with their own trauma.  Rhy is trying to help out, but she can't be a proper counselor in these circumstances.  I don't know how we're going to survive for long.  As for me, I wish I could be anywhere but here.  I need to see the sky again, or I'm going to go insane."),
    },
    replies = {
        {
            text = ccb.content.text("Why not move to the Tacoma Commune?"),
            next_topic = "TALK_REFUGEE_Pablo_Tacoma",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_flag_tacoma_started" } }), predicates.negate(predicates.has_mission("MISSION_TACOMA_Nunez")) }),
            actions = { actions.assign_mission("MISSION_TACOMA_Nunez") },
        },
        {
            text = ccb.content.text("I've got a secure base.  You and your wife could come with me."),
            next_topic = "TALK_REFUGEE_Pablo_Recruit",
            when = predicates.handler("dlg_p_dda_451497940a38"),
            actions = { actions.set_actor_value("speaker", "recruit_general_Pablo_ask_recruit", "yes") },
        },
    },
}
