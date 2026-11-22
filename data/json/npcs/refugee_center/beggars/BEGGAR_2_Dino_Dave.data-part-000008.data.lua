local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_PERMISSION",
    line = ccb.content.text("The roof!  So high!  So lofty!  I can hardly believe it!  This will be a nicer house than I had before everything went funny.  I can watch out, I'm happy to do that.  And it'll be nice to still have a bathroom!  Come see me there, my friend.  I will not disappoint you."),
    on_enter = {
        { actions = { actions.finish_mission("MISSION_BEGGAR_2_PERMISSION", { success = true }), actions.set_first_topic("TALK_DINODAVE_1"), actions.update_map("cardboard_castle_1_main", "evac_center_13_z1"), actions.handler("dlg_a_dda_4add61d2f558") } },
    },
    replies = {
        {
            text = ccb.content.text("I'll see you on the rooftop.  Good luck, Dave."),
            next_topic = "TALK_DONE",
        },
    },
}
