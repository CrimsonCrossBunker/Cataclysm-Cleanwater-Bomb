local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_2_STORY1",
    line = ccb.content.gendered_line("Well, I lived on the edge of a small town.  Corner store and a gas station and not much else.  We heard about the shit goin' down in the city, but we didn't see much of it until the military came blazing through and tried to set up a camp there.  They wanted to bottle us all up in town, and I wasn't having with that, so my dog Buck and I, we headed out while they were all sniffin' their own farts.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGSS_RURAL_2_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

-- TK: In a future version this NPC might give you directions to the ranch.
ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_2_STORY2",
    line = ccb.content.gendered_line("Buck and I slipped out and went East, headin' for my friend's ranch.  Cute little dope thought we were just goin' for a real long walk.  I couldn't take the truck without the army boys catchin' wind of it.  We made it out to the forest, camped out in a lean to.  Packed up and kept heading out.  At first we walked along the highway a little, but saw too many army trucks and buses full of evacuees, and that's when we found out about the <zombies>.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Where's Buck now?"), next_topic = "BGSS_RURAL_2_STORY3" },
        {
            text = ccb.content.text("I see where this is headed.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("I see where this is headed.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_2_STORY3",
    line = ccb.content.gendered_line("We got to my buddy's ranch, but the <freaking> g-men had been there first.  It was all boarded up and there was a police barricade out front.  One of those <freaking> turrets… shot Buck.  Almost got me too.  I managed to get my pup… get him outta there, that… it wasn't easy, had to use a police car door as a shield, had to kill a cop-zombie first.  And then, well, while I was still cryin', Buck came back.  I had to…  <swear!>  I… I can't say it.  You know.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I'm sorry about Buck.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("I'm sorry about Buck.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
