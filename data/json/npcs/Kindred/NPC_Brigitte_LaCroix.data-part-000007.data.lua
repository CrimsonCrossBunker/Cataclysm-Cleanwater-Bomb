local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER3",
    line = ccb.content.text("You do not realize the gravity of your claim.  When you understand the Song better, you will understand the danger of his actions."),
    replies = {
        { text = ccb.content.text("I see."), next_topic = "TALK_BONE_SEER" },
        { text = ccb.content.text("We'll see about that."), next_topic = "TALK_BONE_SEER" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_BONES",
    line = ccb.content.text("The song can be woven in many forms.  Carved bone charms, weapons and armor all hold immense power, and when the time comes, me and my Kindred shall amass enough Song to restore this world as it was before.  Restore it, or end it.  Makes no difference."),
    replies = { { text = ccb.content.text("End the world?  What?"), next_topic = "TALK_BONE_SEER_END" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_END",
    line = ccb.content.text("The Song holds immeasurable power.  A grand symphony could revert the Cataclysm - or accelerate it to a time beyond all.  But with the world looking as is, both options are preferable."),
    replies = {
        {
            text = ccb.content.text("A strange belief, but maybe there is some truth to it."),
            next_topic = "TALK_BONE_SEER_POSITIVE",
        },
        {
            text = ccb.content.text("Well, at least you're trying to help."),
            next_topic = "TALK_BONE_SEER_POSITIVE",
        },
        { text = ccb.content.text("You're nuts."), next_topic = "TALK_BONE_SEER_INSULT" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_POSITIVE",
    line = ccb.content.gendered_line("Your mind is open.  More than most.  Perhaps one day, you too will feel the power of the song and become Kindred.  For now, traveler, listen, listen and feel the song.", { "speaker" }),
    replies = { { text = ccb.content.text("I… thank you."), next_topic = "TALK_BONE_SEER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_INSULT",
    line = ccb.content.text("Your skepticism does not surprise me.  Perhaps one day, you too will hear the inevitability of the song, feel its power.  But until you do, you will remain just another survivor, path to the Kindred closed."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_BONE_SEER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_ABOUT",
    line = ccb.content.text("I grew up in Louisiana with my grandmother.  Great cook.  Made the best boudin I've ever had.  Each night, she would tell me stories; mostly folklore and myths, like about the rougarou, or the Honey Island Swamp monster but… she sometimes told me about me about the Song, and the bones.  The way she talked about it was… different, serious.  Didn't give it much thought back then; I was just a child, after all.  I moved here a few years back for work, before the Cataclysm, before everything changed.  I do miss home sometimes, but at least the rats here are smaller.  Never could stand the things.  Anyway… thank you for asking.  Been a while since I could simply talk to someone."),
    replies = {
        {
            text = ccb.content.text("Why didn't your parents raise you?"),
            next_topic = "TALK_BONE_SEER_PARENTS",
        },
        { text = ccb.content.text("What's boudin?"), next_topic = "TALK_BONE_SEER_BOUDIN" },
        {
            text = ccb.content.text("What do you mean she talked about the Song 'differently'?"),
            next_topic = "TALK_BONE_SEER_GRANDMA",
        },
        { text = ccb.content.text("What's wrong with rats?"), next_topic = "TALK_BONE_SEER_RATS" },
        {
            text = ccb.content.text("Thank you for sharing.  <done_conversation_section>"),
            next_topic = "TALK_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_PARENTS",
    line = ccb.content.text("They died when I was very young.  Car accident.  I… don't have any memories of them, but my grandmother raised me as her own."),
    replies = { { text = ccb.content.text("She sounds nice."), next_topic = "TALK_BONE_SEER_ABOUT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_BOUDIN",
    line = ccb.content.text("Spicy sausage, green onions, rice.  She'd batter and deep fry them, make boudin balls.  A dish to die for."),
    replies = {
        { text = ccb.content.text("Sounds delicious."), next_topic = "TALK_BONE_SEER_ABOUT" },
        { text = ccb.content.text("Not my kind of thing."), next_topic = "TALK_BONE_SEER_ABOUT" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_GRANDMA",
    line = ccb.content.text("Unlike the other stories, she spoke with determination, reverence even.  I didn't realize it back then but it wasn't just a story; she knew that this wasn't just another tale."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_BONE_SEER_ABOUT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_RATS",
    line = ccb.content.text("Ever since a young age, I hated rats.  Can't quite say why; they always struck me as something… foul.  I even have nightmares about them sometimes.  Not too long ago, I had one about a man-sized rat, shambling on it's hind legs.  It chased me up a tall building and then pushed me off, snickering.  Maybe the Song was trying to tell me something, but then again, maybe it was just a bad dream."),
    replies = {
        {
            text = ccb.content.text("Strange dream, but we all have fears, sometimes irrational."),
            next_topic = "TALK_BONE_SEER_ABOUT",
        },
    },
}
