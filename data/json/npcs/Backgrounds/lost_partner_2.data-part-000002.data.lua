local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_STORY3",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("He was at home when the bombs started dropping and the world went to hell.  I was at work.  I tried to make it to our house, but the city was a war zone.  Things I can't describe lurching through the streets, crushing people and cars.  Soldiers trying to stop them, but hitting people in the crossfire as much as anything.  And then the collateral damage would get right back up and join the enemy.  If it hadn't been for my husband, I would have just left, but I did what I could and I slipped through.  I actually made it alive."),
                no = ccb.content.text("She was at home when the bombs started dropping and the world went to hell.  I was at work.  I tried to make it to our house, but the city was a war zone.  Things I can't describe lurching through the streets, crushing people and cars.  Soldiers trying to stop them, but hitting people in the crossfire as much as anything.  And then the collateral damage would get right back up and join the enemy.  If it hadn't been for my wife, I would have just left, but I did what I could and I slipped through.  I actually made it alive."),
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
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
