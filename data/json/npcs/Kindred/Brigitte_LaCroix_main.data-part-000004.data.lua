local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_BONE_SEER_SOCIAL" },
    line = ccb.content.text("What do you need?"),
    replies = {
        {
            text = ccb.content.text("Tell me about the songs again."),
            next_topic = "TALK_BONE_SEER_SONG_FRIEND",
        },
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_BONE_SEER_ABOUT_FRIEND",
        },
        {
            text = ccb.content.text("I changed my mind, wanted to ask you something else."),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_ABOUT_FRIEND",
    line = ccb.content.text("I grew up in Louisiana with my grandmother.  Great cook.  Made the best boudin I've ever had.  Each night, she would tell me stories; mostly folklore and myths, like about the rougarou, or the Honey Island Swamp monster but… she sometimes told me about me about the Song, and the bones.  The way she talked about it was… different, serious.  Didn't give it much thought back then; I was just a child, after all.  I moved here a few years back for work, before the Cataclysm, before everything changed.  I do miss home sometimes, but at least the rats here are smaller.  Never could stand the things.  Anyway… thank you for asking.  Been a while since I could simply talk to someone."),
    replies = {
        {
            text = ccb.content.text("Why didn't your parents raise you?"),
            next_topic = "TALK_BONE_SEER_PARENTS_FRIEND",
        },
        { text = ccb.content.text("What's boudin?"), next_topic = "TALK_BONE_SEER_BOUDIN_FRIEND" },
        {
            text = ccb.content.text("What do you mean she talked about the Song 'differently'?"),
            next_topic = "TALK_BONE_SEER_GRANDMA_FRIEND",
        },
        {
            text = ccb.content.text("What's wrong with rats?"),
            next_topic = "TALK_BONE_SEER_RATS_FRIEND",
        },
        {
            text = ccb.content.text("Thank you for sharing.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_PARENTS_FRIEND",
    line = ccb.content.text("They died when I was very young.  Car accident.  I… don't have any memories of them, but my grandmother raised me as her own."),
    replies = { { text = ccb.content.text("She sounds nice."), next_topic = "TALK_BONE_SEER_ABOUT_FRIEND" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_BOUDIN_FRIEND",
    line = ccb.content.text("Spicy sausage, green onions, rice.  She'd batter and deep fry them, make boudin balls.  A dish to die for."),
    replies = {
        { text = ccb.content.text("Sounds delicious."), next_topic = "TALK_BONE_SEER_ABOUT_FRIEND" },
        {
            text = ccb.content.text("Not my kind of thing."),
            next_topic = "TALK_BONE_SEER_ABOUT_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_GRANDMA_FRIEND",
    line = ccb.content.text("Unlike the other stories, she spoke with determination, reverence even.  I didn't realize it back then but it wasn't just a story; she knew that this wasn't just another tale."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_BONE_SEER_ABOUT_FRIEND" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_RATS_FRIEND",
    line = ccb.content.text("Ever since a young age, I hated rats.  Can't quite say why; they always struck me as something… foul.  I even have nightmares about them sometimes.  Not too long ago, I had one about a man-sized rat, shambling on it's hind legs.  It chased me up a tall building and then pushed me off, snickering.  Maybe the Song was trying to tell me something, but then again, maybe it was just a bad dream."),
    replies = {
        {
            text = ccb.content.text("Strange dream, but we all have fears, sometimes irrational."),
            next_topic = "TALK_BONE_SEER_ABOUT_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG_FRIEND",
    line = ccb.content.text("Listen carefully.  The bones… they hum.  Can you hear it?  The song they weave?  The stories they hold?"),
    replies = {
        { text = ccb.content.text("Tell me more."), next_topic = "TALK_BONE_SEER_SONG2_FRIEND" },
        {
            text = ccb.content.text("Uh… yeah, sure.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
