local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_STORY1",
    line = ccb.content.text("Oh, man.  I thought I was ready.  I had it all planned out.  Supplies ready.  Loaded guns.  Maps of escape routes.  A hideout in the woods ready to go."),
    replies = {
        {
            text = ccb.content.text("Sounds like it didn't work out."),
            next_topic = "BGSS_PREPPER_2_STORY2",
        },
        {
            text = ccb.content.text("Hey, I'd really be interested in seeing those maps."),
            next_topic = "BGSS_PREPPER_2_NOSALE",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_STORY2",
    line = ccb.content.text("Depends on your definition.  I'm alive, aren't I?  When Hell itself came down from the skies and monsters started attacking the cities, I grabbed my stuff and got to my hideout.  But I still saw some stuff from where I was.  I watched those things stride past.  I still have nightmares about the way their bodies moved, like they broke the world just to be here.  I had nothing better to do.  I watched them rip up those goons with weapons, watched the dead rise back up and start fighting the living.  I watched a nice old lady rip the head off a dog.  I saw a body twitch and grow into some kind of electrified hulk beast.  I watched it all happen."),
    replies = {
        {
            text = ccb.content.text("Why did you leave your hideout?"),
            next_topic = "BGSS_PREPPER_2_STORY3",
        },
        {
            text = ccb.content.text("Hey, I'd really be interested in seeing those maps."),
            next_topic = "BGSS_PREPPER_2_NOSALE",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_STORY3",
    line = ccb.content.text("Honestly?  I was planning to die.  After what I'd seen, I went a little crazy.  I thought it was over for sure, I figured there was no point in fighting it.  I thought I wouldn't last a minute out here, but I couldn't bring myself to end it back there.  I headed out, planning to let the <zombies> finish me off, but what can I say?  Survival instinct is a funny thing, and I killed the ones outside the hideout.  I guess the adrenaline was what I needed.  It's kept me going since then."),
    replies = {
        {
            text = ccb.content.text("Hey, I'd really be interested in seeing those maps."),
            next_topic = "BGSS_PREPPER_2_NOSALE",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")),
        },
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("Thanks for telling me that.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
