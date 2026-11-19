local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Mood",
    line = ccb.content.text("My take?  You already know how things are.  People are dead, my friends are dead, so yeah.  At least there's no school, the adults just love reminding me that.  You know what?  I kinda miss school."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Story",
    line = ccb.content.text("I was in high school, like anyone else my age.  Then out of nowhere, my mom pulled me out of school to \"save me\".  I got packed into a bus with my parents and their old-timey friends.  We've been stuck here ever since.  Actually, it's not all that bad.  I'm studying to be a herbalist like Kostas, which is cool I guess."),
    replies = {
        {
            text = ccb.content.text("Tell me about your parents."),
            next_topic = "TALK_GODCO_Jeremiah_Parents",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
