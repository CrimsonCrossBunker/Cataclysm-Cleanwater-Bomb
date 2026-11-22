local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Tacoma2",
    line = ccb.content.text("This is amazing news!  Thank you so much!  I've talked to some of the traders who have been there and I really think I can help, mostly with the manual labor but also with the bookkeeping end.  It sounds so much better than this place.  Thanks, my friend!  We'll get packing, and see if we can get a place on the next caravan out.  It'll be a little while I'm sure, but at least our child won't be born in captivity."),
    on_enter = {
        { actions = { actions.finish_mission("MISSION_TACOMA_Nunez", { success = true }), actions.handler("w16b_a_dda_346a0ec563b7"), actions.clear_actor_value("speaker", "tacoma_nunez_trailer_arrive") } },
    },
}
