local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Background_B",
    line = ccb.content.text("No, not great.  Like all here, I have lost too much.  I do not feel I can ever come back from it.  Can anyone be strong enough?"),
    replies = {
        {
            text = ccb.content.text("What have you lost, if it's okay for me to ask?"),
            next_topic = "TALK_REFUGEE_Boris_Background_loss",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Background_loss",
    line = ccb.content.text("I would rather talk about what I have left: my husband, Stan, and his brother Garry, my best friend.  Without them, I'd be lost myself.  What we've lost is more than anyone should have to think about."),
    replies = {
        {
            text = ccb.content.text("I'm sorry.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'm sorry.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Son",
    line = ccb.content.text("…Ash.  His name was Ash, and he was ten years old.  Such a light, a spark.  I wanted to see the man he would grow into.  I… now I can barely say his name.  I miss him so much, every instant.  If I did not have Stan, I would walk out through the barbed wire and join the walking dead."),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  Tell me more about Ash."),
            next_topic = "TALK_REFUGEE_Boris_Son_Remember",
        },
        {
            text = ccb.content.text("We've all lost a lot of people.  You can either let yourself die, or learn to survive."),
            next_topic = "TALK_REFUGEE_Boris_Son_Tough",
        },
        {
            text = ccb.content.text("I'm so sorry, man.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Son_Remember",
    line = ccb.content.text("I could talk forever, but it's hard to make the words come.  He was so *smart*.  Always on the computer, writing stories and programming silly games in Scratch.  He had a little robotics toy he made walk around and do funny dances.  It was a challenge to make him play with his friends sometimes, he would get so far into himself and buried in that thing.  So tough to be a parent, you know?  It is good for him to write, to learn, but he also needs to socialize and have friends.  He'll grow out… he…"),
    replies = {
        {
            text = ccb.content.text("Do you have any of his writing?"),
            next_topic = "TALK_REFUGEE_Boris_Son_Writing",
        },
        {
            text = ccb.content.text("We've all lost a lot of people.  You can either let yourself die, or learn to survive."),
            next_topic = "TALK_REFUGEE_Boris_Son_Tough",
        },
        {
            text = ccb.content.text("I'm so sorry, man.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Son_Tough",
    line = ccb.content.text("Of course, yes.  I know this, but it is not so easy, is it?  So many are gone, and I do not know which of the two I would prefer, just yet."),
    replies = {
        {
            text = ccb.content.text("Yeah, fine.  Just wallow in it.  I'm out."),
            next_topic = "TALK_DONE",
        },
    },
}

-- TK add a quest.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Son_Writing",
    line = ccb.content.text("No.  In the evacuation shelter, distracted by grief, I forgot it.  We were rushed onto the bus so quickly, and… well, I don't remember much of that time.  His work was all saved on the hard drive, we thought we could download it from the cloud when we arrived but, well, there is no cloud now.  Even if there were, it would only have his writing, not his little games, his silly voice recordings."),
    replies = {
        {
            text = ccb.content.text("I'm so sorry, man.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
