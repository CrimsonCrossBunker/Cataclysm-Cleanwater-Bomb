local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_NOEMAILS",
    line = ccb.content.text("WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = { { text = ccb.content.text("OK"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOCUMENTS",
    line = ccb.content.text("Select the document you would like to view."),
    replies = {
        { text = ccb.content.text("everything.txt"), next_topic = "COMP_PREPPER_1_DOC_EVERYTHING" },
        {
            text = ccb.content.text("robert williamson.txt"),
            next_topic = "COMP_PREPPER_1_DOC_ROBERT",
        },
        { text = ccb.content.text("shopping list.txt"), next_topic = "COMP_PREPPER_1_DOC_SHOPPING" },
        { text = ccb.content.text("MVI 0022.mov"), next_topic = "COMP_PREPPER_1_DOC_THEFOOTAGE" },
        { text = ccb.content.text("Back"), next_topic = "COMP_PREPPER_1_MAIN" },
    },
}
