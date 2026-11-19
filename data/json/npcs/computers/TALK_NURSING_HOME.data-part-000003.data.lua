local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_RECEP_MANAGER",
    line = ccb.content.text("Shady Hills Nursing Home.\n You are logged in as: Bryan Rooters, Reception Manager.\n\n WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("Access Messages"), next_topic = "COMP_NURSING_HOME_MGR_EMAILS" },
        {
            text = ccb.content.text("Access Employee Files"),
            next_topic = "COMP_NURSING_HOME_MGR_RECORDS",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_EMAILS",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n ERROR REFRESHING MESSAGES.  NOT ALL MESSAGES MAY BE DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("RE: Do Your Job"),
            next_topic = "COMP_NURSING_HOME_MGR_DOYOURJOB",
        },
        {
            text = ccb.content.text("RE: Performance Evaluation"),
            next_topic = "COMP_NURSING_HOME_MGR_EVAL",
        },
        {
            text = ccb.content.text("RE: Connie Malackey"),
            next_topic = "COMP_NURSING_HOME_MGR_CONNIE",
        },
        {
            text = ccb.content.text("RE: Housekeeping"),
            next_topic = "COMP_NURSING_HOME_MGR_HOUSEKEEPING1",
        },
        {
            text = ccb.content.text("RE: Housekeeping"),
            next_topic = "COMP_NURSING_HOME_MGR_HOUSEKEEPING2",
        },
        {
            text = ccb.content.text("RETURN TO MAIN PAGE"),
            next_topic = "COMP_NURSING_HOME_RECEP_MANAGER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_DOYOURJOB",
    line = ccb.content.text("FROM: Kristi Gordee, SVP Operations\n TO: Bryan Rooters, Reception Manager\n RE: Do Your Job\n\n Bryan,\n Do you not conduct thorough background checks and reviews on new hires?  Joe is related to the Mayor of Springfield.  His 90 day New Employee evaluation is coming up.  Do your job."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_MGR_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_EVAL",
    line = ccb.content.text("FROM: Joe Shert, Receptionist\n TO: Bryan Rooters, Reception Manager\n RE: Performance Evaluation\n\n Hi Mr. Rooters, I look forward to seeing you Tuesday for my evaluation.  I've been working really hard to show that I am Shady Hills material!"),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_MGR_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_CONNIE",
    line = ccb.content.text("FROM: Kristi Gordee, SVP Operations\n TO: Bryan Rooters, Reception Manager\n RE: Connie Malackey\n\n Bryan,\n Connie has been asking a lot of weird questions about 'Ghosts' and other such nonsense.\n This could look bad for us.  To make it worse, she is hanging out with Joe Shert a lot.\n Shut it down."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_MGR_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_HOUSEKEEPING1",
    line = ccb.content.text("FROM: Joe Shert, Receptionist\n TO: Bryan Rooters, Reception Manager\n RE: Housekeeping\n\n Hi Mr. Rooters, with all due respect I feel that I may have been assigned more of these tasks than the other Receptionists.\n Jim said he hasn't had to do any cleaning in two weeks, yet I have been on cleaning duty 3 times.\n To be clear, I certainly do not mind the extra work!  I just want to ensure you're aware in case there is a computer glitch.\n Thank you and have a great day!"),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_MGR_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_HOUSEKEEPING2",
    line = ccb.content.text("FROM: Amanda Hugentskis, Receptionist\n TO: Bryan Rooters, Reception Manager\n RE: Housekeeping\n\n Seriously?  This is ridiculous.  This place was a mess even with housekeeping personnel.\n I quit."),
    replies = {
        {
            text = ccb.content.text("RETURN TO MESSAGES"),
            next_topic = "COMP_NURSING_HOME_MGR_EMAILS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_RECORDS",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR D809; UNABLE TO CONNECT TO DATABASE.\n ERROR REFRESHING DATABASE.  NOT ALL RECORDS MAY BE DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n Please select an employee record below."),
    replies = {
        {
            text = ccb.content.text("JOSEPH SHERT; RECEPTIONIST"),
            next_topic = "COMP_NURSING_HOME_MGR_JOERECORD",
        },
        {
            text = ccb.content.text("CONNIE MALACKEY; RECEPTIONIST"),
            next_topic = "COMP_NURSING_HOME_MGR_CONNIERECORD",
        },
        {
            text = ccb.content.text("AMANDA HUGENTSKIS; RECEPTIONIST"),
            next_topic = "COMP_NURSING_HOME_MGR_AMANDARECORD",
        },
        {
            text = ccb.content.text("JAMES NEONDORTHALL; RECEPTIONIST"),
            next_topic = "COMP_NURSING_HOME_MGR_ERROR",
        },
        {
            text = ccb.content.text("RETURN TO MAIN PAGE"),
            next_topic = "COMP_NURSING_HOME_RECEP_MANAGER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_ERROR",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = {
        {
            text = ccb.content.text("RETURN TO EMPLOYEES"),
            next_topic = "COMP_NURSING_HOME_MGR_RECORDS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_JOERECORD",
    line = ccb.content.text("EMPLOYEE NAME: Joseph Shert\n EMPLOYEE TITLE: Receptionist\n HIRE DATE: xx-xx-xxxx\n STATUS: Active\n REVIEW DUE: June\n\n"),
    replies = {
        {
            text = ccb.content.text("Assign Task to This Employee"),
            next_topic = "COMP_NURSING_HOME_MGR_ERROR",
        },
        {
            text = ccb.content.text("View Most Recent Evaluation"),
            next_topic = "COMP_NURSING_HOME_MGR_JOEFILE",
        },
        {
            text = ccb.content.text("Conduct an Evaluation for This Employee"),
            next_topic = "COMP_NURSING_HOME_MGR_ERROR",
        },
        {
            text = ccb.content.text("RETURN TO EMPLOYEES"),
            next_topic = "COMP_NURSING_HOME_MGR_RECORDS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_CONNIERECORD",
    line = ccb.content.text("EMPLOYEE NAME: Connie Malackey\n EMPLOYEE TITLE: Receptionist\n HIRE DATE: xx-xx-xxxx\n Status: Active\n REVIEW DUE: May\n\n"),
    replies = {
        {
            text = ccb.content.text("Assign Task to This Employee"),
            next_topic = "COMP_NURSING_HOME_MGR_ERROR",
        },
        {
            text = ccb.content.text("View Most Recent Evaluation"),
            next_topic = "COMP_NURSING_HOME_MGR_CONNIEFILE",
        },
        {
            text = ccb.content.text("Conduct an Evaluation for This Employee"),
            next_topic = "COMP_NURSING_HOME_MGR_ERROR",
        },
        {
            text = ccb.content.text("RETURN TO EMPLOYEES"),
            next_topic = "COMP_NURSING_HOME_MGR_RECORDS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_AMANDARECORD",
    line = ccb.content.text("EMPLOYEE NAME: Amanda Hugentskis\n EMPLOYEE TITLE: Receptionist\n HIRE DATE: xx-xx-xxxx\n Status: Terminated\n REVIEW DUE: December\n\n"),
    replies = {
        {
            text = ccb.content.text("Assign Task to This Employee"),
            next_topic = "COMP_NURSING_HOME_MGR_ERROR",
        },
        {
            text = ccb.content.text("View Most Recent Evaluation"),
            next_topic = "COMP_NURSING_HOME_MGR_ERROR",
        },
        {
            text = ccb.content.text("Conduct an Evaluation for This Employee"),
            next_topic = "COMP_NURSING_HOME_MGR_ERROR",
        },
        {
            text = ccb.content.text("RETURN TO EMPLOYEES"),
            next_topic = "COMP_NURSING_HOME_MGR_RECORDS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_JOEFILE",
    line = ccb.content.text("EMPLOYEE NAME: Joseph Shert\n EMPLOYEE TITLE: Receptionist\n REVIEW DATE: 06-xx-xxxx\n REVIEW BY: Bryan Rooters, Reception Manager\n\n Joseph is always on time for work and gets along well with coworkers.  However, he has trouble taking direction and often speaks out against his superiors [See attached email: Housekeeping].\n Joe speaks a big game but unfortunately does not perform to the Shady Hills standard.\n As our standard is extremely important for the health and wellbeing of our residents, I have no choice but to recommend termination.\n\n Signed,\n Bryan Rooters\n Reception Manager"),
    replies = {
        {
            text = ccb.content.text("RETURN TO RECORD"),
            next_topic = "COMP_NURSING_HOME_MGR_JOERECORD",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_NURSING_HOME_MGR_CONNIEFILE",
    line = ccb.content.text("EMPLOYEE NAME: Connie Malackey\n EMPLOYEE TITLE: Receptionist\n REVIEW DATE: 05-xx-xxxx\n REVIEW BY: Bryan Rooters, Reception Manager\n\n Connie gets along well with coworkers.  I have occasionally needed to remind her to start work on time as clocking in late is detrimental to other employees and, ultimately, our precious residents.  Connie works hard on assigned tasks but often lacks the drive to seek out additional tasks.\n I am recommending a generous 0.5% pay wage increase per corporate policy.\n\n Signed,\n Bryan Rooters\n Reception Manager"),
    replies = {
        {
            text = ccb.content.text("RETURN TO RECORD"),
            next_topic = "COMP_NURSING_HOME_MGR_CONNIERECORD",
        },
    },
}
