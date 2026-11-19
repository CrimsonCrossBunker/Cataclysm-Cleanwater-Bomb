local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_SHILLS_BRANCH",
    line = ccb.content.text("Shady Hills Corporation.\n You are logged in as: Branch Manager.\n\nWARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("Access Messages"), next_topic = "COMP_SHILLS_BRANCH_EMAILS" },
        { text = ccb.content.text("Access Main Drive"), next_topic = "COMP_SHILLS_BRANCH_ERROR" },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SHILLS_BRANCH_EMAILS",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n ERROR REFRESHING MESSAGES.  NOT ALL MESSAGES MAY BE DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("[!]RE: Important Status Update"),
            next_topic = "COMP_SHILLS_BRANCH_EMAILS_STATUS",
        },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_SHILLS_BRANCH" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SHILLS_BRANCH_EMAILS_STATUS",
    line = ccb.content.text("FROM: Kristi Gordee, SVP Operations\n  TO: [Branch Managers], [Community Managers]\n  RE: Important Status Update\n\n Everyone,\n You are to follow your appropriate lockdown protocols at your discretion.  With the recent events as they are, we must do our utmost to ensure that our goals remain priority.\n\n Branch Managers - your deliveries will have an altered schedule.  I will send a separate email with details.  Ensure the hidden safe rooms are properly secured.\n Community Managers - Lockdown the community appropriately.  Tell the residents that it is for their protection, but do not let them leave.  We need them for the Big Pappy project to be successful.  I am going to send you some contacts who can discreetly install a heavy security gate.\n\n You will continue to receive your bonus pay as agreed upon.  Do not lose sight of our important endgame."),
    replies = { { text = ccb.content.text("RETURN TO MESSAGES"), next_topic = "COMP_SHILLS_BRANCH_EMAILS" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SHILLS_BRANCH_ERROR",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = { { text = ccb.content.text("RETURN TO PREVIOUS PAGE"), next_topic = "COMP_SHILLS_BRANCH" } },
}
