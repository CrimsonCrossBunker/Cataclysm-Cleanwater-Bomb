local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- uses bastardized anglicised ancient Akkadian, because why English and why accurately shown in cuniform?  Probably doesn't make real sense, which is fine. KÁ refers to the cuniform sign for 'gate,' used in the Epic of Gilgamesh.
ccb.content.define_dialogue_topic {
    id = "COMP_LS_SD_Entrance_Controls",
    line = ccb.content.text("&You see a black computer screen.  A circular cursor flickers on the screen, displayed at a very low resolution.  The cursor looks to be controlled by a red trackball on the machine.  Only one option appears:\n\n<color_light_green> [KÁ]</color>"),
    replies = {
        {
            text = ccb.content.text("[Select \"KÁ\"] "),
            next_topic = "COMP_LS_SD_Entrance_Controls2",
        },
        {
            text = ccb.content.text("[Plug in the Exodii electronic storage device]"),
            when = predicates.has_inventory("speaker", "exodii_usb_stick", 1),
            next_topic = "COMP_LS_SD_Download_Data",
        },
        { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" },
    },
}
