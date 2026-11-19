local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_OUTPOST",
    line = ccb.content.text("Ya, that representative from the Old Guard asked the two of us to come out here and begin fortifying this place as a refugee camp.  I'm not sure how fast he expects the two of us to get setup, but we were assured additional men were coming out here to assist us. "),
    replies = {
        {
            text = ccb.content.text("How many refugees are you expecting?"),
            next_topic = "TALK_RANCH_FOREMAN_REFUGEES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_REFUGEES",
    line = ccb.content.gendered_line("Could easily be hundreds as far as I know.  They chose this ranch because of its rather remote location, decent fence, and huge cleared field.  With as much land as we have fenced off we could build a village if we had the materials.  We would have tried to secure a small town or something, but the lack of good farmland and number of undead makes it more practical for us to build from scratch.  The refugee center I came from is constantly facing starvation and undead assaults.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Hopefully moving out here was worth it…"),
            next_topic = "TALK_RANCH_FOREMAN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_JOB",
    line = ccb.content.text("I'm the engineer in charge of turning this place into a working camp.  This is going to be an uphill battle, we used most of our initial supplies getting here and boarding up the windows.  I've got a huge list of tasks that need to get done, so if you could help us keep supplied I'd appreciate it.  If you have material to drop off you can just back your vehicle into here and dump it on the ground, we'll sort it."),
    replies = { { text = ccb.content.text("I'll keep that in mind."), next_topic = "TALK_RANCH_FOREMAN" } },
}
