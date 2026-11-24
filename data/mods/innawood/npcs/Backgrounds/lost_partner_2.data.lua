local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_STORY3",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("He was alone when the fires started and the world went to hell.  I was working on something.  I tried to make it to him, but the whole area was a war zone.  Things I can't describe lurching along, crushing people and worse.  Some people were trying to stop them, but hitting other people trying to get away as much as anything.  And then the collateral damage would get right back up and join the enemy.  If it hadn't been for my husband, I would have just left, but I did what I could and I slipped through.  I actually <freaking> made it alive."),
                no = ccb.content.text("She was alone when the fires started and the world went to hell.  I was working on something.  I tried to make it to her, but the whole area was a war zone.  Things I can't describe lurching along, crushing people and worse.  Some people were trying to stop them, but hitting other people trying to get away as much as anything.  And then the collateral damage would get right back up and join the enemy.  If it hadn't been for my wife, I would have just left, but I did what I could and I slipped through.  I actually <freaking> made it alive."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("You must have seen some shit."),
            next_topic = "BGSS_LOST_PARTNER_2_SOMESHIT",
        },
        {
            text = ccb.content.text("I take it home was bad."),
            next_topic = "BGSS_LOST_PARTNER_2_HOME1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_SOMESHIT",
    line = ccb.content.text("Yeah.  I really did.  And I got scared.  I ran out into the woods to get away from all of the violence and death to try and make a plan to figure out how to get home and get safe.  But then when I was finally ready to face off against the monsters everything was still and the woods stretched on and on.  I don't know what happened."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
