local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEPTIONIST",
    line = ccb.content.text("Shady Hills Nursing Home.\n You are logged in as: Joe Shert, Receptionist.\n\nWARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("Access Messages"),
            next_topic = "COMP_NURSING_HOME_RECEP_EMAILS",
        },
        {
            text = ccb.content.text("Access Assigned Tasks"),
            next_topic = "COMP_NURSING_HOME_RECEP_TASKS",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_EMAILS",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n ERROR REFRESHING MESSAGES.  NOT ALL MESSAGES MAY BE DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("RE: Ghosts!?"), next_topic = "COMP_NURSING_HOME_RECEP_GHOSTS" },
        {
            text = ccb.content.text("RE: Performance Evaluation"),
            next_topic = "COMP_NURSING_HOME_RECEP_EVAL",
        },
        {
            text = ccb.content.text("RE: Mrs.  Palmero"),
            next_topic = "COMP_NURSING_HOME_RECEP_PALMERO",
        },
        {
            text = ccb.content.text("RE: Housekeeping"),
            next_topic = "COMP_NURSING_HOME_RECEP_HOUSEKEEPING",
        },
        {
            text = ccb.content.text("RETURN TO MAIN PAGE"),
            next_topic = "COMP_NURSING_HOME_RECEPTIONIST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_GHOSTS",
    line = ccb.content.text("FROM: Connie Malackey, Receptionist\n TO: Joe Shert, Receptionist\n RE: Ghosts!?\n\n Joe!  After we heard those weird noises the other night, I talked to some of the nurses.\n We aren't the only ones!  Everyone has heard weird noises coming from the walls.\n Do you think this place is haunted!?"),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_RECEP_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_EVAL",
    line = ccb.content.text("FROM: Bryan Rooters, Reception Manager\n TO: Joe Shert, Receptionist\n RE: Performance Eval\n\n Hi Joe.\n Your 90-day performance evaluation is due.  Please plan to meet with me in my office on Tuesday.\n Thanks."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_RECEP_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_HOUSEKEEPING",
    line = ccb.content.text("FROM: Bryan Rooters, Reception Manager\n TO: Receptionists\n RE: Housekeeping\n\n Hi team,\n Please be aware that the decision has been made to let go some of the housekeeping staff.\n This decision was made by management to ensure that our operation can run as smoothly and efficiently as possible by passing on these cost savings to the residents.\n To keep up with our high standards of elder care, I will be assigning some additional small tasks to you in the near future.\n As you know, here at Shady Hills we value each and every employee and see this as an excellent opportunity to grow, learn, and provide for the Shady Hills family.\n Please let me know if you have any questions.\n Thanks."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_RECEP_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_PALMERO",
    line = ccb.content.text("FROM: Connie Malackey, Receptionist\n TO: Joe Shert, Receptionist\n RE: Mrs.  Palmero\n\n Hi Joe.\n So - you know how Mrs.  Palmero has been acting weird and constantly talking about baking cookies?\n I was talking to one of the nurses and they said that Mrs.  Palmero was prescribed this new medicine?\n It's this weird powder stuff.  Apparently the nurses aren't even qualified to give it to her - she needs a special doctor to come in every day!\n Crazy, right?  I wish all I had to worry about was baking cookies…"),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_RECEP_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_TASKS",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR C310; UNABLE TO CONNECT TO SCHEDULING SERVER.\n ERROR REFRESHING TASKS.  NOT ALL TASKS MAY BE DISPLAYED.\n REPORT COMPLETED TASKS DIRECTLY TO SUPERVISOR VIA MESSAGING SYSTEM.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("New Assignments [1]"),
            next_topic = "COMP_NURSING_HOME_RECEP_NEWTASKS",
        },
        {
            text = ccb.content.text("Pending Assignments"),
            next_topic = "COMP_NURSING_HOME_RECEP_ERROR",
        },
        {
            text = ccb.content.text("Completed Assignments"),
            next_topic = "COMP_NURSING_HOME_RECEP_ERROR",
        },
        {
            text = ccb.content.text("RETURN TO MAIN PAGE"),
            next_topic = "COMP_NURSING_HOME_RECEPTIONIST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_ERROR",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO ASSIGNED TASKS"),
            next_topic = "COMP_NURSING_HOME_RECEP_TASKS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_NEWTASKS",
    line = ccb.content.text("Welcome Joe to Shady Hills Assignment Database,\n\n You have [1] new task(s) assigned to you by your supervisor.\n When you have completed each task, be sure to submit them for approval."),
    replies = {
        {
            text = ccb.content.text("Clean Bathrooms [NEW!]"),
            next_topic = "COMP_NURSING_HOME_RECEP_CLEAN",
        },
        {
            text = ccb.content.text("RETURN TO ASSIGNED TASKS"),
            next_topic = "COMP_NURSING_HOME_RECEP_TASKS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_CLEAN",
    line = ccb.content.text("TASK: Clean Bathrooms\n Assigned to: Joe Shert, Reception\n Assigned by: Bryan Rooters, Reception Manager\n Priority: High\n Due in: 1 Day\n\n Notes: Clean each bathroom stall and refresh toilet paper."),
    replies = {
        {
            text = ccb.content.text("Set Task to Completed"),
            next_topic = "COMP_NURSING_HOME_RECEP_ERROR",
        },
        { text = ccb.content.text("Add Comment"), next_topic = "COMP_NURSING_HOME_RECEP_ERROR" },
        {
            text = ccb.content.text("RETURN TO ASSIGNED TASKS"),
            next_topic = "COMP_NURSING_HOME_RECEP_TASKS",
        },
    },
}
