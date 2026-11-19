local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_OFFICE",
    line = ccb.content.text("Shady Hills Corporation.\n You are logged in as: Randolph VanBuren, Community Manager.\n\n WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("Access Messages"), next_topic = "COMP_RET_COMM_EMAILS" },
        { text = ccb.content.text("Access Main Drives"), next_topic = "COMP_RET_COMM_ERROR" },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_ERROR",
    line = ccb.content.text("ERROR ACCESSING SERVER"),
    replies = { { text = ccb.content.text("RETURN TO DESKTOP"), next_topic = "COMP_RET_COMM_OFFICE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_EMAILS",
    line = ccb.content.text("WARNING!  ERROR A101; FAILURE DETECTED IN POWER SUPPLY.\n RESERVE POWER ACTIVATED.  CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!\n\n WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n ERROR REFRESHING MESSAGES.  NOT ALL MESSAGES MAY BE DISPLAYED.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("RE: Seriously!?"),
            next_topic = "COMP_RET_COMM_EMAILS_SERIOUSLY",
        },
        {
            text = ccb.content.text("RE: Noise complaint"),
            next_topic = "COMP_RET_COMM_EMAILS_NOISE",
        },
        { text = ccb.content.text("RE: Horrible smell"), next_topic = "COMP_RET_COMM_EMAILS_SMELL" },
        {
            text = ccb.content.text("[!]RE: Important Status Update"),
            next_topic = "COMP_RET_COMM_EMAILS_STATUS",
        },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_RET_COMM_OFFICE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_EMAILS_SERIOUSLY",
    line = ccb.content.text("FROM: Jamie Forest, Community Resident, Unit A02\n  TO: Shady Hills Corporation, Service Portal\n  RE: Seriously!?\n\n My son just told me he keeps receiving advertisements in the mail for a nursing home.  He told me that your company runs it!  Are you trying to get rid of me!?  You're sick!  I demand you have your CEO call me!"),
    replies = { { text = ccb.content.text("RETURN TO MESSAGES"), next_topic = "COMP_RET_COMM_EMAILS" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_EMAILS_NOISE",
    line = ccb.content.text("FROM: Larry Landborn, Unit B11\n  TO: Shady Hills Corporation, Service Portal\n  RE: Noise complaint\n\n  Hello.  I am once again requesting your help with my neighbor in B10.  There are loud sounds from all times of day.  She claims her grandkids are visiting but the noises have been non-stop for weeks!"),
    replies = { { text = ccb.content.text("RETURN TO MESSAGES"), next_topic = "COMP_RET_COMM_EMAILS" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_EMAILS_SMELL",
    line = ccb.content.text("FROM: Sandra Shells, Unit B06\n  TO: Shady Hills Corporation, Service Portal\n  RE: Horrible smell\n\n  There's a bad smell coming from unit B07.  Please look into it.  Thanks."),
    replies = { { text = ccb.content.text("RETURN TO MESSAGES"), next_topic = "COMP_RET_COMM_EMAILS" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_EMAILS_STATUS",
    line = ccb.content.text("FROM: Kristi Gordee, SVP Operations\n  TO: [Branch Managers], [Community Managers]\n  RE: Important Status Update\n\n Everyone,\n You are to follow your appropriate lockdown protocols at your discretion.  With the recent events as they are, we must do our utmost to ensure that our goals remain priority.\n\n Branch Managers - your deliveries will have an altered schedule.  I will send a separate email with details.  Ensure the hidden safe rooms are properly secured.\n Community Managers - Lockdown the community appropriately.  Tell the residents that it is for their protection, but do not let them leave.  We need them for the Big Pappy project to be successful.  I am going to send you some contacts who can discreetly install a heavy security gate.\n\n You will continue to receive your bonus pay as agreed upon.  Do not lose sight of our important endgame."),
    replies = { { text = ccb.content.text("RETURN TO MESSAGES"), next_topic = "COMP_RET_COMM_EMAILS" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_HOME",
    line = ccb.content.text("MY PC.\n You are logged in as: ADMINISTRATOR.\n\n  WARNING!  ERROR IN POWER SUPPLY DETECTED.  RESERVE POWER ACTIVATED.  SAVE ALL WORK AND SAFELY SHUT DOWN THIS DEVICE IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("Access Messages"), next_topic = "COMP_RET_COMM_HOME_EMAILS" },
        {
            text = ccb.content.text("Connect to BINGO CHAMPIONSHIPS ONLINE"),
            next_topic = "COMP_RET_COMM_ERROR2",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_ERROR2",
    line = ccb.content.text("The webpage cannot be found :( Check your connection and try again, or contact your Internet Service Provider."),
    replies = { { text = ccb.content.text("RETURN TO DESKTOP"), next_topic = "COMP_RET_COMM_HOME" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_HOME_EMAILS",
    line = ccb.content.text("Error connecting to server.  You will be unable to send or receive new messages.  Check your connection and try again, or contact your Internet Service Provider."),
    replies = {
        {
            text = ccb.content.text("RE: Security Gate"),
            next_topic = "COMP_RET_COMM_HOME_EMAILS_GATE",
        },
        { text = ccb.content.text("RE: Survivor's Club"), next_topic = "COMP_RET_COMM_EMAILS_CLUB" },
        {
            text = ccb.content.text("RE: Your Daily BINGO News!"),
            next_topic = "COMP_RET_COMM_EMAILS_BINGO",
        },
        { text = ccb.content.text("RETURN TO MAIN PAGE"), next_topic = "COMP_RET_COMM_HOME" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_HOME_EMAILS_GATE",
    line = ccb.content.text("FROM: Randolph VanBuren, Shady Hills Community Manager\n\n  RE: Security Gate\n\n  Greetings everyone in our fine community.  I wanted to give you an update on Shady Hills' official stance on the security and safety of our esteemed residents.  We are doing everything in our power to keep you safe from harm.  We understand the news has been frightening lately with talk of violence in the streets.  Rest assured you are safe inside of our neighborhood.  Out of an abundance of caution we are installing a new front gate to the entrance of the neighborhood.  This gate will keep back even the most violent of criminals.  Should you have any questions or concerns, please contact our service portal.\n\n  Thank you for your trust in Shady Hills,\n Randolph VanBuren"),
    replies = { { text = ccb.content.text("RETURN TO MESSAGES"), next_topic = "COMP_RET_COMM_HOME_EMAILS" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_EMAILS_CLUB",
    line = ccb.content.text("FROM: Jamie Forest, Community Resident, Unit A02\n\n  RE: Survivor's Club!?\n\n  Hey there!  Thanks for your interest in our club.  We are really excited to have you!  I'll have to come check out your panic room sometime!  A few of us are going to check out the cave in the park if you want to join us.  Officially, it's supposed to be off limits, but what are they going to do about it?  I heard it even connects to the sewers, maybe if the world really goes to hell like they're all thinking, we can make use of it!  I'm kidding, I don't believe that crap."),
    replies = { { text = ccb.content.text("RETURN TO MESSAGES"), next_topic = "COMP_RET_COMM_HOME_EMAILS" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_RET_COMM_EMAILS_BINGO",
    line = ccb.content.text("FROM: BINGO CHAMPIONSHIPS ONLINE\n\n  Your Daily BINGO News!\n\n  Thank you for being a member of BINGO CHAMPIONSHIPS ONLINE!  Today we have an interview with our latest champion, WINIFRED SMITH!  Click the link below to hear her incredible story!"),
    replies = { { text = ccb.content.text("RETURN TO MESSAGES"), next_topic = "COMP_RET_COMM_HOME_EMAILS" } },
}
