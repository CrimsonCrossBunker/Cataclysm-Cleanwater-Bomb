local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO",
    line = ccb.content.text("Shady Hills Nursing Home.\n You are logged in as: Kristi Gordee, SVP Operations.\n\n WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("Access Messages"), next_topic = "COMP_NURSING_HOME_COO_EMAILS" },
        {
            text = ccb.content.text("Access Nursing Home Main Drive"),
            next_topic = "COMP_NURSING_HOME_COO_MAIN",
        },
        {
            text = ccb.content.text("Access Encrypted Drive"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR5",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_ERROR5",
    line = ccb.content.text("WARNING: Encrypted file.  Enter secure password."),
    replies = { { text = ccb.content.text("RETURN TO MAIN DRIVE"), next_topic = "COMP_NURSING_HOME_COO" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_EMAILS",
    line = ccb.content.text("Shady Hills Nursing Home.\n You are logged in as: Kristi Gordee, SVP Operations.\n\n WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n ERROR REFRESHING MESSAGES.  NOT ALL MESSAGES MAY BE DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("RE: Thank you for your order"),
            next_topic = "COMP_NURSING_HOME_COO_THANKS",
        },
        { text = ccb.content.text("RE: Budget"), next_topic = "COMP_NURSING_HOME_COO_BUDGET" },
        {
            text = ccb.content.text("RE: Kristi, Act Now and Save!"),
            next_topic = "COMP_NURSING_HOME_COO_ADVERT",
        },
        {
            text = ccb.content.text("RE: I am going to sue you"),
            next_topic = "COMP_NURSING_HOME_COO_LAWSUIT",
        },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_NURSING_HOME_COO" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_THANKS",
    line = ccb.content.text("FROM: Big Science Supply Depot\n TO: Kristi Gordee, SVP Operations\n RE: Thank you for your order\n\n Hi KRISTI GORDEE,\n\n We have received your order and will begin processing it immediately.\n 1x Jet Injector, RX12 by Rivtech\n\n You will receive an additional email when your order has shipped.\n Thank you for shopping BIG SCIENCE SUPPLY DEPOT!\n\n Please do not reply to this message as your reply will be routed to an unmonitored inbox.\n Questions?  Contact customer service xxx-xxx-xxxx."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_COO_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_BUDGET",
    line = ccb.content.text("FROM: Peter St. Travers, SVP Research & Development\n TO: Kristi Gordee, SVP Operations\n RE: Budget\n\n Hi KRISTI GORDEE,\n\n Kristi, please see attached for my budget proposal.\n We need more jet injectors.\n  I am on the verge of a breakthrough - you need to run interference on this Shepherds issue.\n - Peter"),
    replies = {
        {
            text = ccb.content.text("View Attachment"),
            next_topic = "COMP_NURSING_HOME_COO_ATTACHMENT",
        },
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_COO_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_ATTACHMENT",
    line = ccb.content.text("WARNING: Encrypted file.  Enter secure password."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_COO_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_ADVERT",
    line = ccb.content.text("FROM: Big Science Supply Depot\n TO: Kristi Gordee, SVP Operations\n RE: Kristi, Act Now and Save!\n\n Hi KRISTI GORDEE,\n\n We appreciate you choosing BIG SCIENCE SUPPLY DEPOT for all your laboratory needs!  Based on your purchase history, might we recommend some of the below items?\n Now on sale for 15% off!\n\n * Book: Advanced Physical Chemistry\n * 1,000pc Medical Gauze\n * Jumbo Chemistry Kit\n\n Thank you for shopping BIG SCIENCE SUPPLY DEPOT!\n\n Please do not reply to this message as your reply will be routed to an unmonitored inbox.\n Questions?  Contact customer service xxx-xxx-xxxx."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_COO_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_LAWSUIT",
    line = ccb.content.text("FROM: Leah Shepherds\n TO: Kristi Gordee, SVP Operations\n RE: I am going to sue you\n\n I don't know what kind of sick game your sham of a home is playing, but I am getting to the bottom of it.\n I've hired a lawyer and we are going to sue you.\n I should never have left grandpa in your care.\n How does a PERSON go missing from a NURSING HOME!?  I have pictures of how dirty and disgusting that place is.\n You should be ashamed!"),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_COO_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_MAIN",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR D766; UNABLE TO CONNECT TO MAIN SERVER.\n ERROR REFRESHING DATABASE.  ONLY CACHED INFORMATION DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("Access Resident Records"),
            next_topic = "COMP_NURSING_HOME_COO_RESIDENTS",
        },
        {
            text = ccb.content.text("Access Employee Records"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR",
        },
        {
            text = ccb.content.text("Access Budget Database"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR",
        },
        {
            text = ccb.content.text("Access Legal Files"),
            next_topic = "COMP_NURSING_HOME_COO_LEGAL",
        },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_NURSING_HOME_COO" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_ERROR",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO MAIN DRIVE"),
            next_topic = "COMP_NURSING_HOME_COO_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_ERROR2",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO RESIDENT RECORDS"),
            next_topic = "COMP_NURSING_HOME_COO_RESIDENTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_RESIDENTS",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR D766; UNABLE TO CONNECT TO MAIN SERVER.\n ERROR REFRESHING DATABASE.  ONLY CACHED INFORMATION DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("Resident: Pablo Shepherds"),
            next_topic = "COMP_NURSING_HOME_COO_PABLO",
        },
        {
            text = ccb.content.text("Resident: Nina Palmero"),
            next_topic = "COMP_NURSING_HOME_COO_NINA",
        },
        {
            text = ccb.content.text("Resident: Vorm E. Thracks"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        {
            text = ccb.content.text("Resident: Mord R. Yuni-Korne"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        {
            text = ccb.content.text("Resident: Robbie D. Nero"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        {
            text = ccb.content.text("Resident: Niklaus Kaje"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        {
            text = ccb.content.text("Resident: Lexi Lute-Thor"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_NURSING_HOME_COO" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_PABLO",
    line = ccb.content.text("RESIDENT NAME: Pablo Shepherds\n RESIDENT STATUS: Missing\n ASSIGNED ROOM: A01\n SOCIAL SECURITY NUMBER: xxx-xx-xxxx\n PAYMENT STATUS: Current\n PRIMARY PHYSICIAN: Peter St. Travers\n\n NOTES: Patient absent as of xx-xx-xxxx."),
    replies = {
        {
            text = ccb.content.text("Access Resident Healthcare Records"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        {
            text = ccb.content.text("Access Resident Legal Records"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        {
            text = ccb.content.text("RETURN TO RESIDENT RECORDS"),
            next_topic = "COMP_NURSING_HOME_COO_RESIDENTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_NINA",
    line = ccb.content.text("RESIDENT NAME: Nina Palmero\n RESIDENT STATUS: Resident\n ASSIGNED ROOM: B02\n SOCIAL SECURITY NUMBER: xxx-xx-xxxx\n PAYMENT STATUS: Current\n PRIMARY PHYSICIAN: Peter St. Travers\n\n NOTES: Patient has specialized prescription; must be administered by Primary Physician daily."),
    replies = {
        {
            text = ccb.content.text("Access Resident Healthcare Records"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        {
            text = ccb.content.text("Access Resident Legal Records"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR2",
        },
        {
            text = ccb.content.text("RETURN TO RESIDENT RECORDS"),
            next_topic = "COMP_NURSING_HOME_COO_RESIDENTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_LEGAL",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR D766; UNABLE TO CONNECT TO MAIN SERVER.\n ERROR REFRESHING DATABASE.  ONLY CACHED INFORMATION DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("Access Pending Lawsuits"),
            next_topic = "COMP_NURSING_HOME_COO_LAWSUITS",
        },
        {
            text = ccb.content.text("Access Closed Lawsuits"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR3",
        },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_NURSING_HOME_COO" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_ERROR3",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = { { text = ccb.content.text("RETURN TO LEGAL FILES"), next_topic = "COMP_NURSING_HOME_LEGAL" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_LAWSUITS",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR D766; UNABLE TO CONNECT TO MAIN SERVER.\n ERROR REFRESHING DATABASE.  ONLY CACHED INFORMATION DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("Pending: Pablo Shepherds"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Vorm E. Thracks"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Mord R. Yuni-Korne"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Nina Palmero"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Niklaus Kaje"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Lexi Lute-Thor"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Robbie D. Nero"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Jimbob Jones"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Heather Feathers"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Shania Moses"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Elle Jackson-Samuels"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Walter Pinkman"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("Pending: Gustavo Hermanos"),
            next_topic = "COMP_NURSING_HOME_COO_ERROR4",
        },
        {
            text = ccb.content.text("RETURN TO LEGAL FILES"),
            next_topic = "COMP_NURSING_HOME_COO_LEGAL",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_COO_ERROR4",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO PREVIOUS PAGE"),
            next_topic = "COMP_NURSING_HOME_COO_LAWSUITS",
        },
    },
}
