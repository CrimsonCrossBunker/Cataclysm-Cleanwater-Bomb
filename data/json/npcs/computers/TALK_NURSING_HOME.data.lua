local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI",
    line = ccb.content.text("Shady Hills Corporation.\n You are logged in as: Peter St. Travers, SVP Research & Development.\n\nWARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("Access Messages"), next_topic = "COMP_NURSING_HOME_SCI_EMAILS" },
        {
            text = ccb.content.text("Access Project Database"),
            next_topic = "COMP_NURSING_HOME_SCI_PROJECTS",
        },
        {
            text = ccb.content.text("Access Encrypted Drive"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_ERROR",
    line = ccb.content.text("WARNING: Encrypted file.  Enter secure password."),
    replies = { { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_NURSING_HOME_SCI" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_EMAILS",
    line = ccb.content.text("Shady Hills Nursing Home.\n You are logged in as: Peter St. Travers, SVP Research & Development.\n\nWARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n ERROR REFRESHING MESSAGES.  NOT ALL MESSAGES MAY BE DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("RE: Shepherds"), next_topic = "COMP_NURSING_HOME_SCI_SHEPHERDS" },
        { text = ccb.content.text("RE: This is bad!"), next_topic = "COMP_NURSING_HOME_SCI_BAD" },
        { text = ccb.content.text("RE: Fix this"), next_topic = "COMP_NURSING_HOME_SCI_FIXTHIS" },
        { text = ccb.content.text("RE: Results"), next_topic = "COMP_NURSING_HOME_SCI_RESULTS" },
        { text = ccb.content.text("RE: Security"), next_topic = "COMP_NURSING_HOME_SCI_SECURITY" },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_NURSING_HOME_SCI" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_SHEPHERDS",
    line = ccb.content.text("FROM: Kristi Gordee, SVP Operations\n TO: Peter St. Travers, SVP Research & Development\n RE: Shepherds\n\n Peter,\n Leah Shepherds keeps sending me emails, and we just received the papers for yet another lawsuit.\n I don't know what you're thinking but this one is going to be really difficult and could cost us.\n The Board is going to be furious."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_SCI_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_BAD",
    line = ccb.content.text("FROM: Vincent Fuels, Researcher\n TO: Peter St. Travers, SVP Research & Development\n RE: This is bad!\n\n While you were gone last night, the old man started to wake up and become cranky.\n We had to give him another dose of that elephant tranquilizer!\n I think he might actually be strong enough to break out of his cell now.\n We really need to do something before he kills someone!\n I know this experiment meant a lot to you, but it isn't worth the risk anymore!"),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_SCI_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_FIXTHIS",
    line = ccb.content.text("FROM: Kristi Gordee, SVP Operations\n TO: Peter St. Travers, SVP Research & Development\n RE: Budget\n\n Peter,\n You need to find a way to reverse what you did ASAP.\n What exactly do you expect me to do to get us out of this?\n The police are investigating us now for foul play."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_SCI_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_RESULTS",
    line = ccb.content.text("FROM: Unknown Sender\n TO: Peter St. Travers, SVP Research & Development\n RE: Results\n\n Looking forward to your report at the next meeting.\n I put a lot on the line for you, don't disappoint me, Peter.\n Get me results."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_SCI_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_SECURITY",
    line = ccb.content.text("FROM: Will Higgins, VP Information Technology\n TO: Peter St. Travers, SVP Research & Development\n RE: Security\n\n Hello sir,\n I understand your concerns about security.  Rest assured, myself and my team take this very seriously.  I assure you that high-level encryption protects all of our systems.\n Nobody will be able to access any of our PCs without use of the owner's fingerprint authentication, even in the event that the main power supply is cut.\n Nobody unauthorized will ever be able to read our emails or documents."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_SCI_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_PROJECTS",
    line = ccb.content.text("Shady Hills Corporation.\n You are logged in as: Peter St. Travers, SVP Research & Development.\n\n WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n ERROR D766; UNABLE TO CONNECT TO MAIN SERVER.\n ERROR REFRESHING DATABASE.  ONLY CACHED INFORMATION DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("Project Procedures"),
            next_topic = "COMP_NURSING_HOME_SCI_PROCEDURES",
        },
        {
            text = ccb.content.text("Pablo Shepherds"),
            next_topic = "COMP_NURSING_HOME_SCI_PROJECTA",
        },
        { text = ccb.content.text("Nina Palmero"), next_topic = "COMP_NURSING_HOME_SCI_PROJECTB" },
        { text = ccb.content.text("Vorm E. Thracks"), next_topic = "COMP_NURSING_HOME_SCI_ERROR2" },
        {
            text = ccb.content.text("Mord R. Yuni-Korne"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR2",
        },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_NURSING_HOME_SCI" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_PROCEDURES",
    line = ccb.content.text("PROJECT PROCEDURES: Big Pappy\n PAGE 1\n\n 1) Review patients for possible induction.  As a failsafe, patients selected for this program should have minimal or no contact with outside individuals and should additionally not be removed from their assigned rooms for longer than two days.  See 'Chapter 1: Induction' for greater detail.\n 2) Administer standard alchemical dosage according to patient profile.  See 'Chapter 2: Dosages' on typical process.\n 3) Monitor results over 7 days.  Patient will remain in general population outside of scheduled physicals unless determined otherwise by SVP Research & Development.\n 4) Patients deemed unworthy for general population are to remain in Secure lab room for special monitoring.  Official documentation will denote hospitalization in this circumstance to mitigate chance of suspicion.\n 5) To ensure unbiased compliance, selected patients and their families will not be informed of this process."),
    replies = {
        {
            text = ccb.content.text("View Primary Goals"),
            next_topic = "COMP_NURSING_HOME_SCI_GOALS",
        },
        {
            text = ccb.content.text("Chapter 1: Induction"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR0",
        },
        {
            text = ccb.content.text("Chapter 2: Dosages"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR0",
        },
        {
            text = ccb.content.text("Chapter 3: Approved Serums"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR0",
        },
        {
            text = ccb.content.text("Chapter 4: Failsafe Protocol"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR0",
        },
        {
            text = ccb.content.text("RETURN TO PROJECTS"),
            next_topic = "COMP_NURSING_HOME_SCI_PROJECTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_GOALS",
    line = ccb.content.text("PROJECT PROCEDURES: Big Pappy\n Goals\n\n 1) Study effects of cognitive and physical decline in geriatric residents.\n 2) Study effects of advanced medical and mutagenic serums on select patients.\n 3) Eliminate, or reverse, the physical and mental aging process in humans."),
    replies = {
        {
            text = ccb.content.text("RETURN TO PROCEDURES"),
            next_topic = "COMP_NURSING_HOME_SCI_PROCEDURES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_PROJECTA",
    line = ccb.content.text("PROJECT CODE NAME: 'Big Pappy'\n PROJECT RESIDENT: Pablo Shepherds\n PROJECT STATUS: Active\n PROJECT START DATE: xx-xx-xxxx\n\n Entry Log 1: Started subject on assigned dosage.  Will monitor over 7 days.\n Entry Log 2: Subject within expected parameters.  Subject will remain in general population.\n Entry Log 3: Subject within expected parameters.  Subject will remain in general population.\n Entry Log 4: Subject showing signs of severe dementia.  Unexpected result.  Following removal protocol.  Moving patient to Secure room for 2 day period.\n Entry log 5: Subject stabilizing.  Attempting RA21E dosage.\n Entry Log 6: Subject within expected parameters.  Returning to general population.\n Entry Log 7: Subject within expected parameters.  Attempting Mutagenic Serum dose.  Following removal protocol.  Moving patient to Secure room for 2 day period.\n Entry Log 8: Subject has shown tremendous increase in girth and power.  Reduction in cognitive decline.  Symptoms of dementia nearly eliminated.\n Entry Log 9: Subject becoming belligerent.  Unknown cause.  Purifier Serum failing.  Initiated sedation protocol.  15mg Carfentanil required.  Initiating Failsafe protocol; subject cannot be returned to general population.\n Entry Log 10: Subject remains sedated.  Maintaining Failsafe protocol.  Attempting purifier serum trial."),
    replies = {
        { text = ccb.content.text("Add Entry Log"), next_topic = "COMP_NURSING_HOME_SCI_ERROR3" },
        {
            text = ccb.content.text("View Patient Medical History"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR3",
        },
        { text = ccb.content.text("View Dosages"), next_topic = "COMP_NURSING_HOME_SCI_ERROR3" },
        {
            text = ccb.content.text("View Mutagenic Serums"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR3",
        },
        {
            text = ccb.content.text("RETURN TO PROJECTS"),
            next_topic = "COMP_NURSING_HOME_SCI_PROJECTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_PROJECTB",
    line = ccb.content.text("PROJECT CODE NAME: 'Big Pappy'\n PROJECT RESIDENT: Nina Palmero\n PROJECT STATUS: Active\n PROJECT START DATE: xx-xx-xxxx\n\n Entry Log 1: Started subject on assigned dosage.  Will monitor over 7 days.\n Entry Log 2: Subject added to growing list of recent residents that are rejecting the dosage due to an unknown cause.  Attempting supplement of benzoylmethylecgonine to study possible results.  Will monitor over 7 days.  Maintaining subject in general population.\n Entry Log 3: Subject appears to have become obsessed with baked goods, unknown reason."),
    replies = {
        { text = ccb.content.text("Add Entry Log"), next_topic = "COMP_NURSING_HOME_SCI_ERROR4" },
        {
            text = ccb.content.text("View Patient Medical History"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR4",
        },
        { text = ccb.content.text("View Dosages"), next_topic = "COMP_NURSING_HOME_SCI_ERROR4" },
        {
            text = ccb.content.text("View Mutagenic Serums"),
            next_topic = "COMP_NURSING_HOME_SCI_ERROR4",
        },
        {
            text = ccb.content.text("RETURN TO PROJECTS"),
            next_topic = "COMP_NURSING_HOME_SCI_PROJECTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_ERROR0",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO LAST PAGE"),
            next_topic = "COMP_NURSING_HOME_SCI_PROCEDURES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_ERROR2",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO PROJECTS"),
            next_topic = "COMP_NURSING_HOME_SCI_PROJECTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_ERROR3",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO PROJECT"),
            next_topic = "COMP_NURSING_HOME_SCI_PROJECTA",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_SCI_ERROR4",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO PROJECT"),
            next_topic = "COMP_NURSING_HOME_SCI_PROJECTB",
        },
    },
}
