local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LAPIN_RESOURCES",
    line = ccb.content.text("The bunnies and I love adding some diversity to the menu and I always need materials for patching fences."),
    repeat_replies = {
        {
            items = {
                "log", "2x4", "wood_panel", "wood_sheet", "material_sand", "clay_lump", "nail",
                "lc_wire", "apple", "banana", "orange", "blueberries", "strawberries", "raspberries",
                "huckleberries", "mulberries", "plums", "carrot", "cabbage", "lettuce", "onion",
            },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_WARRENER",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
