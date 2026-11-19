local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK_RESOURCES",
    line = ccb.content.text("Excellent.  What've you brought us?"),
    repeat_replies = {
        {
            items = {
                "log", "2x4", "wood_panel", "wood_sheet", "material_sand", "clay_lump", "nail",
                "lc_wire", "rock", "lc_steel_chunk", "mc_steel_chunk", "hc_steel_chunk",
                "ch_steel_chunk", "qt_steel_chunk", "lc_steel_lump", "mc_steel_lump", "hc_steel_lump",
                "ch_steel_lump", "qt_steel_lump",
            },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
