local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "OFFWORLD_ACQUISITIONS_RAW_MATERIALS_COMPUTER_MAIN",
    line = ccb.content.text("&This computer still has power, but the screen displays a simple message: \"ERROR, access denied.  Raw materials access requires appropriate clearance.  Please contact your supervisor if you have received this message in error.\"  A panel below the screen seems ready to accept some sort of id."),
    replies = {
        {
            text = ccb.content.text("Swipe credentials."),
            when = predicates.has_item("speaker", "id_science"),
            next_topic = "OFFWORLD_ACQUISITIONS_RAW_MATERIALS_COMPUTER_ID",
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}
