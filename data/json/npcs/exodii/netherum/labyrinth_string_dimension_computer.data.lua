local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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

ccb.content.define_dialogue_topic {
    id = "COMP_LS_SD_Download_Data",
    line = ccb.content.text("&The screen starts to auto-populate with green text, and the process speeds up rapidly until it is just a blur.  It suddenly stops and the terminal beeps - you then hear a ka-thunk as the storage device is ejected from the machine."),
    replies = {
        {
            text = ccb.content.text("[Take the Exodii electronic storage device]"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_2382c546991c") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_SD_Entrance_Controls2",
    line = ccb.content.text("&The screen starts to auto-populate with text, and then two options appear at the bottom:\n\n<color_light_green> @Awīlu > īnu -nērubu -KÁ -@Awīlu\n<color_light_green> nērub ašram ellam\n\n<color_yellow> [annu]\n\n<color_yellow> [adīni lā]"),
    replies = {
        {
            text = ccb.content.text("[Select \"annu\"]"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_aa509652e8e5") },
        },
        {
            text = ccb.content.text("[Select \"adīni lā\"]"),
            next_topic = "COMP_LS_SD_Entrance_Controls",
        },
    },
}
