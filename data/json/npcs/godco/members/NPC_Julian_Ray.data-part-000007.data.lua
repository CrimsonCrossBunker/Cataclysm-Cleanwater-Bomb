local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Riots",
    line = ccb.content.text("Well, I might as well be honest with you.  I ran mostly, ran like the devil was chasin' me.  I was at one of the police stations in town, when we were called out to handle a violent mob on the loose.  When we got there, the people were crazy, smashing and killing everything in their way.  They had these bloodshot eyes and a weird goo in their mouths.  We pulled out all the stops to handle them.  When tear gas wouldn't work, the chief told us to draw guns and kill them all.  We did…  There was so much blood…  That maneuver killed a lot of them, but not all.  One snuck up behind a lady who worked with us, tore a whole section of her spine out.  She never even had time to scream, just slumped over the cruiser door…  So I jumped post and ran, never looked back.  God, I can still hear the cries…"),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  Maybe we should change the subject."),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_backstory", "yes") },
            next_topic = "TALK_GODCO_Julian_2",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_backstory", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}
